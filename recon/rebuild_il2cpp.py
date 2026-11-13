#!/usr/bin/env python3
"""Rebuild the decrypted GameAssembly image and locate IL2CPP registrations.

Uses the existing rx/rdata/data snapshots and maps from the same capture.
Searches byte patterns in native code (bytes.find), then checks complete tables.
No GDB, live process, or guessed typesCount/field count is needed.
"""
import argparse
import json
import struct
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def matches(data, needle):
    start = 0
    while (start := data.find(needle, start)) >= 0:
        if start % 8 == 0:
            yield start
        start += 1


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("binary", type=Path, help="original GameAssembly.dll, for its PE header")
    ap.add_argument("--snapshot-dir", type=Path, default=ROOT / "dump")
    ap.add_argument("--maps", type=Path, default=ROOT / "dump/maps_395969.txt")
    ap.add_argument("--metadata", type=Path, default=ROOT / "dump/global-metadata.dec.dat")
    ap.add_argument("--output", type=Path, default=ROOT / "il2cpp_verified")
    args = ap.parse_args()
    started = time.monotonic()
    original = args.binary.read_bytes()
    meta = args.metadata.read_bytes()
    sanity, version = struct.unpack_from("<II", meta)
    if sanity != 0xFAB11BAF or version != 31:
        raise ValueError("this capture adapter expects metadata v31")
    type_bytes, = struct.unpack_from("<I", meta, 0xA4)
    image_bytes, = struct.unpack_from("<I", meta, 0xAC)
    if type_bytes % 88 or image_bytes % 40:
        raise ValueError("metadata table sizes do not match the v31 layout")
    type_count, image_count = type_bytes // 88, image_bytes // 40
    bases = []
    for line in args.maps.read_text().splitlines():
        fields = line.split()
        if len(fields) >= 6 and fields[-1].endswith("/GameAssembly.dll") and int(fields[2], 16) == 0:
            bases.append(int(fields[0].split("-")[0], 16))
    if len(bases) != 1:
        raise ValueError(f"expected one GameAssembly header mapping, found {bases}")
    base = bases[0]
    pe, = struct.unpack_from("<I", original, 0x3C)
    optional = pe + 24
    image_size, = struct.unpack_from("<I", original, optional + 56)
    headers_size, = struct.unpack_from("<I", original, optional + 60)
    section_count, = struct.unpack_from("<H", original, pe + 6)
    optional_size, = struct.unpack_from("<H", original, pe + 20)
    table = optional + optional_size
    image = bytearray(image_size)
    image[:headers_size] = original[:headers_size]
    struct.pack_into("<Q", image, optional + 24, base)
    sections = {}
    for i in range(section_count):
        off = table + i * 40
        name = original[off:off + 8].rstrip(b"\x00").decode()
        size, rva = struct.unpack_from("<II", original, off + 8)
        sections[name] = (rva, size)
        struct.pack_into("<II", image, off + 16, size, rva)
    rdata_rva, _ = sections[".rdata"]
    data_rva, _ = sections[".data"]
    for filename, rva in (("rx_region.bin", sections[".text"][0]),
                          ("rdata_region.bin", rdata_rva), ("data_region.bin", data_rva)):
        blob = (args.snapshot_dir / filename).read_bytes()
        if rva + len(blob) > image_size:
            raise ValueError(f"{filename} extends beyond the PE image")
        image[rva:rva + len(blob)] = blob
    rdata = (args.snapshot_dir / "rdata_region.bin").read_bytes()

    def mapped(pointer, size=1):
        return any(base + rva <= pointer and pointer + size <= base + rva + n
                   for rva, n in (sections[".rdata"], sections[".data"]))

    def qword(pointer):
        return struct.unpack_from("<Q", image, pointer - base)[0]

    metadata_hits = []
    for hit in matches(rdata, struct.pack("<Q", type_count)):
        start = hit - 80
        if start < 0 or start + 128 > len(rdata):
            continue
        values = struct.unpack_from("<16Q", rdata, start)
        if values[12] != type_count:
            continue
        if not all(mapped(values[i + 1], values[i] * 8) for i in (0, 2, 6, 10, 12)):
            continue
        metadata_hits.append((base + rdata_rva + start, values))

    code_hits = []
    for hit in matches(rdata, struct.pack("<Q", image_count)):
        start = hit - 120
        if start < 0 or start + 136 > len(rdata):
            continue
        values = struct.unpack_from("<17Q", rdata, start)
        if not mapped(values[16], image_count * 8):
            continue
        names = []
        for i in range(image_count):
            module = qword(values[16] + i * 8)
            if not mapped(module, 16):
                break
            pointer = qword(module)
            if not mapped(pointer):
                break
            begin = pointer - base
            end = image.find(b"\x00", begin, begin + 256)
            if end < 0:
                break
            name = bytes(image[begin:end]).decode("ascii", "replace")
            if not (name.endswith(".dll") or name == "__Generated"):
                break
            names.append(name)
        if len(names) == image_count and len(set(names)) == image_count:
            code_hits.append((base + rdata_rva + start, values, names))
    if len(metadata_hits) != 1 or len(code_hits) != 1:
        raise ValueError(f"ambiguous registration search: metadata={len(metadata_hits)}, code={len(code_hits)}")
    mr, mv = metadata_hits[0]
    cr, cv, modules = code_hits[0]
    args.output.mkdir(parents=True, exist_ok=True)
    (args.output / "GameAssembly.dll").write_bytes(image)
    result = {"image_base": hex(base), "metadata_version": version,
              "code_registration": hex(cr), "metadata_registration": hex(mr),
              "types_count": mv[6], "field_offsets_count": mv[10],
              "type_definitions_count": mv[12], "image_count": image_count,
              "code_registration_words": [hex(v) for v in cv],
              "metadata_registration_words": [hex(v) for v in mv], "modules": modules,
              "elapsed_seconds": round(time.monotonic() - started, 3)}
    (args.output / "registrations.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({k: v for k, v in result.items() if not isinstance(v, list)}, indent=2))


if __name__ == "__main__":
    main()
