#!/bin/sh
# Run MAME headless on cloak with disposable cfg/nvram dirs and a Lua script.
#   tools/mame_run.sh <script.lua> [extra mame args]
# ROMPATH defaults to build/roms (where tools/stage_romset.sh puts cloak.zip).
#
# Nothing here may touch the display.  `-video none` stops MAME rendering to a
# window but not creating one, and MAME's defaults are fullscreen (window 0,
# maximize 1), which on macOS makes the desktop jump to another Space on every
# run.  SDL_VIDEODRIVER=dummy keeps SDL off the display (read before MAME
# parses anything), -videodriver dummy says the same through MAME, and
# -window -nomaximize keep any window that is created small.  Never
# -fullscreen.  (The same as moomesa's tools/mame.sh.)
set -e
cd "$(dirname "$0")/.."
SCRIPT=$1; shift
GAME=${GAME:-cloak}
ROMPATH=${ROMPATH:-$PWD/build/roms}
SCRATCH=${SCRATCH:-/tmp/cloak-mame}
mkdir -p "$SCRATCH/cfg" "$SCRATCH/nvram" "$SCRATCH/snap"
SDL_VIDEODRIVER=dummy \
exec mame "$GAME" -rompath "$ROMPATH" -video none -videodriver dummy -window -nomaximize \
    -sound none -nothrottle -skip_gameinfo \
    -cfg_directory "$SCRATCH/cfg" -nvram_directory "$SCRATCH/nvram" -snapshot_directory "$SCRATCH/snap" \
    -autoboot_script "$SCRIPT" -seconds_to_run "${SECONDS_TO_RUN:-600}" "$@"
