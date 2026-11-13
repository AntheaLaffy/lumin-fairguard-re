# 绿梦游戏网关协议：登录与角色同步

验证日期：2026-11-14。此页描述已经真实账号会话验证的网络层，不代表已经实现原生渲染或玩法客户端。

## 1. 帧格式

客户端使用自定义 `LuminTelepathyClient`，不是未修改的 Telepathy 协议。TCP 流上直接连续发送下列帧，**没有另加的 4 字节外层长度头**：

| 偏移 | 长度 | 内容 |
| --- | --- | --- |
| 0 | 2 | uint16 大端 command ID |
| 2 | 4 | uint32 大端请求 session ID |
| 6 | 4 | uint32 大端整帧长度，包含这 10 字节 |
| 10 | length − 10 | Protobuf 内容或其 AES-GCM 密文 |

先读满 10 字节，再按 length 读剩余部分。该客户端接收上限为 131,072 字节，TCP 可能拆包或粘包，不能把单次 recv 当作完整帧。session ID 从 1 递增；响应匹配请求编号，服务端主动推送使用 0。

依据：`ACT.Net.LuminTelepathyClient.ReceiveLoop`、`SendLoop`、`LuminSendPipe.DequeueAndSerializeAll`、`NetByteBuffer.TryWrite` 和 `NetManager.OnTransportData`。

## 2. 会话密钥与消息加密

LoginAck 的 `aesKey` 是 Base64 编码的包裹密文：

```text
wrap_key = SHA256(UTF8(LoginAck.openId))
wrapped  = Base64Decode(LoginAck.aesKey)
nonce    = wrapped[0:12]
tag      = wrapped[-16:]
cipher   = wrapped[12:-16]
session_key_plain = AES_GCM_Decrypt(wrap_key, nonce, cipher, tag, AAD空)
```

按 `NormalizeAesKeyBytes`，明文若恰为 16/24/32 字节就直接作为密钥；否则尝试 UTF-8 去空白后的 Base64，最后再接受合法长度的 UTF-8 字节。必须按实际长度检查，不能把文本编码的密钥直接错用为原始密钥。

启用加密后，普通消息内容：

```text
payload = nonce12 || ciphertext || tag16
```

nonce 每次新生成，AAD 为空。10 字节帧头不加密，也不算入 AAD。

**例外：EnterGameReq（1002）始终发送明文 Protobuf。** `NetPacket.GetGcmEncryptedContentBytes` 对该编号明确跳过加密；其回应 EnterGameAck（1003）已实测为加密。

服务端 ErrorAck（1）可能是明文。客户端先尝试 GCM，失败且编号为 1 时再按明文解析；不能对所有包都套用这个例外。

## 3. 已验证的连接顺序

| 方向 | ID | 消息 | 本轮结果 |
| --- | --- | --- | --- |
| 客户端 → 网关 | 1002 | EnterGameReq，明文 | 服务端接受 |
| 网关 → 客户端 | 1003 | EnterGameAck，加密 | `code=0`，有会话与角色资料 |
| 客户端 → 网关 | 2024 | EnterGameLoadReq，加密 | 服务端接受 |
| 网关 → 客户端 | 多个编号 | 初始化推送，加密 | 已按各自 Protobuf 类型解析 |
| 网关 → 客户端 | 2025 | EnterGameLoadAck，加密 | 含角色状态 |

EnterGameReq 关键字段：

| 字段号 | 名称 | 类型 |
| --- | --- | --- |
| 1 | openId | string |
| 2 | loginKey | string |
| 3 | accountId | int64 |
| 4 | isEditor | bool |
| 5 | sdkAid | int64 |
| 6 | distinctID | string |
| 7 | clientVersion | string |
| 8 | tdData | TDClientData |
| 9 | sessionID | string |

首次进入 sessionID 为空。重连使用服务端返回的 sessionID；当前尚未实际验证完整断线重连行为。

EnterGameLoadReq 的 `lastSeqID` 为 int64 字段 1；本轮按首次进入默认 0 发送。服务端在最终 2025 之前推送大量初始化消息，**不能固定只读前几个包就判定失败**。本轮包括最终确认共 94 个包。

先前延迟使用旧 loginKey 时，网关回了明文 `ErrorAck / D02-1004 / redis: nil`；重新执行 HTTP 登录并立刻连接，约 81 ms 后发送进入请求即成功。这支持“凭据应及时使用”的判断，但尚未测定精确 TTL，不把 redis: nil 视为所有场景下唯一的过期错误。

## 4. Protobuf 与命令目录

从恢复程序集的 `*Reflection` 类型静态构造器提取 FileDescriptorProto，并检查依赖关系，产物：

- `recon/protocol/game-descriptors.pb`：FileDescriptorSet，41 个文件、994 个顶层消息、41 个顶层枚举。
- `recon/protocol/login-descriptors.pb`：common.proto + enter.proto 的最小登录子集。
- `recon/protocol/schema-index.json`：文件、依赖和类型目录。
- `recon/protocol/commands.json`：276 项客户端发送映射、404 项服务端接收映射。

映射来自真实 `ACT.Net.CommandMap`，均能在完整 descriptor pool 找到类型；发送映射也含区间标记，不能据此宣称已实测全部业务命令。FileDescriptorSet 可以交给支持该格式的 Protobuf 工具生成目标语言绑定，不依赖 Python。

目前仅在线验证登录与初始化子集；尚未验证心跳、游戏帧批次、重连、地图流转、战斗等全部业务语义。心跳编号从 CommandMap 可读为 PingReq=6、PingAck=7，但不能仅据编号认为定时策略也已验证。

## 5. 实际证据

公开的脱敏结果：

- `recon/verification/login-chain.json`：HTTP 登录、进入网关和角色同步的成功状态；94 个包的长度、编号统计与 GCM 结果。
- `recon/verification/protocol-checks.json`：41 份 descriptor 依赖验证、全部命令的类型解析，以及本次 94 个真实包的 Protobuf 解析结果。

原始账号回包、进入请求和密钥均在被 Git 忽略的私有目录中。对本轮捕获执行验证：每帧长度匹配、GCM 认证成功、命令可映射、对应消息类型可完整解析。

这些证据说明原生客户端所需的登录与角色同步数据通路已验证；场景加载、资源到渲染引擎的适配和可操作玩法仍然需要后续实现。
