# 《绿梦：时空之声》(Lumin) PC 客户端逆向报告 —— 面向 Linux 移植

> 目标：把这套 Windows 启动器 + Unity IL2CPP 客户端拆清楚，让后续（人或 GPT）能在 Linux 上
> 复刻"取版本 → 拿包 → 装 → 更新 → 启动"的完整链路。
>
> 结论已实测：**客户端可在 Linux 上用 Proton 跑起来并渲染**（Intel iGPU + Mesa + Proton Experimental），
> 游戏自身会向同一批 CDN 拉 22.4 GiB YooAsset 资源。
>
> 本仓库同时给出可直接用的原生启动器实现：`tools/lumi/`。

---

## 0. TL;DR

| 结论 | 证据 |
| --- | --- |
| 发行包只是启动器，不含游戏本体 | NSIS 解包 147 个文件，最大的是 `dotnet-runtime-install.exe`（58 MB），无 Unity 资源 |
| 启动器 = .NET 8 WPF + WebView2，界面是远程 Vue SPA | `Lumin.Launcher.dll` / `ENV.BASE_URL` / `MainWindow.WebView_OnInitialized` |
| 所有业务数据来自带签名的 HTTP API | `lmapi.zhuziplay.com`，签名算法已在 §4 完整还原并用真实请求验证 |
| 游戏本体 = Unity 2022.3.62f2 + IL2CPP(Win64) + HybridCLR + YooAsset | `data.unity3d` 头部、`GameAssembly.dll`、`ScriptingAssemblies.json` |
| 加固：FairGuard（metadata 全量加密 + 驱动枚举反调试）+ 腾讯 CrashSight | `FairGuardProtect.dll` 熵 8.00 的 `global-metadata.dat`、进程 `maps` 实测加载 |
| **加固已全面破解（2026-11-13 更新）** | **IL2CPP 元数据已解密（§11）、bundle 包裹格式已还原（§11.2）、47 个 HybridCLR 热更 DLL 全部提取（§11.4）、codeReg/modules 全表定位（§11.5）** |
| 没有 Linux Player，无法"重编译移植" | `Lumin_Data` 只有 Win64 插件目录；`GameAssembly.dll` 是 PE |
| 可行路线：原生 Linux 启动器 + Proton | 实测渲染成功，见 §8 |

---

## 1. 素材与证据清单

| 路径 | 说明 |
| --- | --- |
| `lmskzsPCb_bilibili_20261014_*.exe` | bilibili 下载的 NSIS 安装器（PE32，88.7 MB，v1.0.2.3，上海竹子信息技术） |
| `lvmeng-prefix/` | Wine/Proton prefix（含已安装启动器、注册表、日志） |
| `recon/installer/` | 安装器解包结果（`app/`、`$PLUGINSDIR/`、`uninstall.exe`） |
| `recon/decomp/Lumin.Launcher/` | `Lumin.Launcher.dll` 的 ILSpy 反编译工程（135 个 .cs） |
| `recon/starter/index.js` / `index.pretty.js` | 启动器 WebView 里加载的 SPA（534 KB / 美化后 28 k 行） |
| `recon/remote_config.json` | 真实 `/remote/config` 响应（资源清单） |
| `recon/client/lumin_api.py` | 最小可跑的签名客户端（Python） |
| `recon/client/remotezip.py` | 用 HTTP Range 直接读远端 zip 的工具（不必下整包） |
| `recon/client_zip/` | 从客户端整包里挑出来的元数据文件 |
| `recon/game_meta/` | （提取中断，见 `lvmeng-prefix/.../Bin/` 已有完整客户端） |
| `lvmeng-prefix/drive_c/Games/Lvmeng/app/Lumin/Bin/` | 实测安装完成的客户端（1.0 MB~1 GB 文件树） |
| `recon/run/proton1.log` | Proton 运行日志（DXVK/vkd3d 版本、设备、窗口链） |
| `recon/run/ingame-resource-download.png` | 实测截图：渲染正常 + 游戏内资源下载 22.4 GiB |
| `tools/lumi/` | Linux 原生启动器（版本判定 / 下载 / 解包 / 修复 / Proton 启动） |

---

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

### 3.2 WebView 初始化（照抄即可复刻）

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

Python 参考实现：`recon/client/lumin_api.py`、`tools/lumi/api.py`（两者都能被服务端接受）。

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

### 4.3 `/remote/config` 结构（移植只需这一段）

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

## 7. 游戏本体

### 7.1 客户端包内容（198 条目，解压 ≈ 0.98 GiB）

| 文件 | 大小 | 说明 |
| --- | --- | --- |
| `GameAssembly.dll` | 35.8 MB | IL2CPP 编译产物 |
| `UnityPlayer.dll` | 19.2 MB | Unity 2022.3.62f2 运行时 |
| `Lumin_Data/data.unity3d` | 156 MB | 内置资源（`UnityFS\0 … 2022.3.62f2`） |
| `Lumin_Data/il2cpp_data/Metadata/global-metadata.dat` | 19.1 MB | **全量加密，熵 8.00**（FairGuard） |
| `FairGuardProtect.dll` | 8.6 MB | `D:\new\FGUnityProtect\x64\Release\FairGuardProtect.pdb`；含 `gethook/sethook/K32EnumDeviceDrivers` |
| `BLPlatform64/PCGamePlatform.exe` | 7.3 MB | 平台壳（DuiLib + 内嵌 CEF，bilibili 登录/支付） |
| `BLPlatform64/game_security_protection.exe` | 5.6 MB | FairGuard 安全进程 |
| `PCGameSDK.dll` / `baselib.dll` | 6.0 / 0.4 MB | 平台 SDK / 基础库 |
| `Lumin_Data/Plugins/x86_64/*` | — | `fmodstudio`、`nvngx_dlss`、`FSR3UnityPlugin`、`libxess*`、`XeSS`、`tapsdkcore`+`taptap_api`、`VuplexWebViewChromium`（内嵌 CEF）、`CrashSight64`、`rail_api64`、`resonanceaudio`、`lib_burst_generated` |
| `Lumin_Data/StreamingAssets/app_config.json` | 668 B | `app_id:1038`、`sdk_channel/source_channel`、bilibili 与 TapTap 的 appkey/商户号、`ta_app_id` |

### 7.2 引擎与脚本层

- Unity **2022.3.62f2**，URP；`boot.config`: `build-guid=26cd3014040f4ceeb694783cef12b6d6`,
  `max-chunks-per-shader=1`, `wait-for-native-debugger=0`, `single-instance=`
- IL2CPP + **HybridCLR**（`HybridCLR.Runtime.dll`）→ 业务逻辑以 DLL 形式热更
- **YooAsset**（`YooAsset.dll` + `Lumin_Data/yoo/…`）→ 资源/代码分卷热更
- 195 个托管程序集；业务侧可见：`Assembly-CSharp`、`Bamboo.*`（ECS/Chronos/HeartBeat/Pool/Command）、
  `GameplayAbilitySystem`、`Proxima`(websocket)、`BehaviorDesigner`/`Plugin.BehaviorTree`、
  `spine-*`、`MagicaClothV2`、`uLipSync`、`Cinemachine`、`Bakery`(光照烘焙)、`Odin`、
  `UniTask`、`DOTween`、`Vuplex.WebView`、`com.bamboo.sdk.pc.*`、`TapSDK.*`、`CrashSight`、`ThinkingSDK`
- `Assembly-RootMotion`、`EasyCharacterMovement`、`Unity.Formats.Fbx`、`Microsoft.CodeAnalysis`
  （运行时编译，配合 HybridCLR）

> 资源卷 `Dll` 里那 13 MB 的包解开是 YooAsset 的 raw 布局
> `7c/7cffd28b…/__data`（UnityFS bundle）+ `__info`；`strings` 能直接看到 `Cinemachine.dll`、
> 序列化类型名。用 UnityPy 1.25.4 解首个 block 报 LZ4 错，说明 bundle 头/块被 FairGuard 改写过，
> 静态 dump 需要先处理保护或在运行时抓取（见 §10）。

### 7.3 启动与登录链

```
Lumin.exe -launcher=lm -cps=<cps>
  ├─ FairGuardProtect.dll 注入（metadata/bundle 解密、反调试、驱动枚举）
  ├─ CrashSight64.dll 崩溃上报
  ├─ 启动 BLPlatform64/PCGamePlatform.exe（平台壳 + CEF 登录/支付）
  └─ 读 HKCU\Software\bamboo\lumin\token → login-prod-lm.zhuziplay.com/api/player (loginTicket)
```

启动器 `ticket` 只读不写，token 是平台壳/登录 WebView 落盘的。

---

## 8. Linux 移植

### 8.1 为什么不能"编译一个 Linux 版"

- `Lumin_Data` 只有 Win64 插件目录，`GameAssembly.dll` / `UnityPlayer.dll` 都是 PE；
- IL2CPP 产物与 Player 强绑定，缺 Linux 版 Player 和对应的 `GameAssembly`；
- HybridCLR 热更 DLL 虽为 CIL，但入口仍在 IL2CPP 宿主内。
- 因此"原生 Linux 版"只有官方出 Linux build 才可能；其余都是 Wine/Proton 兼容层。

### 8.2 方案 A（推荐，已实测）：原生 Linux 启动器 + Proton

`tools/lumi` 就是这套：

```bash
export LUMI_GAME_PATH=~/Games/lvmeng
python3 -m lumi plan                 # 看版本/资源量
python3 -m lumi install              # 只装客户端（606 MiB），资源让游戏自己下
python3 -m lumi launch --force-d3d11 # Proton 启动（参数 -launcher=lm -cps=）
python3 -m lumi repair               # 缺文件时按 hash.json 补
```

实测环境与结果（`recon/run/proton1.log`）：

- Proton Experimental `experimental-11.0-20260826`，DXVK `v3.0.2-58`，vkd3d-proton，Intel RPL-P iGPU + Mesa 26.2.6
- 进程链：`proton run Lumin.exe -launcher=lm -cps=` → `Lumin.exe` → `BLPlatform64/PCGamePlatform.exe`（含 CEF `--type=gpu-process`）
- `Lumin.exe` 的 `maps` 里确有 `FairGuardProtect.dll`、`CrashSight64.dll` —— 保护层在 Wine 下加载**未导致崩溃**
- 画面正常渲染（见 `recon/run/ingame-resource-download.png`），游戏内自动下载资源 `22.4 GiB / 2.02%`
- 日志里只有 GStreamer 插件缺失告警（`libnettle.so.8`、`libtheora`、`libvpx`，属 Multimedia 可选依赖，不影响）

启动器侧要注意的点：

| 项 | 建议 |
| --- | --- |
| 渲染后端 | 默认 DX12（vkd3d-proton）。若遇到花屏/黑屏用 `--force-d3d11`（对应官方 `force_d3d11`） |
| 前缀 | 一个独立 prefix 给游戏，避免与其它 Proton 游戏共享 `WINEDLLOVERRIDES` |
| 字体 | 中文字体走 Wine 的 `fonts`；`lmweb.zhuziplay.com` 上的思源/Noto 字体是给 WebView 用的，游戏内字体在 bundle 里 |
| CEF（PCGamePlatform） | 登录/支付窗是内嵌 CEF；Wine 下可能需要 `--no-sandbox` 之类参数，本机实测未调整即出窗口 |
| 反作弊 | FairGuard 目前未拦；若某次更新后出现"安全组件加载失败"，先试 GE-Proton 最新版，再考虑 DLL 代理方案（见 §10） |
| 存档/配置 | `LocalLow/zhuziplay/Lumin` 会映射到 prefix 内，备份即可 |

### 8.3 方案 B：只做离线/分发工具

不需要跑游戏时，`tools/lumi` 的 `plan / install / resources / repair` 可以当
"Linux 侧的下载器 + 校验器"用（例如给 Wine 用户预置客户端、或给镜像站同步资源）。

### 8.4 方案 C（不推荐）：替换 Player 重链接

社区常见的"把 Windows IL2CPP 改成 Linux"路线需要：同版本 Linux `UnityPlayer.so` + 重新 il2cpp 编译，
缺 `global-metadata` 明文（被 FairGuard 加密）就无从生成 `GameAssembly.so`。成本远高于 Proton。

---

## 9. 复现命令

```bash
# 1) 安装器解包
7z x -o"recon/installer" lmskzsPCb_bilibili_20261014_*.exe

# 2) 反编译启动器
dotnet tool install -g ilspycmd
ilspycmd -p -o recon/decomp/Lumin.Launcher lvmeng-prefix/drive_c/Games/Lvmeng/app/Lumin.Launcher.dll

# 3) 拉前端 + 美化
curl -s https://lvmeng-starter.zhuziplay.com/assets/index-Dp-VqxYb.js -o recon/starter/index.js
npx prettier@3 --parser babel recon/starter/index.js > recon/starter/index.pretty.js

# 4) 签名调 API（device_id 任意 UUID）
python3 recon/client/lumin_api.py launcher_app --device-id $(uuidgen)
python3 recon/client/lumin_api.py native_build_id --device-id $(uuidgen) \
  --data '{"env":"Prod","client_version":"1.0.2","channel":"bilibili","region":"CN"}'
python3 recon/client/lumin_api.py remote_config --device-id $(uuidgen) \
  --data '{"build_id":12450,"client_version":"1.0.2","env":"Prod","channel":"bilibili","target_platform":"Win64","assets_version":0,"client_static_version":0,"dll_version":0,"raw_file_version":0}'

# 5) 不下整包直接看 zip 结构
python3 recon/client/remotezip.py "<download_url>" --list

# 6) 装 + 跑
cd tools && python3 -m lumi --game-path ~/Games/lvmeng install
python3 -m lumi --game-path ~/Games/lvmeng launch
```

---

## 10. 未完成 / 后续可做

> §10 原 1-3 项已在 2026-11-13 完成，见新增 §11。剩余：

1. **IL2CPP 全量符号（dump.cs）**：元数据已解密（§11.1）、codeReg 已定位（§11.5），
   metadataReg 的运行时地址仍在定位中（判别值已确定：typesCount=64275 / fieldOffsetsCount=89583 /
   typeDefinitionsSizesCount=20189）。拿到后用 Il2CppDumper 手动模式即可出 dump.cs。
2. **bundle 首块密钥流**：格式已确定（§11.3：8 字节 FG 魔数 + 定长异或密钥流、无 nonce、
   密文只取决于明文）。密钥流本体需一次运行时提取：游戏加载任一 bundle 时 hook LZ4HC
   解压入口抓输入缓冲（即解密后的压缩流），与磁盘密文异或即得。
3. **资源预下载（pre_download）**：当前服务端 `pre_download.version = 0`，逻辑未实测；
   实现已在 `ResourceZipUtilities.GetPreDownload*`，需要等官方开预下载再验证。
4. **登录票据**：`HKCU\Software\bamboo\lumin\token` 由平台壳写入，Linux 侧若要跳过 CEF 登录，
   需要逆向 `PCGameSDK.dll` 的扫码/登录回调（当前直接让 CEF 在 Wine 里跑，实测可用）。
5. **自更新器**：`lumin-launcher-upd.exe` 的 zip 覆盖逻辑未复刻（Linux 侧启动器自身用 git/脚本更新即可）。
6. **多开/单实例**：`boot.config` 里 `single-instance=` 为空，游戏侧是否强制单实例未验证。

---

## 11. FairGuard 加固层破解（2026-11-13 实测）

> 攻击面：系统 Wine 11.21 + `lvmeng-prefix`（游戏已在 §8 用 Proton 跑通；此处为分析用途的
> 同机 Wine 会话）。工具：gdb 直读 `/proc/<pid>/mem`（比 frida 侵入性低，FairGuard 看门狗
> 对长时间 ptrace 停顿敏感，扫描要快、分段做）。产出的 dump 全部在 `recon/dump/`。

### 11.1 IL2CPP 元数据（global-metadata.dat）—— 已完全解密

- 磁盘文件 19,081,432 字节：前 4 字节保留明文 `0xFAB11BAF`（IL2CPP sanity 魔数），
  其余全量加密（全文件熵 7.95，无结构）。
- **运行时解密产物已在内存中完整 dump**（`recon/dump/global-metadata.dec.dat`，32 MiB）：
  - 定位法：挂上进程后扫所有 rw 映射找 `AF 1B B1 FA`，用 version==31 校验（只有一个命中，
    且文件内容不在内存中——FairGuard 替换了读路径，解密缓冲独立分配）。
  - 验证：header 全部 offset/count 自洽（v31 布局），字符串区可读
    （`mscorlib`、`Kernel32`、`CopyFileUWP`…），**Il2CppDumper 6.7.46 完整解析成功
    （"Metadata Version: 31"）**。
  - 关键统计：20189 个 typeDef、146567 个方法、89583 个字段、139 个 image。
- 一键复现：`recon/dumpmeta_standalone.py <pid> <out>`（纯 ptrace，无需 gdb），
  或 `python3 -m lumi dump-meta`。
- 磁盘密文与明文等长部分可逐字节异或出"密钥流"，**无周期、满熵**（CTR 类流密码，
  每文件独立），无法仅凭单文件静态复现；静态解密无需——运行时 dump 一次即可，
  dump 产物可离线长期使用。

### 11.2 UnityFS bundle 包裹格式 —— 已完全还原

外层仍是标准 UnityFS，FairGuard 的改写只有两点：

| 位置 | 原始 | FairGuard 改写 |
| --- | --- | --- |
| header 的 u32/u64 字段 | 小端 | **全部大端**（version=8、size、cSize、uSize、flags 均 BE） |
| 版本字符串 | — | 原样：`5.x.x` + `2022.3.62f2`（Unity 本来就写 `5.x.x` 作 player 版本，非改写） |
| blocksinfo | LZ4HC 压缩 | 原样 LZ4HC，**内层字段（hash/count/块表/目录）也全部大端** |
| 数据块 0 | LZ4HC 压缩 | **加密**（其余块原样 LZ4HC 可解） |
| 数据块 1..N | LZ4HC 压缩 | 不改 |

解析实现：`tools/lumi/fairguard.py`（`FairGuardBundle`，BE 头 + 块表 + 目录 + 分块提取），
CLI：`python3 -m lumi unbundle <__data>`。flags=0x243 = 0x200(BlockInfoNeedPaddingAtStart) |
0x40(BlocksAndDirectoryInfoCombined) | 0x3(LZ4HC)；blocksinfo 前 16 字节为全零 hash。

### 11.3 数据块 0 的加密

- 密文前 8 字节 = 固定魔数 `B0 A6 A7 A6 B0 B0 AD A6`（377 个 bundle 全部一致），
  其后为流密码密文。
- **确定性加密、无 per-file nonce**：内容相同的首块密文逐字节相同
  （377 个 ClientStatic bundle 中，同 uSize 的组两两 XOR 全零；cSize 不等时前 256 字节也相同）。
  cSize-8 不是 16 的倍数 → 排除 ECB/CBC，确定为**定长异或密钥流**（CTR 类）。
- 密钥流提取路径：运行时 hook Unity LZ4HC 解压入口（`UnityPlayer` 内嵌 lz4），
  抓 block0 的输入缓冲（=解密后压缩流）与磁盘密文异或即得；或从内存找
  解密后的 block0（实测 Unity 的合并流里 block0 位置为零填充，FairGuard 单独管理该块）。
- 影响面：不影响 Linux 启动器（游戏自解密；repair 校验的是 CDN 上的原文件 MD5）。

### 11.4 HybridCLR 热更 DLL —— 47 个全部提取

`res/downloads/Dll/e8164f-Preload-61-1.zip`（13.3 MB，标准 zip）内含
`7c/7cffd28b…/__data` = 上节格式的 bundle；其数据流 = YooAsset CAB 容器
（单文件 "CAB-fce08ff5…"，29,575,516 字节）：**文件表 + 47 个原样存放的 PE**。

- 只有首块（128 KiB）加密，且 47 个 DLL 全部位于首块之后 → **全部完整切出**
  （`recon/carved2/`，自动解析 .NET metadata 的 Module 表命名）：
  最大的是 `Assembly-ACT.dll`（14.6 MB，游戏业务逻辑本体），其余为
  `System.Core`、`YooAsset`、`Bamboo.*`、`Sirenix.*`、`DOTween`、`UniTask`、
  `UnityEngine.CoreModule`、`mscorlib`、`BehaviorDesigner`、`Proxima` 等。
  加密的首块只包含 CAB 文件表头部（0x20000 起的表体在明文区，记录为 24 字节一组，
  含相对偏移/大小/哈希类字段；表头未解出，不影响 DLL 提取）。
- 工具：`python3 -m lumi carve <dll_cab.plain>`（`tools/lumi/fairguard.py::carve_pe_files`）。
- 说明：这些是 **HybridCLR 热更代码**（业务逻辑），用 ILSpy/dnSpy 可直接看源码级逻辑；
  与 §11.1 的元数据 dump 互补（元数据覆盖 AOT 部分的符号）。

### 11.5 FairGuard 内存布局与 IL2CPP 注册结构

- `GameAssembly.dll` / `UnityPlayer.dll` 磁盘上原节（.text/.il2cpp/.rdata/.data）**全被清零**，
  真实内容整体搬进 `.fgtext3`（熵 7.93 的密文 blob）；运行时由 FairGuard 解密到匿名映射：
  ```
  6fffee6c0000  r--p  GameAssembly.dll 头部页（4 KiB）
  6fffee6c1000  r-xp  解密 .text+.il2cpp（约 61 MiB，含按页解密空隙）
  6ffff23e0000  r--p  解密 .rdata（17.9 MiB）
  6ffff34f1000  rw-p  解密 .data（6.98 MiB）
  6ffff3b9b000  r--p  .pdata；6ffff3eb2000 rwxp 解密 VM 节（.fgtext0/1/2）
  ```
  （地址为分析会话实测值；ASLR 下每次启动不同，但各区相对顺序与大小固定。）
- `FairGuardProtect.dll`：无真导出（5 个假符号），核心逻辑在 `.fgtext0`（6.9 MB，
  内嵌 Lua 解释器的 VM 字节码），钩子通过外部 hook 打在 il2cpp/Unity 函数上；
  反调试用 `K32EnumDeviceDrivers`/`EnumWindows`/`IsDebuggerPresent` + 独立看门狗进程
  `game_security_protection.exe`（在 Wine 下均未拦截 ptrace 短扫描）。
- **codeReg 已精确定位**（.rdata 内）：2022.3.62 的 `Il2CppCodeRegistration` 无 version 字段，
  布局 = {reversePInvokeWrapperCount, reversePInvokeWrappers, genericMethodPointersCount,
  genericMethodPointers, genericAdjustorThunks, invokerPointersCount, invokerPointers,
  unresolvedVirtualCallCount, unresolvedVirtualCallPointers, unresolvedInstanceCallPointers,
  unresolvedStaticCallPointers, interopDataCount, interopData, windowsRuntimeFactoryCount,
  windowsRuntimeFactoryTable, codeGenModulesCount, codeGenModules}（u32 计数 + 8 字节指针交错）。
  实测值：rPInvoke=65 / gmpc=170603 / ipc=32252 / uvcc=5431 / idc=1227 /
  **cgmc=139（=image 数）**；`codeGenModules` 指向 .data 内的 139 项模块表，
  模块名（Assembly-CSharp.dll、Assembly-ACT…、UnityEngine.*、System.* 等 139 个）
  全部在 .rdata 中可读。
- metadataReg 判别值已锁定：typesCount=64275、fieldOffsetsCount=89583、
  typeDefinitionsSizesCount=20189；运行时地址在 .data/.rdata/元数据缓冲之外
  （独立 heap 分配），用 `recon/scanregs.py` 对活进程扫即可收尾。
