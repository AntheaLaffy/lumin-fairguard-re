#!/bin/bash
set -euo pipefail

die() { printf '错误：%s\n' "$*" >&2; exit 1; }
for tool in curl jq 7z strings stat sha256sum; do
    command -v "$tool" >/dev/null || die "缺少系统工具：$tool"
done
root=${CHRONOLEAF_INSTALL_ROOT:?请通过 install.sh 和 Lutris 安装向导运行}
setup=${CHRONOLEAF_INSTALLER:?未提供官方安装包}
[[ -f $setup ]] || die '找不到原始安装包。'
[[ ! -e "$root/game/Lumin.exe" ]] || die '目标目录已经有游戏，请选择新的空安装目录，避免覆盖现有安装。'
mkdir -p -- "$root/cache" "$root/official-installer" "$root/game"

# Never execute NSIS: its launcher bootstrap would install WebView2 and .NET.
printf '解包并核对官方 B站安装包…\n'
7z x -y "-o$root/official-installer" "$setup" 'app/*' > "$root/cache/installer-extract.log"
launcher="$root/official-installer/app/Lumin.Launcher.dll"
[[ -f $launcher ]] || die '安装包结构不受支持：缺少 app/Lumin.Launcher.dll。'
strings -el "$launcher" > "$root/cache/launcher-strings.txt"
grep -Fxq bilibili "$root/cache/launcher-strings.txt" || die '当前方案只支持 B站渠道官方安装包。'

# The bootstrap package is not the game. Discover its current official payload.
device_id=$(cat /proc/sys/kernel/random/uuid)
body=$(jq -cn --arg device "$device_id" '{region:"CN",launcher_env:"Prod",channel:"bilibili",device_id:$device}')
printf '查询官方当前游戏版本…\n'
curl --fail --location --retry 3 --max-time 60 --proto '=https' --proto-redir '=https' \
    --header 'Content-Type: application/json' --data "$body" \
    --output "$root/cache/version.json" https://lmapi.zhuziplay.com/launcher/app
jq -e '
    .code == 0 and (.data | .channel == "bilibili" and .env == "Prod" and
    (.client_version | type == "string") and (.build_id | type == "number") and
    (.zip_size | type == "number" and . > 0) and
    (.download_url | type == "string" and startswith("https://")))
' "$root/cache/version.json" >/dev/null || die '官方版本接口返回了不支持的结构，已停止安装。'
build=$(jq -r '.data.build_id' "$root/cache/version.json")
url=$(jq -r '.data.download_url' "$root/cache/version.json")
size=$(jq -r '.data.zip_size' "$root/cache/version.json")
archive="$root/cache/client-$build.zip"
printf '下载游戏本体（build %s，约 %s 字节；支持续传）…\n' "$build" "$size"
if [[ ! -f $archive ]] || [[ $(stat -Lc %s -- "$archive") != "$size" ]]; then
    curl --fail --location --retry 3 --continue-at - --proto '=https' --proto-redir '=https' \
        --output "$archive.part" "$url" || die '游戏下载失败；重新安装可继续下载。'
    [[ $(stat -c %s -- "$archive.part") == "$size" ]] || die '下载长度与官方清单不符。'
    mv -- "$archive.part" "$archive"
fi
7z t "$archive" > "$root/cache/client-check.log" || die '游戏 ZIP 完整性检查失败。'
7z x -y "-o$root/game" "$archive" > "$root/cache/client-extract.log"
[[ -f "$root/game/Lumin.exe" && -f "$root/game/Lumin_Data/StreamingAssets/app_config.json" ]] ||
    die '游戏包目录结构发生变化，暂不支持此版本。'
jq -e '.sdk_channel == "bilibili"' "$root/game/Lumin_Data/StreamingAssets/app_config.json" >/dev/null ||
    die '下载的游戏包渠道与安装方案不匹配。'
jq --arg source_sha "$(sha256sum -- "$setup" | cut -d ' ' -f 1)" \
    '{installer_sha256:$source_sha,client_version:.data.client_version,build_id:.data.build_id,channel:.data.channel}' \
    "$root/cache/version.json" > "$root/chronoleaf-install.json"
printf '游戏本体已就绪。首次启动由官方客户端继续下载资源，并正常登录账号。\n'
