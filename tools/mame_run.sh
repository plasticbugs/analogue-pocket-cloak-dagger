#!/bin/sh
# Run MAME headless on cloak with disposable cfg/nvram dirs and a Lua script.
#   tools/mame_run.sh <script.lua> [extra mame args]
# ROMPATH defaults to build/roms (where tools/stage_romset.sh puts cloak.zip).
set -e
cd "$(dirname "$0")/.."
SCRIPT=$1; shift
GAME=${GAME:-cloak}
ROMPATH=${ROMPATH:-$PWD/build/roms}
SCRATCH=${SCRATCH:-/tmp/cloak-mame}
mkdir -p "$SCRATCH/cfg" "$SCRATCH/nvram" "$SCRATCH/snap"
exec mame "$GAME" -rompath "$ROMPATH" -video none -sound none -nothrottle -skip_gameinfo \
    -cfg_directory "$SCRATCH/cfg" -nvram_directory "$SCRATCH/nvram" -snapshot_directory "$SCRATCH/snap" \
    -autoboot_script "$SCRIPT" -seconds_to_run "${SECONDS_TO_RUN:-600}" "$@"
