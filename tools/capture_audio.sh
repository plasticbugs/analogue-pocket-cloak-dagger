#!/bin/sh
# Record MAME's audio for the same sequence sim/run_audio.sh drives the core
# through -- coin at frame 120, start at frame 200, then the game's own opening
# -- so there is actual sound to compare. Attract mode is silent for its first
# fifteen seconds, which makes it useless as an audio reference.
#   tools/capture_audio.sh [frames]      (default 1500)
set -e
cd "$(dirname "$0")/.."
FRAMES=${1:-1500}
SECS=$(python3 -c "print(int($FRAMES/60)+4)")
SCR=/tmp/cloak-audio
rm -rf "$SCR"; mkdir -p "$SCR/cfg" "$SCR/nvram" artifacts/audio
cat > "$SCR.lua" <<LUA
local m=manager.machine
local f={}
for _,p in ipairs({":P1",":SYSTEM",":START"}) do
  local port=m.ioport.ports[p]
  if port then for n,fl in pairs(port.fields) do f[n]=fl end end
end
local n=0
emu.register_frame_done(function()
  n=n+1
  if n==120 then f["Coin 1"]:set_value(1) end
  if n==128 then f["Coin 1"]:set_value(0) end
  if n==200 then f["1 Player Start"]:set_value(1) end
  if n==208 then f["1 Player Start"]:set_value(0) end
  if n>=$FRAMES then m:exit() end
end)
LUA
mame cloak -rompath "$PWD/build/roms" -video none -nothrottle -skip_gameinfo \
    -cfg_directory "$SCR/cfg" -nvram_directory "$SCR/nvram" \
    -samplerate 48000 -wavwrite artifacts/audio/mame_play.wav \
    -autoboot_script "$SCR.lua" -seconds_to_run "$SECS" 2>&1 | tail -2
ls -l artifacts/audio/mame_play.wav
