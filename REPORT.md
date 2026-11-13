# 时叶 · Chronoleaf — 逆向成果与 Linux 运行适配

> 让《绿梦：时空之声》在 Linux 上生长。

验证日期：资源与符号 2026-11-13；账号与网关 2026-11-14。样本：1.0.2 / build 12450 / native build 11974，Unity 2022.3.62f2，Win64/bilibili。

已完成 **IL2CPP 符号恢复、首块离线解密、完整热更 DLL 导出和配置资源恢复**，并通过用户扫码授权，实际验证 **渠道认证 → 竹子游戏票据 → 游戏 HTTP 登录 → TCP 网关握手 → 角色同步**。交付物与目标实现语言无关，Python 仅保留少量分析工具。

**第一阶段已获用户确认可玩。** 通过 Lutris 直启官方客户端，以 Wine 11.21 + DXVK 3.0.2 解决进入游戏后的黑屏；核显场景约 10 FPS，用户选择暂缓性能优化，见 [Lutris 联调记录](recon/LUTRIS.md)与[脱敏验收记录](recon/verification/lutris-compatibility.json)。心跳、重连、场景、渲染和玩法继续由官方客户端实现；可玩性来自实际游戏测试，独立协议实验另作证据记录。

## 直接使用的成果

| 内容 | 结果 | 入口 |
| --- | --- | --- |
| AOT 声明 | 20,189 个类型，139 个 image | [dump.cs](recon/il2cpp_verified/dump.cs) |
| 结构与地址映射 | il2cpp.h、script.json、stringliteral.json、139 个 DummyDll | [符号目录](recon/il2cpp_verified/) |
| 注册表定位 | typesCount=75,408；fieldOffsetsCount=20,189；自动识别成功 | [registrations.json](recon/il2cpp_verified/registrations.json) |
| 热更代码 | **48 个完整 DLL**，包括此前遗漏的 Cinemachine.dll | [DLL 目录](recon/unpacked/Dll/BundleFiles/7c/7cffd28bf51ff3182f6232eadb296126/TextAssets/) |
| 配置 | 377 个 bundle 全部恢复，导出 **374 份有效 JSON** | [配置目录](recon/unpacked/ClientStatic/BundleFiles/) |
| 美术/场景资源 | 已恢复并读取 745 个 Assets bundle，零失败 | [资源目录](recon/unpacked/Assets/BundleFiles/) |
| 验证与哈希 | 1,123 个已验证 bundle；主要产物 SHA-256 | [资源清单](recon/unpacked/manifest.json)、[产物清单](recon/artifacts.json) |
| 渠道与游戏登录 | 扫码、竹子交换、游戏 HTTP 登录均成功；网关 EnterGameAck code=0 | [登录协议](recon/BILIBILI.md) |
| 网关与角色同步 | 94 个初始化包全部通过 GCM 认证及 Protobuf 解析，收到 EnterGameLoadAck | [传输协议](recon/GAME_PROTOCOL.md)、[脱敏证据](recon/verification/login-chain.json) |
| 消息契约 | 41 份 descriptor、994 个顶层消息；276 项发送和 404 项接收映射全部可解析 | [协议目录](recon/protocol/)、[验证结果](recon/verification/protocol-checks.json) |

`dump.cs`/DummyDll 是 AOT 符号声明，不包含恢复的 AOT 方法 IL。48 个从 TextAsset 导出的 DLL 则含可供反编译的托管代码。重建的 GameAssembly.dll 仅供分析，不能替换原文件运行。

## 第 0 块已恢复

核心障碍已解决，现有样本无需游戏进程即可离线无损解包，LZ4 长度校验和 Unity 对象解析都已通过。

- UnityFS 大端字段是标准格式，不是保护层改写。
- 常见前 8 字节属于被变换的 LZ4 数据，**不能剥掉**。
- read hook 仅转换开头最多 **0x500 字节**；保持压缩块长度及后续数据不变。
- 目前使用保存的 FairGuard 机器码在 Unicorn 中离线执行，没有继续把算法改写成 Python。
- 快照与构建绑定；不同资源的异或差值并不相同，不能把它描述为已确认的全局固定密钥流。

入口、调用契约、样本证据与复现命令见 [技术记录](recon/REVERSE.md)。

## 报告与证据

- [技术记录：IL2CPP、首块解密、验证、旧结论修正](recon/REVERSE.md)
- [启动器分发 API 与本地格式参考](recon/DISTRIBUTION.md)：前次调查材料，本轮未逐项重放在线接口。
- [Dumper 完整成功日志](recon/il2cpp_verified/dumper.log)
- [DLL / JSON 完整性验证](recon/verification/artifact-checks.json)
- [游戏登录与网关校验](recon/verification/login-chain.json)、[消息契约与真实回包解析校验](recon/verification/protocol-checks.json)

资源清单中的 `complete=false` 表示没有遍历当时 12,883 项的整个本地清单；已处理的 1,123 项没有失败。配置和 DLL 已全量恢复，Assets 为抽样验证，不宣称所有远端资源均已下载或导出。

## 清理结果

删除了 14 个重复或试错的 GDB 扫描/dump/临时仿真脚本和旧 PE 猜测切片算法。旧 Python 启动器及 API 示例移入 [历史归档](recon/archive/python-launcher.tar.gz)，不作为活动客户端实现。

活动分析代码仅保留两个复现入口和两个 helper，位于 `recon/` 与 `recon/analysis_tools/`。它们用于验证证据，不限制最终客户端的实现语言。第三方 Il2CppDumper 自带的 IDA/Ghidra 导入脚本仍保留。

## 当前工程边界

符号、资源和登录初始化链路已有实测证据。41 份消息契约的恢复不代表全部业务语义已经验证，也不要求把它们全部重写。第一阶段运行官方游戏并建立可复现的兼容配置；后续 Linux 原生启动器负责安装、更新、运行环境和进程管理，资源内容解释、引擎与游戏逻辑由官方客户端负责。必要的兼容适配以实际故障为依据，并记录适用的游戏与运行环境版本。
