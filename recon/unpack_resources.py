#!/usr/bin/env python3
"""Restore local YooAsset bundles and export TextAssets by serialized length.

Uses the captured FairGuard transform offline; no running game is required.
Writes a manifest of input/output hashes, Unity object counts and failures.
"""
import argparse
import hashlib
import json
import signal
import sys
import time
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from analysis_tools.fairguard import FairGuardBundle
from analysis_tools.fairguard_runtime import FairGuardTransform
import UnityPy


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("input", type=Path, help="YooAsset root, a bundle directory, or one __data file")
    ap.add_argument("output", type=Path)
    ap.add_argument("--snapshot", type=Path, default=ROOT / "dump/FairGuard.mem.bin")
    ap.add_argument("--resume", action="store_true", help="复用已恢复且可校验的 bundle")
    args = ap.parse_args()
    transform = FairGuardTransform(args.snapshot)
    files = sorted(args.input.rglob("__data")) if args.input.is_dir() else [args.input]
    # Export code/configuration early; the much larger asset corpus follows.
    files.sort(key=lambda p: (0 if "Dll" in p.parts else 1 if "ClientStatic" in p.parts else 2, str(p)))
    args.output.mkdir(parents=True, exist_ok=True)
    manifest = {"snapshot_sha256": transform.profile["sha256"], "bundles": [], "failures": []}
    started = time.monotonic()
    stopping = False

    def request_stop(signum, frame):
        nonlocal stopping
        stopping = True

    signal.signal(signal.SIGINT, request_stop)
    ledger = args.output / "progress.jsonl"
    for index, path in enumerate(files, 1):
        relative = path.relative_to(args.input) if args.input.is_dir() else Path(path.name)
        outdir = args.output / relative.parent
        try:
            bundle = FairGuardBundle(str(path))
            info = bundle.parse()
            cached = outdir / "restored.bundle"
            if args.resume and cached.exists():
                restored = cached.read_bytes()
                start = info["data_start"]
                end = start + min(info["blocks"][0][1], transform.profile["transform_limit"])
                if (len(restored) != len(bundle.raw) or restored[:start] != bundle.raw[:start]
                        or restored[end:] != bundle.raw[end:]):
                    restored = bundle.restore(info, transform)
                else:
                    check = FairGuardBundle(str(cached))
                    if any(b is None for b in check.extract_blocks(check.parse())):
                        restored = bundle.restore(info, transform)
            else:
                restored = bundle.restore(info, transform)
            env = UnityPy.load(restored)
            outdir.mkdir(parents=True, exist_ok=True)
            (outdir / "restored.bundle").write_bytes(restored)
            counts = Counter()
            exports = []
            names = set()
            for obj in env.objects:
                counts[obj.type.name] += 1
                if obj.type.name != "TextAsset":
                    continue
                data = obj.read()
                content = data.m_Script.encode("utf8", "surrogateescape")
                # Prevent names in an external bundle from escaping its folder.
                name = data.m_Name.replace("/", "_").replace("\\", "_")
                if name in ("", ".", ".."):
                    name = str(obj.path_id)
                target = outdir / "TextAssets" / name
                if name in names:
                    target = target.with_name(f"{obj.path_id}_{name}")
                names.add(name)
                target.parent.mkdir(exist_ok=True)
                target.write_bytes(content)
                exports.append({"name": data.m_Name, "path_id": obj.path_id,
                                "file": str(target.relative_to(args.output)),
                                "size": len(content), "sha256": sha256(content)})
            record = {"input": str(path), "output": str(outdir.relative_to(args.output)),
                                        "input_sha256": sha256(bundle.raw),
                                        "restored_sha256": sha256(restored),
                                        "blocks": len(info["blocks"]), "objects": dict(counts),
                                        "exports": exports}
            manifest["bundles"].append(record)
            with ledger.open("a") as log:
                log.write(json.dumps(record, ensure_ascii=False) + "\n")
        except Exception as exc:
            manifest["failures"].append({"input": str(path), "error": f"{type(exc).__name__}: {exc}"})
            print(f"FAILED {path}: {exc}", flush=True)
        if index % 100 == 0 or index == len(files) or stopping:
            print(f"{index}/{len(files)} bundles, {len(manifest['failures'])} failures, "
                  f"{time.monotonic() - started:.1f}s", flush=True)
        if stopping:
            break
    manifest["input_count"] = len(files)
    manifest["complete"] = len(manifest["bundles"]) + len(manifest["failures"]) == len(files)
    manifest["elapsed_seconds"] = round(time.monotonic() - started, 3)
    (args.output / "manifest.json").write_text(json.dumps(manifest, indent=2, ensure_ascii=False) + "\n")
    return bool(manifest["failures"]) or not manifest["complete"]


if __name__ == "__main__":
    sys.exit(main())
