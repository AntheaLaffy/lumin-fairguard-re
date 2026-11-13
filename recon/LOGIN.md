# 时叶：登录、角色同步与剩余工作

验证日期：2026-11-14。样本：1.0.2 / build 12450 / Win64 / bilibili。

用户亲自扫码确认后，已在 Linux 上通过 HTTP 与 TCP socket 独立完成账号登录和角色初始化同步。这条验证链不调用 Windows 渠道 SDK；官方客户端仅用于前期读取和核对协议常量。**当前仍没有可渲染、可操作的 Linux 原生游戏客户端。**

工程范围已调整：第一阶段通过 Lutris 运行官方游戏，后续原生重写聚焦启动器，见 [LUTRIS.md](LUTRIS.md)。本页记录独立网络实验的证据边界；下方未验证的游戏业务不构成启动器待重写清单。

## 已验证的链路

```text
哔哩哔哩游戏 SDK 二维码 → 用户扫码并确认
  → 渠道 access_key + uid
  → POST bamboo.zhuziplay.com/login → 游戏票据 data.token
  → POST login-prod-lm.zhuziplay.com/api/login → LoginAck
  → 解开会话 AES 密钥，连接 gateAddr
  → EnterGameReq (1002，明文) / EnterGameAck (1003，加密，code=0)
  → EnterGameLoadReq (2024，加密)
  → 初始化推送 / EnterGameLoadAck (2025，加密，含角色状态)
```

整个初始化接收 94 个包，全部通过 AES-GCM 认证，并用恢复的消息契约完成 Protobuf 解析。公开结果见 [login-chain.json](verification/login-chain.json) 和 [protocol-checks.json](verification/protocol-checks.json)；账号、密钥及原始用户数据仅存放在被 Git 忽略的私有目录。

## 实现入口与容易混淆的地方

- [BILIBILI.md](BILIBILI.md)：扫码接口、参数、签名、渠道字段映射、竹子票据交换和游戏 HTTP 登录。主站 Web 扫码 Cookie 不能直接替代游戏渠道凭据。
- [GAME_PROTOCOL.md](GAME_PROTOCOL.md)：10 字节帧头、会话密钥、1002 明文例外、初始化顺序和真实回包证据。
- [protocol/](protocol/)：完整及登录子集 FileDescriptorSet、消息索引、双向 command 映射，可用于目标语言生成绑定。

启动器 `/api/player` 是玩家资料查询；游戏实际登录使用 `/api/login` JSON。读取启动器注册表票据不是这条独立登录链的必要步骤。

关键反编译依据位于本地 `recon/decomp/`：`LoginUtility`、`HttpLoginServerClient`、`EventTrackSolver`、`BambooSafeHttpRequest`、`NetManager`、`NetPacket`、`LuminTelepathyClient`、`CommandMap` 与各 `*Reflection` 类型。AOT DummyDll 的空方法仍不能当作已恢复实现；本次 SDK 结论来自原生代码、运行时公开常量和服务端成功请求的交叉核对。

## 独立协议实验的未验证范围

| 环节 | 当前结果 | 后续验收 |
| --- | --- | --- |
| 资源、配置、程序集 | 已恢复并验证 | 按场景需要导出更多资源，适配目标引擎 |
| 渠道扫码与票据交换 | 正常账号实测成功 | 过期、取消、账号切换与持久化策略 |
| 游戏登录与网关握手 | LoginAck、EnterGameAck 成功；会话加密已验证 | 错误处理、备用网关、心跳和重连 |
| 角色初始化同步 | 94 个包完成认证和解析，收到最终确认 | 将状态应用到原生客户端，处理增量同步 |
| 场景进入与玩法 | 已有资源、程序集和消息契约 | 确定引擎，复原场景加载、操作、战斗与地图流转 |

只有继续开发独立游戏客户端时，才需要逐项实现上述场景、状态和会话行为。当前路线保留官方实现，优先验证官方登录界面、进入场景、移动与战斗；发生具体故障时再沿相关代码调查。
