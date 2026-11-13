# 时叶 · Chronoleaf

> 让《绿梦：时空之声》在 Linux 上生长。

时叶是《绿梦：时空之声》的 Linux 启动与兼容性适配项目。当前第一阶段通过 Lutris 运行官方 Windows 游戏，解决启动、登录、画面和操作问题；后续原生重写范围聚焦启动器，游戏引擎、玩法和业务通信继续由官方客户端负责。

第一阶段已获用户确认可玩：Wine 11.21 + DXVK 3.0.2，通过 Lutris 直启官方游戏。下面的安装方案自动准备对应运行环境，用户只需提供一份**B站渠道官方原始 `.exe` 安装包**，无需提供已安装目录或他人的 Wine 前缀。

## Linux 安装

适用环境：x86_64 Linux、原生包版 Lutris、支持 Vulkan 1.4 的显卡驱动，以及 X11 或带 XWayland 的 Wayland 桌面。当前验证主机为 Intel RPL-P 核显、Mesa 26.2.6、Lutris 0.5.22；其他硬件仍需实测。此入口暂不适用于 Flatpak Lutris。

先安装一次系统依赖，包括 Wine 所需的系统库。脚本会另行下载固定版本的 Wine，不要求发行版自带的 Wine 恰好为 11.21。

```sh
# Arch Linux / Manjaro
sudo pacman -S --needed lutris wine curl jq 7zip binutils

# Debian / Ubuntu（二选一，按你的发行版执行）
sudo apt install lutris wine curl jq p7zip-full binutils
```

下载或克隆本仓库，在项目目录执行：

```sh
bash ./install.sh "$HOME/Downloads/你的官方B站安装包.exe"
```

随后在 Lutris 安装向导中选择一个**新的空安装目录**并完成安装。安装完成后，从 Lutris 启动 **「绿梦：时空之声（B站·时叶配置）」**，按游戏界面正常登录。首次启动会由官方客户端继续下载游戏资源、预热着色器，请保持联网并预留足够空间；建议至少 60 GB，实际需求以官方当前版本为准。

脚本会自动：

- 用 7-Zip 解开 NSIS 安装包并核对渠道，**不执行原始安装程序**。
- 查询官方当前游戏版本，下载、校验 ZIP 并解压游戏本体，下载地址不固定在 1.0.2。
- 下载并校验 [Wine 11.21 原版 WoW64 构建](https://github.com/Kron4ek/Wine-Builds/releases/tag/11.21)与 [DXVK 3.0.2](https://github.com/doitsujin/dxvk/releases/tag/v3.0.2)，创建独立前缀和 Lutris 条目。
- 使用 DX11、X11/XWayland 直启 `Lumin.exe`，保留官方 B站登录组件和游戏资源热更新逻辑。

**不安装 WebView2 或 .NET Desktop Runtime。** 它们属于官方 WPF 启动器的依赖；游戏包自带的 B站 CEF 登录组件会原样保留。游戏引擎、资源解密和业务通信继续使用官方实现。

运行环境保存在 `${XDG_DATA_HOME:-$HOME/.local/share}/chronoleaf/`，下载缓存保存在 `${XDG_CACHE_HOME:-$HOME/.cache}/chronoleaf/`；同时在 Lutris 的 Wine 运行器目录注册一个独立链接。游戏与账号数据保存在你选择的安装目录中。脚本不导入本机账号，不改系统电源模式，也不替换其他游戏的运行器。

当前脚本负责首次安装，尚未提供原生游戏本体整包更新器。若官方接口、安装包或游戏目录结构变化，安装会明确报错；后续再适配对应版本。游戏内资源热更新仍由官方客户端处理。

安装脚本已通过原始安装包解包、官方整包下载和完整性校验、全新前缀创建，以及首次协议界面显示检查；全新前缀的完整登录与进入场景尚未重测。详细验证范围见 [安装验证记录](recon/verification/installer-checks.json)。

## 已知情况

- DXVK 2.6.2 曾造成进入游戏后的黑屏；3.0.2 已在本机实测恢复场景和对白，安装脚本固定该版本。
- 初始请求为 1280×720 窗口模式，游戏读取自身设置后可能覆盖；实际分辨率和画质请在游戏设置中确认。
- 本机核显场景约 10 FPS，用户选择暂不继续优化；安装配置不代表所有机器都能达到相同帧率。
- 教程可能暂时锁定操作键位，不能仅凭角色不走动判断输入失效。具体记录见 [联调记录](recon/LUTRIS.md)。

## 项目资料

- [成果与进展](REPORT.md)
- [第一阶段：Lutris 配置与联调记录](recon/LUTRIS.md)
- [账号登录、角色同步与剩余工作](recon/LOGIN.md)
- [哔哩哔哩游戏扫码与票据交换](recon/BILIBILI.md)
- [游戏网关帧格式、加密与消息契约](recon/GAME_PROTOCOL.md)
- [符号恢复、资源解密与复现步骤](recon/REVERSE.md)
- [启动器分发协议与本地格式](recon/DISTRIBUTION.md)

`recon/` 中保留的 Python 文件仅用于离线分析和复现，不代表客户端的实现语言。

已恢复的 IL2CPP 符号、热更 DLL、配置、资源与登录协议属于兼容性调查资料，运行本安装方案不需要先复现这些逆向步骤。

> 注：`recon/il2cpp_verified/script.json` 超过 GitHub 100 MB 单文件限制，仓库内为 `script.json.gz`（gzip -9，约 8 MB），本地用 `gunzip -c` 还原。
