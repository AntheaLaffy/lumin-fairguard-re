"""标准 UnityFS 解析及 Lumin/FairGuard 资源恢复。

大端头和 CAB-* 节点都是 Unity 标准格式。当前样本的保护在压缩流开头，
运行时 read hook 最多变换 0x500 字节；不能删除所谓的“8 字节魔数”。
具体变换可用 fairguard_runtime 中的已捕获代码离线执行。
"""

from __future__ import annotations

import io
import struct

import lz4.block

class FairGuardBundle:
    def __init__(self, path: str):
        with open(path, "rb") as fh:
            self.raw = fh.read()

    def parse(self) -> dict:
        d = self.raw
        pos = 0

        def cstr():
            nonlocal pos
            end = d.index(b"\x00", pos)
            v = d[pos:end].decode("latin1")
            pos = end + 1
            return v

        sig = cstr()
        if sig != "UnityFS":
            raise ValueError(f"不是 UnityFS bundle: {sig!r}")
        ver, = struct.unpack_from(">I", d, pos); pos += 4
        vplayer = cstr()
        vengine = cstr()
        size, = struct.unpack_from(">Q", d, pos); pos += 8
        csz, = struct.unpack_from(">I", d, pos); pos += 4
        usz, = struct.unpack_from(">I", d, pos); pos += 4
        flags, = struct.unpack_from(">I", d, pos); pos += 4
        if size != len(d):
            raise ValueError(f"bundle 长度不符: header={size}, file={len(d)}")
        if ver >= 7:
            pos = (pos + 15) & ~15
        comp = flags & 0x3F
        info_pos = len(d) - csz if flags & 0x80 else pos
        raw_bi = d[info_pos:info_pos + csz]
        if comp == 0:
            bi = raw_bi
        elif comp in (2, 3):
            bi = lz4.block.decompress(raw_bi, uncompressed_size=usz)
        else:
            raise ValueError(f"blocksinfo 压缩方式 {comp} 未处理")
        r = io.BytesIO(bi)
        h = r.read(16)
        n, = struct.unpack(">I", r.read(4))
        blocks = [struct.unpack(">IIH", r.read(10)) for _ in range(n)]
        nn, = struct.unpack(">I", r.read(4))
        nodes = []
        for _ in range(nn):
            off, sz, fl = struct.unpack(">QQI", r.read(20))
            name = b""
            while True:
                b = r.read(1)
                if not b or b == b"\x00":
                    break
                name += b
            nodes.append({"offset": off, "size": sz, "flags": fl, "name": name.decode("latin1")})
        data_start = pos if flags & 0x80 else pos + csz
        if flags & 0x200:
            data_start = (data_start + 15) & ~15
        return {
            "signature": sig, "version": ver, "player": vplayer, "engine": vengine,
            "size": size, "blocksinfo_compressed": csz, "flags": flags,
            "blocks": blocks, "nodes": nodes, "data_start": data_start,
        }

    def extract_blocks(self, info: dict, keystream: bytes | None = None, *, transform=None) -> list[bytes | None]:
        """每块只解压一次；缺少解密方式时首块返回 None，不能冒充完整明文。"""
        d = self.raw
        out = []
        p = info["data_start"]
        for i, (u, c, f) in enumerate(info["blocks"]):
            raw = d[p:p + c]
            if len(raw) != c:
                raise ValueError(f"block[{i}] 数据被截断")
            comp = f & 0x3F
            if comp == 0:
                if len(raw) != u:
                    raise ValueError(f"block[{i}] 未压缩块长度不符")
                out.append(raw)
            elif comp in (2, 3):
                try:
                    block = lz4.block.decompress(raw, uncompressed_size=u)
                except lz4.block.LZ4BlockError:
                    if transform is not None:
                        body = transform(raw)
                    elif i == 0 and keystream is not None:
                        if len(keystream) < c:
                            raise ValueError("密钥流必须覆盖完整首块，不能截短输入")
                        body = bytes(a ^ b for a, b in zip(raw, keystream))
                    elif i == 0:
                        out.append(None)
                        p += c
                        continue
                    else:
                        raise
                    block = lz4.block.decompress(body, uncompressed_size=u)
                if len(block) != u:
                    raise ValueError(f"block[{i}] 解压长度不符: {len(block)} != {u}")
                out.append(block)
            else:
                raise ValueError(f"block[{i}] 压缩方式 {comp} 未处理")
            p += c
        return out

    def stream(self, info: dict, keystream: bytes | None = None, *, transform=None, allow_partial=False) -> bytes:
        """拼接解压数据；只有显式 allow_partial 才允许未知区补零。"""
        parts = []
        blocks = self.extract_blocks(info, keystream, transform=transform)
        for (u, _, _), blk in zip(info["blocks"], blocks):
            if blk is None and not allow_partial:
                raise ValueError("首块未解密；提供 --snapshot 或显式请求部分数据")
            parts.append(blk if blk is not None else b"\x00" * u)
        return b"".join(parts)

    def restore(self, info: dict, transform) -> bytes:
        """恢复原位加密的压缩块，输出可由标准 Unity 工具读取的 UnityFS。"""
        result = bytearray(self.raw)
        pos = info["data_start"]
        for i, (u, c, flags) in enumerate(info["blocks"]):
            raw = self.raw[pos:pos + c]
            comp = flags & 0x3F
            if comp in (2, 3):
                try:
                    plain = lz4.block.decompress(raw, uncompressed_size=u)
                except lz4.block.LZ4BlockError:
                    raw = transform(raw)
                    plain = lz4.block.decompress(raw, uncompressed_size=u)
                    if len(raw) != c:
                        raise ValueError(f"block[{i}] 变换改变了压缩块长度")
                    result[pos:pos + c] = raw
                if len(plain) != u:
                    raise ValueError(f"block[{i}] 解压长度不符")
            elif comp != 0:
                raise ValueError(f"block[{i}] 压缩方式 {comp} 未处理")
            elif len(raw) != u:
                raise ValueError(f"block[{i}] 未压缩块长度不符")
            pos += c
        return bytes(result)
