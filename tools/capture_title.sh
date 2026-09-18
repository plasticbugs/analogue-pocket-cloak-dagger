#!/bin/sh
# Find the title screen in the attract loop and regenerate the Pocket artwork
# from it, so both assets come from the game's own raster rather than a redraw.
#   tools/capture_title.sh
set -e
cd "$(dirname "$0")/.."
SCR=/tmp/cloak-title
rm -rf "$SCR"
cat > "$SCR.lua" <<'LUA'
local m=manager.machine
local n=0
emu.register_frame_done(function()
  n=n+1
  if n % 60 == 0 and n <= 9000 then m.video:snapshot() end
  if n >= 9000 then m:exit() end
end)
LUA
SCRATCH=$SCR SECONDS_TO_RUN=180 tools/mame_run.sh "$SCR.lua" >/dev/null 2>&1
# the title frame is the one with the most of the logo's red and its white box
python3 - "$SCR/snap/cloak" <<'PY'
import sys, os
sys.path.insert(0, 'tools')
import pngio
d = sys.argv[1]
best = (-1, None)
for f in sorted(os.listdir(d)):
    w, h, rgb = pngio.read(os.path.join(d, f))
    white = red = 0
    for y in range(20, 200):
        for x in range(0, 256, 2):
            i = (y * w + x) * 3
            r, g, b = rgb[i], rgb[i + 1], rgb[i + 2]
            if r > 200 and g > 200 and b > 200: white += 1
            elif r > 180 and g < 70 and b < 70: red += 1
    if white > 800 and red > 4000 and white + red > best[0]:
        best = (white + red, os.path.join(d, f))
if best[1] is None:
    sys.exit('no title frame found in the attract loop')
print('title frame:', best[1])
open('build/title.png', 'wb').write(open(best[1], 'rb').read())
PY
python3 tools/make_images.py build/title.png --preview
