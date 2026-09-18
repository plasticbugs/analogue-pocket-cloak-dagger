#!/usr/bin/env python3
"""Cut the Pocket artwork's source images out of the game's own title screen.

This writes **PNGs only**. The Pocket's `.bin` image assets are a proprietary
format -- decoding one as 5-5-5 or 5-6-5, little- or big-endian, gives
convincing noise every time -- and the shipped
`pkg/pocket/Platforms/_images/cloak.bin` and
`pkg/pocket/Cores/<core>/icon.bin` are produced elsewhere and committed. An
earlier version of this script wrote `.bin` files in a format of its own
invention; it does not any more, and it will not overwrite the real assets.

What it does give you is the two crops at the right sizes, at 1:1 with the
arcade raster so every pixel is one the board drew:

    build/art/platform_521x165.png   the platform banner: 165 rows of the
                                     256-wide frame, centred on the black the
                                     game itself puts around the logo
    build/art/icon_36x36.png         the 36x36 square around the agent
                                     crouching between the two words

Convert those to `.bin` with whatever tool produces the Pocket's format.

    tools/make_images.py <title-screen.png> [--out build/art]

tools/capture_title.sh finds the title frame in the attract loop and hands it
over.
"""
import sys, os, argparse

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pngio

BANNER_W, BANNER_H = 521, 165
ICON_W, ICON_H = 36, 36

# The title screen is 256x232. These are the crops, in that frame's
# coordinates, chosen by eye from the captured frame and then checked with
# --preview.
BANNER_ROW0 = 40          # 165 rows from here: the logo and its red side bars
ICON_X, ICON_Y, ICON_SRC = 106, 94, 36   # the agent between CLOAK and DAGGER, 1:1


def make_banner(sw, sh, src):
    out = bytearray(BANNER_W * BANNER_H * 3)       # black
    x0 = (BANNER_W - sw) // 2
    for y in range(BANNER_H):
        sy = BANNER_ROW0 + y
        if not (0 <= sy < sh):
            continue
        for x in range(sw):
            si = (sy * sw + x) * 3
            di = (y * BANNER_W + x0 + x) * 3
            out[di:di + 3] = src[si:si + 3]
    return out


def make_icon(sw, sh, src):
    out = bytearray(ICON_W * ICON_H * 3)
    scale = ICON_W // ICON_SRC                     # 2
    for y in range(ICON_H):
        sy = ICON_Y + y // scale
        for x in range(ICON_W):
            sx = ICON_X + x // scale
            if 0 <= sx < sw and 0 <= sy < sh:
                si = (sy * sw + sx) * 3
                di = (y * ICON_W + x) * 3
                out[di:di + 3] = src[si:si + 3]
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('title', help='a PNG of the title screen (256x232)')
    ap.add_argument('--out', default='build/art')
    args = ap.parse_args()

    sw, sh, src = pngio.read(args.title)
    if (sw, sh) != (256, 232):
        sys.exit(f'{args.title}: expected the 256x232 arcade raster, got {sw}x{sh}')

    banner = make_banner(sw, sh, src)
    icon = make_icon(sw, sh, src)

    os.makedirs(args.out, exist_ok=True)
    bpath = os.path.join(args.out, 'platform_521x165.png')
    ipath = os.path.join(args.out, 'icon_36x36.png')
    pngio.write(bpath, BANNER_W, BANNER_H, banner)
    pngio.write(ipath, ICON_W, ICON_H, icon)
    print(f'wrote {bpath} ({BANNER_W}x{BANNER_H})')
    print(f'wrote {ipath} ({ICON_W}x{ICON_H})')
    print('these are source images only -- the shipped .bin assets are a '
          'proprietary format and are committed, not generated here')


if __name__ == '__main__':
    main()
