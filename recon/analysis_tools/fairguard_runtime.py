"""Offline emulation of a captured FairGuard bundle transform.

This is a snapshot-specific adapter, not a claimed reimplementation of the
cipher. A matching JSON profile supplies its addresses and snapshot checksum.
Only allocator, deallocator and stack-cookie helpers are replaced. No code runs
inside the game, and the emulator never reads a live process.
"""
from __future__ import annotations

import hashlib
import json
import struct
from pathlib import Path


class FairGuardTransform:
    def __init__(self, snapshot: str | Path):
        self.path = Path(snapshot)
        self.profile = json.loads(self.path.with_suffix(".json").read_text())
        self.snapshot = self.path.read_bytes()
        if hashlib.sha256(self.snapshot).hexdigest() != self.profile["sha256"]:
            raise ValueError("FairGuard snapshot checksum does not match its profile")
        self._machine = None
        self._dirty_pages = set()
        self._heap_next = 0x300000000

    def __call__(self, raw: bytes) -> bytes:
        from unicorn import Uc, UC_ARCH_X86, UC_MODE_64, UC_HOOK_CODE, UC_HOOK_MEM_WRITE
        from unicorn.x86_const import (
            UC_X86_REG_CR4, UC_X86_REG_RAX, UC_X86_REG_RCX,
            UC_X86_REG_RDX, UC_X86_REG_RFLAGS, UC_X86_REG_RIP, UC_X86_REG_RSP,
        )

        # All game addresses belong to the captured image. Private scratch
        # memory is isolated from it and is discarded after each invocation.
        stack, heap, source, sentinel = 0x200000000, 0x300000000, 0x400000000, 0x500000000
        limit = min(len(raw), self.profile["transform_limit"])
        if limit < 32:
            return raw
        base = self.profile["image_base"]
        fresh = self._machine is None
        if fresh:
            uc = Uc(UC_ARCH_X86, UC_MODE_64)
            uc.mem_map(base, (len(self.snapshot) + 4095) & ~4095)
            uc.mem_write(base, self.snapshot)
            for address, size in ((stack, 2 << 20), (heap, 16 << 20), (source, 4096), (sentinel, 4096)):
                uc.mem_map(address, size)
            uc.reg_write(UC_X86_REG_CR4, uc.reg_read(UC_X86_REG_CR4) | 0x200)
            self._context = uc.context_save()
            self._machine = uc
        else:
            uc = self._machine
            # Preserve translated code, but give each call exactly the original
            # registers, image data and zeroed scratch memory.
            for page in self._dirty_pages:
                offset = page - base
                uc.mem_write(page, self.snapshot[offset:offset + 4096])
            self._dirty_pages.clear()
            uc.mem_write(stack, bytes(2 << 20))
            uc.mem_write(heap, bytes(self._heap_next - heap))
            uc.mem_write(source, bytes(4096))
            uc.context_restore(self._context)
        self._heap_next = heap
        uc.mem_write(source, raw[:limit])
        sp = stack + (1 << 20) - 8
        uc.mem_write(sp, struct.pack("<Q", sentinel))
        uc.reg_write(UC_X86_REG_RSP, sp)
        uc.reg_write(UC_X86_REG_RCX, source)
        uc.reg_write(UC_X86_REG_RDX, limit)
        uc.reg_write(UC_X86_REG_RFLAGS, 0x202)
        uc.reg_write(UC_X86_REG_CR4, uc.reg_read(UC_X86_REG_CR4) | 0x200)
        def stub(u, address, size, data):
            result = 0
            if address == base + self.profile["allocator_rva"]:
                n = u.reg_read(UC_X86_REG_RCX)
                result = self._heap_next
                self._heap_next += (n + 31) & ~15
                if self._heap_next >= heap + (16 << 20):
                    raise ValueError("FairGuard emulator heap exhausted")
            rsp = u.reg_read(UC_X86_REG_RSP)
            target, = struct.unpack("<Q", u.mem_read(rsp, 8))
            u.reg_write(UC_X86_REG_RAX, result)
            u.reg_write(UC_X86_REG_RSP, rsp + 8)
            u.reg_write(UC_X86_REG_RIP, target)

        if fresh:
            for key in ("allocator_rva", "deallocator_rva", "cookie_check_rva"):
                address = base + self.profile[key]
                uc.hook_add(UC_HOOK_CODE, stub, begin=address, end=address)

            def dirty(u, access, address, size, value, data):
                self._dirty_pages.add(address & ~4095)
                self._dirty_pages.add((address + size - 1) & ~4095)

            uc.hook_add(UC_HOOK_MEM_WRITE, dirty, begin=base, end=base + len(self.snapshot) - 1)
        uc.emu_start(base + self.profile["entry_rva"], sentinel,
                     timeout=5_000_000)
        if uc.reg_read(UC_X86_REG_RIP) != sentinel:
            raise RuntimeError("FairGuard emulation did not reach the return address")
        return bytes(uc.mem_read(source, limit)) + raw[limit:]
