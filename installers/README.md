# 安装方案维护

用户入口是仓库根目录的 `install.sh`，无需直接运行本目录脚本。

`install.sh` 下载带固定 SHA-256 的 Wine 11.21 WoW64 与 DXVK 3.0.2，在 XDG 用户数据目录注册专用 Wine 运行器，并生成原生 Lutris 安装描述。`prepare-game.sh` 由 Lutris 传入选定的安装包和安装目录，只解包 NSIS、查询官方整包、下载校验和解压游戏；它不执行 Windows 安装器或创建任何账号会话。

Wine 前缀由 Lutris 自己的 `create_prefix` 任务创建，禁用可选的 Mono/Gecko 下载。游戏自带 CEF 保留，WPF、WebView2、.NET Desktop Runtime 不作为运行依赖。

版本和签名要求：Wine/DXVK 是复现兼容性修复所需的固定运行环境；游戏版本通过官方 `/launcher/app` 每次查询。该公开接口于 2026-11-14 实测接受无签名的公共 JSON 请求。如果未来返回要求变化，应修正分发契约，不回退到硬编码旧游戏下载地址。

检查命令：

```sh
bash -n install.sh installers/prepare-game.sh tests/install-contract.sh
shellcheck install.sh installers/prepare-game.sh tests/install-contract.sh
bash tests/install-contract.sh
```

契约测试使用临时 XDG 路径和假的运行器，仅验证路径、引号、参数传递与缺失输入处理，不下载或启动游戏。实际集成检查另记录于 `recon/verification/installer-checks.json`；当前覆盖了全新安装到首次协议界面，未把已有前缀的可玩结果冒充全新前缀登录验收。
