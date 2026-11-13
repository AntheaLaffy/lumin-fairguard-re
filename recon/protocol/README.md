# 时叶协议资料

本目录保存从当前样本恢复的语言无关协议契约，供后续原生客户端实现使用。

| 文件 | 用途 |
| --- | --- |
| `game-descriptors.pb` | 完整 Protobuf FileDescriptorSet：41 个文件 |
| `login-descriptors.pb` | common.proto + enter.proto 登录子集 |
| `schema-index.json` | 文件、依赖、顶层消息与枚举索引 |
| `commands.json` | 客户端发送及服务端接收命令编号映射 |
| `sources.json` | 官方 SDK 静态页面/脚本的来源与 SHA-256 |

流程见 [渠道登录](../BILIBILI.md)和[网关协议](../GAME_PROTOCOL.md)。

例如，使用支持 `--descriptor_set_in` 的 `protoc` 生成登录子集 C++ 绑定：

```sh
mkdir -p /tmp/chronoleaf-proto
protoc --descriptor_set_in=recon/protocol/login-descriptors.pb \
  --cpp_out=/tmp/chronoleaf-proto common.proto enter.proto
```

从项目根目录执行。本次也已验证完整 41 份描述符均可生成 C++ 头文件及源文件；这项检查确认契约可被标准工具消费，不代表选定客户端实现语言，也不代表玩法逻辑已经实现。

这些文件不包含用户 ticket、token、loginKey、会话 AES 密钥或原始用户数据。使用新的会话时必须正常扫码授权并向服务端取得新凭据。
