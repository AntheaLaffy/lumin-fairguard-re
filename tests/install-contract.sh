#!/bin/bash
set -euo pipefail

# Exercise path quoting and XDG isolation without downloading or launching games.
repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
scratch=$(mktemp -d)
trap 'rm -rf -- "$scratch"' EXIT
data="$scratch/other user's data"
cache="$scratch/cache with spaces"
mkdir -p "$data/chronoleaf/runtime/wine-11.21/bin" "$data/chronoleaf/runtime/dxvk-3.0.2" "$scratch/bin"
cd -- "$scratch"
printf '%s\n' 33f3c5b56b1deb8f6725539ea006f27b5d781b3b4ae6a8a1f492d8af4fb9dc83 \
    > "$data/chronoleaf/runtime/wine-11.21/.chronoleaf-sha256"
printf '%s\n' 9c538924110a7cdef871ca36dee218c0774124374ffdeb38af4b76be55bdf7c2 \
    > "$data/chronoleaf/runtime/dxvk-3.0.2/.chronoleaf-sha256"
printf '#!/bin/sh\nprintf "wine-11.21\\n"\n' > "$data/chronoleaf/runtime/wine-11.21/bin/wine"
printf '#!/bin/sh\nexit 99\n' > "$scratch/bin/lutris"
chmod +x "$data/chronoleaf/runtime/wine-11.21/bin/wine" "$scratch/bin/lutris"
setup="$scratch/官方 ' 安装包 \$(touch UNEXPECTED_COMMAND).exe"
: > "$setup"
env XDG_DATA_HOME="$data" XDG_CACHE_HOME="$cache" PATH="$scratch/bin:$PATH" \
    bash "$repo/install.sh" --prepare-only "$setup"
descriptor="$cache/chronoleaf/lvmeng-bilibili.json"
jq -e --arg setup "$setup" --arg data "$data" '
    .script.files[0].setup == $setup and
    .script.game.exe == "$GAMEDIR/game/Lumin.exe" and
    .script.game.prefix == "$GAMEDIR/prefix" and
    .script.wine.version == "chronoleaf-11.21-x86_64" and
    .script.wine.dxvk_version == ($data + "/chronoleaf/runtime/dxvk-3.0.2") and
    .script.installer[0].execute.env.CHRONOLEAF_INSTALLER == "$setup" and
    .script.installer[1].task.install_mono == false and
    .script.installer[1].task.install_gecko == false
' "$descriptor" >/dev/null
python3 - "$descriptor" "$data/chronoleaf/install-support/prepare-game.sh" <<'PY'
import json, shlex, sys
with open(sys.argv[1]) as f:
    obj = json.load(f)
assert shlex.split(obj['script']['installer'][0]['execute']['args']) == [sys.argv[2]]
PY
[[ ! -e UNEXPECTED_COMMAND ]]
[[ -L "$data/lutris/runners/wine/chronoleaf-11.21-x86_64" ]]
if env CHRONOLEAF_INSTALL_ROOT="$scratch/rejected" CHRONOLEAF_INSTALLER="$scratch/missing.exe" \
    bash "$repo/installers/prepare-game.sh" > "$scratch/rejected.log" 2>&1; then
    printf 'Missing installer was incorrectly accepted.\n' >&2
    exit 1
fi
[[ ! -e "$scratch/rejected" ]]
printf '安装契约检查通过：XDG 路径、空格/引号、原始包参数与缺失输入处理。\n'
