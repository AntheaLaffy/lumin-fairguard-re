# 时叶 · Chronoleaf

> 让《绿梦：时空之声》在 Linux 上生长。

时叶是《绿梦：时空之声》的 Linux 原生客户端重写项目，目标是让游戏在 Linux 上原生运行。

目前已完成 IL2CPP 符号恢复、资源首块离线解密、48 个热更 DLL 导出和 374 份 JSON 配置恢复。原生客户端尚在准备阶段，业务协议梳理与引擎适配仍待开展。

## 项目资料

- [成果与进展](REPORT.md)
- [符号恢复、资源解密与复现步骤](recon/REVERSE.md)
- [启动器分发协议与本地格式](recon/DISTRIBUTION.md)

`recon/` 中保留的 Python 文件仅用于离线分析和复现，不代表客户端的实现语言。

> 注：`recon/il2cpp_verified/script.json` 超过 GitHub 100 MB 单文件限制，仓库内为 `script.json.gz`（gzip -9，约 8 MB），本地用 `gunzip -c` 还原。
