#!/usr/bin/env python3
"""Build the Pocket artwork from the game's own title screen.

Both Pocket image assets are raw 16-bit, little-endian, five bits per gun with
the top bit unused -- `(r << 10) | (g << 5) | b`:

    pkg/pocket/Platforms/_images/cloak.bin   521 x 165  the platform banner
    pkg/pocket/Cores/<core>/icon.bin          36 x 36   the core's icon

Both are 1:1 crops of the arcade raster -- no scaling anywhere, so every pixel
is one the board drew. The banner is 165 rows of the 256-wide frame centred on
the black the game itself puts around the logo; the icon is the 36x36 square
around the agent crouching between the two words.

    tools/make_images.py <title-screen.png> [--out pkg/pocket] [--preview]

tools/capture_title.sh finds the title frame in the attract loop and hands it
over, so the whole thing regenerates from a romset in about a minute.
"""
import sys, os, struct, argparse

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pngio

BANNER_W, BANNER_H = 521, 165
ICON_W, ICON_H = 36, 36

# The title screen is 256x232. These are the crops, in that frame's
# coordinates, chosen by eye from the captured frame and then checked with
# --preview.
BANNER_ROW0 = 40          # 165 rows from here: the logo and its red side bars
ICON_X, ICON_Y, ICON_SRC = 106, 94, 36   # the agent between CLOAK and DAGGER, 1:1


def pack555(r, g, b):
    """8-bit RGB -> the Pocket's little-endian 5-5-5 word."""
    return struct.pack('<H', ((r >> 3) << 10) | ((g >> 3) << 5) | (b >> 3))


def write_bin(path, w, h, rgb):
    with open(path, 'wb') as f:
        for i in range(w * h):
            f.write(pack555(rgb[i * 3], rgb[i * 3 + 1], rgb[i * 3 + 2]))
    return w * h * 2


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
    ap.add_argument('--out', default='pkg/pocket')
    ap.add_argument('--core', default='plasticbugs.cloak')
    ap.add_argument('--preview', action='store_true', help='also write PNGs next to the .bin files')
    args = ap.parse_args()

    sw, sh, src = pngio.read(args.title)
    if (sw, sh) != (256, 232):
        sys.exit(f'{args.title}: expected the 256x232 arcade raster, got {sw}x{sh}')

    banner = make_banner(sw, sh, src)
    icon = make_icon(sw, sh, src)

    bpath = os.path.join(args.out, 'Platforms', '_images', 'cloak.bin')
    ipath = os.path.join(args.out, 'Cores', args.core, 'icon.bin')
    os.makedirs(os.path.dirname(bpath), exist_ok=True)
    os.makedirs(os.path.dirname(ipath), exist_ok=True)
    nb = write_bin(bpath, BANNER_W, BANNER_H, banner)
    ni = write_bin(ipath, ICON_W, ICON_H, icon)
    print(f'wrote {bpath} ({nb} bytes, {BANNER_W}x{BANNER_H})')
    print(f'wrote {ipath} ({ni} bytes, {ICON_W}x{ICON_H})')
    if args.preview:
        pngio.write(bpath[:-4] + '_preview.png', BANNER_W, BANNER_H, banner)
        pngio.write(ipath[:-4] + '_preview.png', ICON_W, ICON_H, icon)
        print('wrote previews alongside')


if __name__ == '__main__':
    main()
