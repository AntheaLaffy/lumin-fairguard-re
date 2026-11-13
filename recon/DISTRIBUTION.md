# 启动器分发与本地格式参考

这些内容来自前次启动器静态反编译、前端文件及已保存的服务端响应；本轮重点验证 IL2CPP 注册表和资源恢复，没有逐项重放在线接口。它们属于启动器分发协议，不是完整游戏业务协议。网络返回中的版本、URL 和大小均为采集时的快照。

证据：`recon/decomp/Lumin.Launcher/`、`recon/starter/index.pretty.js`、`recon/remote_config.json`、`recon/manifest_hash.json`。历史启动器实现只保留压缩归档，不作为原生客户端的语言选择。

## 2. 分发链

```
bilibili 游戏页
   │  lmskzsPCb_…exe  (NSIS 3 Unicode, 147 files)
   ▼
C:\Games\<任意>\app\
   ├── Lumin.Launcher.exe        # .NET 8 WPF apphost
   ├── Lumin.Launcher.dll        # 业务全在这（1.0.2.3）
   ├── lumin-installsvc.exe      # Lumin.InstallService：装 WebView2 / .NET 运行时
   ├── lumin-launcher-upd.exe    # 自更新器，args = zipUrl installDir logDir parentPid
   ├── dotnet-runtime-install.exe(58 MB) / WebView2 安装器
   └── Lumin/                    # 默认 GamePath（NSIS 建的空的）
        └── Bin/                 # 真正的游戏目录，首次下载后出现
```

启动器 → WebView2 打开 `https://lvmeng-starter.zhuziplay.com?...`（远程 Vue SPA，无本地前端资产）
→ SPA 调 `lmapi.zhuziplay.com` 拿版本/下载地址/资源清单
→ 通过 COM 宿主对象 `BridgeLinker.LuminJsCall(name, json)` 把"要下什么"交回 C#
→ C# 下载、解包、写状态、启动 `Bin\Lumin.exe`。

安装器里的两个 PowerShell 小工具（`recon/installer/$PLUGINSDIR/skin/`）说明：
`Find-LuminSharedGamePath.ps1` 会全盘扫 `install_path` 文件判断"是否与别的启动器共用同一份游戏目录"，
`Install-WebView2.ps1` 从微软 fwlink 拉 WebView2 运行时。这两件事在 Linux 侧都不需要。

---

## 3. 启动器逆向（`Lumin.Launcher.dll`）

### 3.1 关键类型

| 类型 | 作用 |
| --- | --- |
| `ENV` | 常量：`BASE_URL=https://lvmeng-starter.zhuziplay.com`、`CHANNEL_ID=bilibili`、`REGION_ID=CN`、`PUB_ENV=Prod`；`deviceId = HKLM\SOFTWARE\Microsoft\Cryptography\MachineGuid` |
| `AppRuntime` | 全局容器：`ProtocolManager` / `LocalPreference` / `LocalCache` / `LauncherTaskMachine` / `MainWindow` |
| `BridgeLinker` | `[ComVisible] LuminJsCall(string protocolName, string data)` → `ProtocolManager.Run` |
| `MainWindow` | WebView2 宿主；`ExecuteScriptAsync("window.LuminJsEvent('{name}', {json})")` 回收结果 |
| `ProtocolManager` + `[ProtocolProcessor]` | 反射注册 36 个协议 |
| `LauncherTaskMachine` + `Lumin.Launcher.Tasks.*State` | 状态机（Default / UpdatingGame / GameDownloaded / InstallingGame / RepairingGame / Playing / UpdatingLauncher / UpdatingResource / PreDownloadingResources / Uninstalling…） |
| `LuminDownloader` | Range 续传、限速、`LatestPackageSize` 记录 |
| `LuminResourceDownloader` + `ResourceDownloadReconciler` | YooAsset 资源分卷下载、边下边解、marker 判定、`version.txt` 落盘 |
| `LuminUnzipper` | SharpZipLib 解包 |
| `LocalPreference` / `LocalCache` | `config.lmc` / `cache.lmc`（AES-192-CBC JSON） |
| `LuminAppInfo` / `LuminResourceVersion` / `LuminSdkConfig` | `app_info` / `version.txt` / `app_config.json` |

### 3.2 原 Windows 启动器的 WebView 初始化

```csharp
CoreWebView2Environment.CreateAsync(null, PathUtilities.WebViewCacheDir)   // 缓存目录
Settings.AreBrowserAcceleratorKeysEnabled = false;
Settings.AreDefaultContextMenusEnabled    = false;
Settings.AreHostObjectsAllowed            = true;
AddHostObjectToScript("BridgeLinker", new BridgeLinker());
AddHostObjectToScript("DragMove",     new DragMoveLinker(hwnd));
Source = new Uri("https://lvmeng-starter.zhuziplay.com?" +
    $"region=CN&launcher_env=Prod&channel=bilibili" +
    $"&launcher_version={ENV.Version}&device_id={ENV.DeviceId}&cps={ENV.CpsId}");
```

JS 侧判定桥接是否可用（`hasNativeBridge`）就是看
`window.chrome.webview.hostObjects && typeof window.LuminJsCall === "function" && window.emitter`。
**换句话说：这套桥协议可以整体绕过**——数据都在 HTTP 上，前端只是调度器。

### 3.3 桥协议全表

C# 侧 `ProtocolManager.Collect()` 用反射注册 **36 个** `[ProtocolProcessor("name")]`：

```
page_loaded  version  ticket  setting  setting_edit
get_game_path  locate_game_path  choose_game_path
game_init  game_download  game_install  game_pause  game_resume  game_enter
game_resource_init  game_resource_download  game_resource_pause  game_resource_resume
game_resource_pre_download_init  game_resource_pre_download_download
game_resource_pre_download_pause  game_resource_pre_download_resume
repair_start  repair_cancel  uninstall_game
starter_download  starter_exit  starter_mini  starter_taskbar
open_browser  open_game_path  open_log_game  open_log_launcher
log_debug_on  upload_launcher_log  update_background_url
```

前端还会调三个没有 Processor 的名字（`Run` 只记一条 "does not exists" 日志，不报错）：

- `game_update`（遗留）
- `starter_init`（用于查自更新进度，C# 侧由 `starter_download` 承担）
- `starter_restart`（重启启动器，Linux 侧不需要）

反向通道同理：C# 通过 `window.LuminJsEvent(name, json)` 推 `game` / `game_resource` /
`game_resource_pre_download` / `starter` / `starter_back` / `common_error` / `ticket` / `setting` 等事件，
前端 `window.emitter` 监听 `luminEvent`。

要点：

- `version` 返回 `{version(启动器), launcher_env, channel:"bilibili", build_id:"0", game_version, game_env, game_build_id}`
- `game_init` → 回报本地状态 `empty / pause / download_complete / ready / playing`
  （判定逻辑 `GameInstallationProbe`：`Bin/Lumin.exe` 与 `Bin/Lumin_Data/StreamingAssets/app_info` 同时在，且能从 `app_info` 解出 `client_version`）
- `game_download {url, version}` → `DownloadCache/Download-<version>.zip`
- `game_install` → 解包到 `Bin/`，解完删 `DownloadCache/*`
- `game_enter` → 起进程，参数固定 `-launcher=lm -cps=<cps>`；JS 若传 `force_d3d11` 才加 `-force-d3d11`
- `ticket` → 读注册表 `HKCU\Software\bamboo\lumin` 的 `token`（登录票据，前端拿去换玩家信息）
- `repair_start {url}` → `url` 是 `.../hash.json`，内部把 `hash.json` 换成 `files/` 再逐文件比对 MD5

---

## 4. 服务端 API 与签名（可直接复用）

- Base：`https://lmapi.zhuziplay.com`（`app_info` 里的 `config_url` 同值）
- 全部 `POST`，`Content-Type: application/json;charset=UTF-8`
- 公共 body（拦截器统一注入）：`region`、`launcher_env`、`channel`、`device_id`
- 成功判据：`{"code":0,"message":"","data":...}`；`code!=0` 视为业务错误，401 会清 token

### 4.1 签名算法（`addSignatureHeaders` → `createSignatureHeaders`）

```
secret   = "57e5177a6752ef98e3a7c9b6c9f06e35"
x_app_id   = "1038"
x_platform = "Web"
x_device_id= <device_id>
x_nonce    = 32 位 [a-zA-Z0-9]
x_timestamp= 十进制 Unix 秒

payload = pct(METHOD大写) + pct(path) + "&"
          + 依次拼接 sort(headers) 的 "k=v&"
          + "key=" + secret
          # pct = encodeURIComponent 后再把 [!'()*] 转 %XX
          # 注意：method 与 path 之间没有分隔符

sig     = hex(HMAC_SHA256(secret, payload))
key     = SHA256(secret + "_aes")            # 32 字节
nonce12 = random(12)
x_signature = base64( nonce12 || AES-256-GCM(key, nonce12, utf8(sig)) )
```

历史 Python 参考实现已合并存档：`recon/archive/python-launcher.tar.gz`。新客户端应按上面的语言无关算法实现；本轮没有重放在线 API。

### 4.2 端点与真实返回

| 端点 | 请求要点 | 返回（实测 2026-11-13） |
| --- | --- | --- |
| `/launcher/app` | `{}`（首次）/ `{env,client_version}`（已装） | `build_id:12450, client_version:"1.0.2", download_url:"https://lm-package.zhuziplay.com/Win64/11974/11974_12450_Prod_bilibili_20260924_142327.zip", zip_size:635267901, game_size:1053906025, env:"Prod", channel:"bilibili", resource_download_status:0, update:{...}` |
| `/launcher/update` | `{client_version:"1.0.2.3"}` | `data:null` = 已最新；`status:8` = 版本废弃 |
| `/native/buildId` | `{env,client_version,channel,region}` | `{native_build_id:11974, build_id:12450, is_sync_outer:2, sync_outer_status:2}` |
| `/remote/config` | `{build_id:12450, client_version, env, channel, target_platform:"Win64", assets_version:0, client_static_version:0, dll_version:0, raw_file_version:0}` | 四大资源块 + `server_url`、`client_shield`、`update_type`、`update_link` |
| `/launcher/announcement` | `{}` | `{id:11, value:{announcements:[], news:[], activities:[], *_status:1}}` |
| `/launcher/bg` `/launcher/banner` `/launcher/shield` | `{}` | 运营位/屏蔽词，与移植无关 |
| `/upload/lmlog` | multipart：`device_id` + `file` | 启动器日志上传 |

### 4.3 `/remote/config` 结构（启动器资源分发）

```jsonc
{
  "build_id": 12450, "client_version": "1.0.2",
  "server_url": "https://login-prod-lm.zhuziplay.com",
  "assets":        {"cdn":"https://cdn-rs-lm.zhuziplay.com","backup_cdn":"…","manifest_prefix":"/manifest_v1/release/en/w/prod","bundle_prefix":"/bundle_v1/release/en/w",
                    "normal":{"version":43,"full":[{"url":"/full_v1/release/en/w/prod/Assets/a132cb-Preload-43-3.zip","size":"1347249221","hash":"6cf8a193…","tag":"Preload"}, …],"diff":[]},
                    "pre_download":{"version":0,"full":[],"diff":[]},"hotfix":{"version":0,"diff":[]}},
  "client_static": {"…同上，version":54, 1 个包, 6.7 MB},
  "dll":           {"… version":61, 1 个包, 13.3 MB},
  "raw_file":      {"… version":20, 6 个包, 5.4 GB}
}
```

前端拼接规则（`withCdnUrl` / `joinCdnUrl`）：`cdn.rstrip('/') + '/' + url.lstrip('/')`，
`full + diff` 合并成数组，元素字段 `{url,size,hash,tag}`，版本号取 `normal.version`。

### 4.4 其它域名

| 域名 | 用途 |
| --- | --- |
| `lvmeng-starter.zhuziplay.com` | 启动器 WebView 前端（Vue3 SPA，`assets/index-<hash>.js`） |
| `lvmeng.zhuziplay.com` / `pages.zhuziplay.com` | 活动页/协议页（`open_browser` 打开） |
| `lmcdn.zhuziplay.com` | starter 静态资源（背景图、二维码） |
| `lmweb.zhuziplay.com` | 字体 CDN |
| `lm-package.zhuziplay.com` | 客户端整包 + `Win64/<build>/hash.json` + `Win64/<build>/files/<path>`（修复源） |
| `lm-package-qt.zhuziplay.com` | 同上（`sync_outer_status != 2` 时切到 qt 域名） |
| `cdn-rs-lm.zhuziplay.com` / `lm-cdn.zhuziplay.com` | YooAsset 资源卷 |
| `login-prod-lm.zhuziplay.com` | 游戏登录服（`/api/player`，`loginTicket` 表单；token 来自注册表） |
| `te-receiver.zhuziplay.com` | 数数 ThinkingData 埋点 |
| `lvmeng-feedback.zhuziplay.com` | 反馈页 |

---

## 5. 本地文件格式与加密

### 5.1 两种对称加密（都在 `Lumin.Launcher.dll` 里明文）

```csharp
// AesEncryption：config.lmc / cache.lmc / app_info
Key = base64("yv82l+V4Q7XuxDX0UOaWye4AVLPUZ5XM")   // 24 字节 → AES-192
blob = IV(16) || AES-CBC/PKCS7
```

```csharp
// ACT.AotCrypto：res/version/version.txt
Key = SHA256(utf8("Lumin_Key_v1"))                  // 32 字节 → AES-256
file = "ENC:" + base64( IV(16) || AES-CBC/PKCS7 )
```

实测解密（`lvmeng-prefix/.../LuminLauncher/bilibili/Prod/config.lmc`）：

```json
{"language":"zh-cn","auto_start":false,"close_action":1,"speed_limit":0,
 "extract_while_downloading":true,"max_pending_extractions":2,
 "game_path":"C:\\Games\\Lvmeng\\app\\Lumin"}
```

实测解密（客户端自带 `Bin/Lumin_Data/StreamingAssets/app_info`）：

```
build_id=12450,region=CN,env=Prod,channel=bilibili,client_version=1.0.2,UWA=0,
config_url=https://lmapi.zhuziplay.com,feedback_url=https://lvmeng-feedback.zhuziplay.com
```

### 5.2 目录布局（`PathUtilities` / `ResourceZipUtilities`）

```
%APPDATA%\..\LocalLow\zhuziplay\Lumin                          # 游戏自身数据
%APPDATA%\..\LocalLow\zhuziplay\LuminLauncher\bilibili\Prod    # 启动器数据
├── config.lmc            AES-192-CBC
├── cache.lmc             AES-192-CBC（Task.State / 下载 URL / 资源缓存）
├── install_path          明文 game_path（NSIS 用它判断"共用游戏目录"）
├── Logs/Launcher-<ts>.lmlog
└── WebView/              WebView2 用户目录

<GamePath>/
├── DownloadCache/Download-<client_version>.zip          # 整包
└── Bin/                                                 # InstallDir
    ├── Lumin.exe  UnityPlayer.dll  GameAssembly.dll  baselib.dll …
    ├── BLPlatform64/{PCGamePlatform.exe, game_security_protection.exe, BLWebbrowser/**(CEF)}
    └── Lumin_Data/
        ├── StreamingAssets/{app_info, app_config.json, internal_version, Crashsight_Enabled}
        ├── il2cpp_data/{Metadata/global-metadata.dat, Resources/*.dat}
        ├── Plugins/x86_64/*.dll                         # FMOD/DLSS/FSR3/XeSS/TapSDK/Vuplex/CrashSight
        ├── res/downloads/{Dll,Assets,ClientStatic,RawFile}/
        ├── res/zipmarkers/{…}/<hash>_<size>.marker
        ├── res/version/version.txt                      # ENC: 加密
        ├── res/pre-download/<aX_csY_dZ_rW>/downloads/…
        └── yoo/{Dll,Assets,ClientStatic,RawFile}/BundleFiles/   # YooAsset 解包目标
```

特殊点：

- `LuminAppInfo.Write()` 写 **二进制** AES，而 `Read()` 却 `Convert.FromBase64String` —— 只读不写，
  所以 `app_info` 实际永远是**base64 文本**（游戏自己写的也是 base64），别被 Write 误导。
- `res/version/version.txt` 只在启动器完成资源下载后写；游戏自己下载时不写，也不影响启动。

---

## 6. 下载 / 安装 / 资源 / 修复算法

### 6.1 客户端整包

1. `POST /launcher/app` → `download_url / zip_size / client_version`
2. 目标 `DownloadCache/Download-<version>.zip`；已存在则按 `Range: bytes=<local>-` 续传；
   服务端回 200 而非 206 时清空重下；`MaxRetryCount = 3`
3. 校验：`Content-Length` 与本地长度一致（`DownloadSpacePolicy` 还要求剩余空间 ≥ 包大小）
4. 解包：SharpZipLib 全量解到 `Bin/`，解完删 `DownloadCache` 下所有文件
5. 收尾：读 `Bin/Lumin_Data/StreamingAssets/app_info` 得到 `client_version/env/build_id`；
   把 `cps` 覆盖进 `StreamingAssets/app_config.json`；状态置 `ready`

### 6.2 资源（YooAsset 分卷）

- 四个分类顺序固定：`Dll → Assets → ClientStatic → RawFile`
- 文件名：`<hash>_<size>.zip`（`hash` 来自清单），marker：`<hash>_<size>.marker`
- 判定"已解包"：目标 `yoo/<Type>/BundleFiles` 非空 **且** marker 存在
- 校验：大小精确相等 + SharpZipLib `TestArchive(true)`（CRC 全量）；`hash` 不参与校验
- `extract_while_downloading = true` 时边下边解，最多 2 个待解压任务；解压需要 `size*2` 的可用空间
- 全部完成后写 `res/version/version.txt`
- **实测：游戏自己也会下同一批包**，落到同一个 `res/downloads/<Type>/`，文件名与清单里的
  `xxx-<tag>-<ver>-<n>.zip` 一致（我们的工具用启动器的 `<hash>_<size>.zip` 命名，两者互不冲突但会重复占盘）

### 6.3 修复（repair）

```
GET https://lm-package.zhuziplay.com/Win64/<native_build_id>/hash.json
    → [{path, md5}, …]（183 条，含 .DS_Store）
GET https://lm-package.zhuziplay.com/Win64/<native_build_id>/files/<path>
```
逐文件 `MD5(local) != md5` 即重下，串行覆盖写。`native_build_id` 由 `/native/buildId` 给出。

### 6.4 启动器自更新

`starter_download {url, version}` → `SelfUpdateService` 把 `lumin-launcher-upd.exe`
复制到 `<install>\Updater\<…>` 后以
`lumin-launcher-upd.exe <zipUrl> <launcherDir> <logDir> <parentPid>` 启动，自身 `Environment.Exit(0)`。
更新器先等父进程退出，再下载 zip、解压覆盖、重启启动器。Linux 侧无需实现。

---

