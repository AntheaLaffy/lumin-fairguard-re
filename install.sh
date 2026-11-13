#!/bin/bash
set -euo pipefail

# Keep runtime versions independent of the distribution's Wine package.
wine_version=11.21
wine_sha=33f3c5b56b1deb8f6725539ea006f27b5d781b3b4ae6a8a1f492d8af4fb9dc83
dxvk_version=3.0.2
dxvk_sha=9c538924110a7cdef871ca36dee218c0774124374ffdeb38af4b76be55bdf7c2

die() { printf '错误：%s\n' "$*" >&2; exit 1; }
usage() {
    printf '用法：bash install.sh [--prepare-only] /路径/官方B站安装包.exe\n'
    printf '下载固定运行环境并打开 Lutris 安装向导；--prepare-only 仅生成安装描述。\n'
}

prepare_only=false
if [[ ${1:-} == --help || ${1:-} == -h ]]; then usage; exit 0; fi
if [[ ${1:-} == --prepare-only ]]; then prepare_only=true; shift; fi
[[ $# == 1 ]] || { usage >&2; exit 1; }
[[ $(uname -m) == x86_64 ]] || die '当前安装方案仅支持 x86_64 Linux。'
[[ $EUID != 0 ]] || die '请用日常桌面用户执行，不要用 sudo 运行此脚本。'
for tool in curl jq tar sha256sum 7z strings lutris realpath; do
    command -v "$tool" >/dev/null || die "缺少 $tool，请先按 README 安装系统依赖。"
done
[[ -f $1 ]] || die "找不到安装包：$1"
setup=$(realpath -- "$1")
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
data_dir=${XDG_DATA_HOME:-"$HOME/.local/share"}/chronoleaf
cache_dir=${XDG_CACHE_HOME:-"$HOME/.cache"}/chronoleaf
mkdir -p -- "$data_dir/runtime" "$data_dir/install-support" "$cache_dir"

install_runtime() {
    local name=$1 url=$2 hash=$3 archive="$cache_dir/$1.archive" staging
    if [[ -f "$data_dir/runtime/$name/.chronoleaf-sha256" ]] &&
       [[ $(cat -- "$data_dir/runtime/$name/.chronoleaf-sha256") == "$hash" ]]; then
        return
    fi
    [[ ! -e "$data_dir/runtime/$name" ]] || die "运行环境目录已存在且校验标记不符：$name"
    if [[ ! -f $archive ]] || ! printf '%s  %s\n' "$hash" "$archive" | sha256sum -c --status; then
        printf '下载 %s…\n' "$name"
        curl --fail --location --retry 3 --proto '=https' --proto-redir '=https' \
            --output "$archive.part" "$url"
        printf '%s  %s\n' "$hash" "$archive.part" | sha256sum -c --status || die "$name 下载校验失败。"
        mv -- "$archive.part" "$archive"
    fi
    staging=$(mktemp -d "$data_dir/runtime/.unpack-XXXXXX")
    if ! tar -xf "$archive" --strip-components=1 -C "$staging"; then
        rm -rf -- "$staging"
        die "$name 解包失败。"
    fi
    printf '%s\n' "$hash" > "$staging/.chronoleaf-sha256"
    mv -- "$staging" "$data_dir/runtime/$name"
}

install_runtime "wine-$wine_version" \
    "https://github.com/Kron4ek/Wine-Builds/releases/download/$wine_version/wine-$wine_version-amd64-wow64.tar.xz" "$wine_sha"
install_runtime "dxvk-$dxvk_version" \
    "https://github.com/doitsujin/dxvk/releases/download/v$dxvk_version/dxvk-$dxvk_version.tar.gz" "$dxvk_sha"
wine_bin="$data_dir/runtime/wine-$wine_version/bin/wine"
"$wine_bin" --version || die 'Wine 无法运行，请检查 README 中的系统运行库要求。'
runner_name="chronoleaf-$wine_version-x86_64"
runner_dir=${XDG_DATA_HOME:-"$HOME/.local/share"}/lutris/runners/wine
mkdir -p -- "$runner_dir"
if [[ -e "$runner_dir/$runner_name" || -L "$runner_dir/$runner_name" ]]; then
    [[ $(realpath -- "$runner_dir/$runner_name") == "$data_dir/runtime/wine-$wine_version" ]] ||
        die "Lutris 中已有不同的同名运行器：$runner_name"
else
    ln -s -- "$data_dir/runtime/wine-$wine_version" "$runner_dir/$runner_name"
fi

# Lutris must remain usable after the checkout is moved or removed.
cp -- "$script_dir/installers/prepare-game.sh" "$data_dir/install-support/prepare-game.sh"
helper="$data_dir/install-support/prepare-game.sh"
descriptor="$cache_dir/lvmeng-bilibili.json"
jq -n --arg setup "$setup" --arg helper "$helper" --arg runner "$runner_name" \
    --arg dxvk "$data_dir/runtime/dxvk-$dxvk_version" '
{
  name: "绿梦：时空之声（B站·时叶配置）",
  game_slug: "chronoleaf-lvmeng-bilibili",
  slug: "chronoleaf-lvmeng-bilibili-wine-11-21",
  version: "B站官方客户端 / 时叶 Wine 11.21 + DXVK 3.0.2",
  runner: "wine",
  script: {
    files: [{setup: $setup}],
    game: {
      exe: "$GAMEDIR/game/Lumin.exe",
      prefix: "$GAMEDIR/prefix",
      working_dir: "$GAMEDIR/game",
      arch: "win64",
      args: "-launcher=lm -cps= -force-d3d11 -screen-fullscreen 0 -screen-width 1280 -screen-height 720"
    },
    wine: {
      version: $runner,
      Graphics: "x11", dxvk: true, dxvk_version: $dxvk,
      vkd3d: false, dxvk_nvapi: false,
      esync: false, fsync: false, show_debug: "-all"
    },
    system: {disable_runtime: true},
    installer: [
      {execute: {
        file: "/bin/bash", args: ($helper | @sh), disable_runtime: true,
        env: {CHRONOLEAF_INSTALL_ROOT: "$GAMEDIR", CHRONOLEAF_INSTALLER: "$setup"},
        description: "解包原始安装包，并从官方服务器下载和解压游戏本体"
      }},
      {task: {name: "create_prefix", prefix: "$GAMEDIR/prefix", arch: "win64",
              install_gecko: false, install_mono: false}}
    ]
  }
}' > "$descriptor"
printf '安装描述：%s\n' "$descriptor"
if ! $prepare_only; then exec lutris -i "$descriptor"; fi
