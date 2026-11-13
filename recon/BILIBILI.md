# 哔哩哔哩游戏登录：已验证的 HTTP 链路

日期：2026-11-14。样本：绿梦 1.0.2 / build 12450 / bilibili。

本轮在用户亲自扫码确认授权后，实际跑通了游戏渠道扫码、竹子票据交换、游戏 HTTP 登录、TCP 网关握手和角色同步。下面记录的是协议契约，不是 Python 客户端实现。

## 1. 参考仓库的适用范围

用户提供的 [bilibili-API-collect](https://github.com/Goooler/bilibili-API-collect) 有助于理解 B 站登录状态、扫码和签名的概念；其 [二维码文档](https://github.com/Goooler/bilibili-API-collect/blob/trunk/docs/login/login_action/QR.md) 描述了主站 Web 扫码所得 Cookie。绿梦 PC SDK 使用的游戏扫码接口不同，不能把主站 Cookie 或 TV access_token 直接当成绿梦登录票据。

游戏协议的最终依据是本地 `PCGameSDK.dll`、`BLPlatform64/PCGamePlatform.exe`、恢复程序集，以及 [官方 SDK 登录页面](https://sdk.biligame.com/login/) 的脚本。官方网页原件的 URL、长度、SHA-256 见 `recon/protocol/sources.json`；原件只保存在被 Git 忽略的本地参考目录。

## 2. 游戏参数与三个身份层

参数来自原客户端 `Lumin_Data/StreamingAssets/app_config.json`，并经运行时 `AppConfig` 核对：

| 参数 | 当前构建值 |
| --- | --- |
| 竹子应用 ID / BambooAppId | `1038` |
| 竹子旗下账号服务应用 ID / ZhuziAppId | `1050` |
| B 站 game_id | `16550` |
| B 站 merchant_id | `3996` |
| B 站 zone_id / 配置中的 bili_server_id | `15687` |
| SDK channel | `bilibili` |
| SDK device_type / 签名 platform | **`Win64`** |
| 竹子 PC SDK version | `1.6.3` |

三个身份层不可混用：

```text
B 站 access_key + uid
    → 竹子 /login
竹子 data.token
    → 游戏 /api/login
游戏 loginKey + accountId + sdkAid + 会话 AES 密钥
    → 游戏网关 EnterGameReq
```

## 3. 游戏扫码接口

### 3.1 签名

从官方登录 JS 的请求拦截器及真实请求验证：

```text
params 不含 sign
按参数名升序排列
依次连接每个非 null 值的 RFC3986 百分号编码结果
尾部追加 appKey
sign = lowercase_hex(MD5(UTF8(上述字符串)))
```

**连接的是值，不是 `key=value`，值之间也没有 `&`。** 此处的 appKey 读取本地 `bili_app_key`，不同于主站 APP API 文档中的签名格式。timestamp 使用 Unix 毫秒。当前已验证的扫码参数为数字、ticket 等 ASCII 值；复杂值的编码规则以保存的官方 JS 为准。

### 3.2 申请二维码

```text
POST https://wpg-api.biligame.com/api/pcg/qrcode/login/generate
Content-Type: application/x-www-form-urlencoded

game_id, timestamp, sign
```

GET 实测返回 405，POST 签名请求返回 `code=0`。响应包含 `ticket`、`redirect_url`、`game_base_id`、`support_app_list`、`polymer_qrcode_switch` 等。

本轮扫码成功的二维码内容：

```text
<redirect_url>?ticket=<ticket>&fromNative=true&id=<game_base_id>&st=1
```

响应给出的 redirect_url 为官方 `https://game.bilibili.com/sdk/scanH5/`。扫码由用户在哔哩哔哩 App 中完成；没有代用户输入密码或处理主站 Cookie。

### 3.3 轮询

```text
POST https://wpg-api.biligame.com/api/pcg/qrcode/login/status/poll
Content-Type: application/x-www-form-urlencoded

game_id, is_gov_ver=1, merchant_id, ticket, timestamp, zone_id, sign
```

本轮实际观察到的状态：

| code | 状态 |
| --- | --- |
| `122022` | 等待扫码 |
| `122024` | 已扫码，等待手机确认 |
| `0` | 已确认，返回游戏渠道凭据 |

成功响应包括 `uid`、`access_key`、`expires`、`uname`、`face`、`game_open_id`、`game_open_id_enable`，以及实名/用户状态信息。这里只记录字段，不保存任何真实账号值到公开报告。

## 4. 交换竹子游戏票据

```text
POST https://bamboo.zhuziplay.com/login
Content-Type: application/json
```

本轮实测成功的最小请求结构：

```json
{
  "app_id": "1038",
  "sdk_channel": "bilibili",
  "device_id": "<本地持久化设备标识>",
  "device_type": "Win64",
  "sdk_version": "1.6.3",
  "data": {
    "channel_token": "<扫码返回 access_key>",
    "channel_user_id": "<扫码返回 uid 的字符串>",
    "channel_app_id": "16550",
    "avatar": "<face>",
    "gameOpenId": "<game_open_id>",
    "userName": "<uname>"
  }
}
```

此前 `device_type=PC` 时服务端返回 `code=1 / 获取配置信息错误`。从运行中的官方 SDK 读取公开常量确认 `Win64` 后，同一份合法渠道凭据交换返回 **`code=0 / ok`**。1038 与 1050 不能靠名称猜测：它们分别是运行时 `BambooAppId` 与 `ZhuziAppId`。

原生 SDK 回调会把渠道字段规范化：`access_key → data.accessToken`、`game_open_id → data.gameOpenId`、`face → data.avatar`、`uname → data.userName`。AOT `BamBooSdkUnity.OnBiliLoginSuccess` 再把它们放入上述请求结构。直接调用 HTTP 时不需要复刻 CEF 回调桥。

### 4.1 竹子签名头

已恢复 `AOT.CryptographyCode.BambooSafeHttpRequest` 的真实 IL，并与 AOT `RequestSigner` 常量及服务端成功请求核对：

```text
x_app_id     = 1038
x_device_id  = 与请求体一致的设备标识
x_nonce      = 32 位大小写字母/数字
x_platform   = Win64
x_timestamp  = Unix 秒

payload = pct(HTTP_METHOD大写) + pct(URL路径) + "&"
        + 按头名升序连接 "k=v&"
        + "key=" + Win64平台secret

sig = lowercase_hex(HMAC_SHA256(secret, UTF8(payload)))
key = SHA256(UTF8(secret + "_aes"))
x_signature = Base64(nonce12 || AES_GCM(key, nonce12, UTF8(sig), AAD空))
```

secret 的来源是原客户端的 `PlatformSecretWin64` / `PlatformSecretServer` 常量。它与启动器 Web 平台的 secret 不同；不要混用两种签名。这里只引用来源，避免在多份文档维护同一常量。

已恢复的托管实现位于 `Assembly-ACT.dll` 的 `AOT.CryptographyCode.BambooSafeHttpRequest`；本地反编译副本为 `recon/decomp/signing/AOT.CryptographyCode.BambooSafeHttpRequest.decompiled.cs`。`pct` 对应 `Uri.EscapeDataString`，头名使用 ordinal 升序，仅签上述五个头；`x_signature` 自身与请求体不参与该串。

完整 SDK 还会加入公共运行信息：`ta_properties` 始终经过公共参数加密，`game_info` 和 `game_info_string` 在存在时也被加密。`model_info`、`deviceModel`、SDK 版本等由 `InjectCommonRequestFields` 注入。当前最小登录请求的成功，不表示这些运行信息在完整客户端中都可永久省略。

成功响应为 `BaseBambooUserInfo`，其中 `data.token` 才是下一步使用的绿梦票据。`EventTrackSolver.onLoginSuccess` 把 `UserInfo.token` 赋给 `m_Token`；这与游戏 `BambooSDKSchema` 的取值一致。

## 5. 游戏 HTTP 登录与角色同步

实际成功的请求：

```text
POST https://login-prod-lm.zhuziplay.com/api/login
Content-Type: application/json; charset=utf-8
```

```json
{
  "loginTicket": "<竹子 data.token>",
  "distinctID": "<设备标识>",
  "env": "Prod",
  "operationalInfo": {
    "platform": "Win64",
    "deviceId": "<设备标识>",
    "clientVersion": "1.0.2"
  },
  "tdData": {
    "deviceId": "<设备标识>",
    "channelId": "bilibili",
    "platform": "Win64"
  }
}
```

**`operationalInfo.deviceId` 不能替代 `tdData.deviceId`**：缺少后者时，本轮请求遇到 HTTP 500，提示 canonical Device ID 长度不合要求；按真实序列化结构补上后得到 `code=0`。这不是对所有输入的完整错误规范，只是实测契约。

LoginAck 返回 `openId`、`loginKey`、`accountId`、`sdkAid`、`gateAddr`、`gateAddrBackup`、`aesKey`、`isEncry`、`fairTag` 等。网关与密钥格式见 [游戏传输协议](GAME_PROTOCOL.md)。`/api/player` 是启动器资料查询，不在这条游戏登录链的必要步骤中。

本轮已进一步确认：

1. 解出 LoginAck 的会话 AES 密钥。
2. 直接通过 Linux TCP socket 发送 EnterGameReq，取得 `EnterGameAck(code=0)`。
3. 在同一连接发送 EnterGameLoadReq，取得含角色状态的 EnterGameLoadAck。
4. 收到 94 个初始化包，全部通过 AES-GCM 校验，并按恢复的消息映射完成 Protobuf 解析。

身份数据、原始回包、二维码 ticket、账号 ID 和密钥仅存在权限受限且被 Git 忽略的 `recon/private/`。公开证据只记录状态、字段、包数量和校验结果。
