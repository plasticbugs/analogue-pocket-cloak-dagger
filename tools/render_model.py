#!/usr/bin/env python3
"""Reference renderer for the Cloak & Dagger core.

Renders one 256x232 frame from a state file written by tools/dump_state.lua
exactly as MAME's cloak_state::screen_update does (ref/mame/cloak.cpp), so it
can be diffed against MAME's own snapshot and then used as the executable spec
for the RTL. Pure Python 3, no dependencies (tools/pngio.py for PNG).

    render_model.py <state.txt> [--rom build/cloak.rom] [--out frame.png]
                    [--layer pf|bmp|spr|all] [--compare mame.png] [--diff diff.png]
                    [--indices indices.bin] [--quiet]

The semantics are documented in docs/hardware.md section 5.
"""
import sys, os, argparse
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pngio

# native raster and the visible window MAME snapshots (set_visarea(0,255,24,255))
NATIVE_W, NATIVE_H = 256, 256
VIS_X0, VIS_X1, VIS_Y0, VIS_Y1 = 0, 255, 24, 255
VIS_W, VIS_H = VIS_X1 - VIS_X0 + 1, VIS_Y1 - VIS_Y0 + 1

# regions inside the .rom image (docs/hardware.md section 7 / cloak.mra)
R_MASTER = (0x00100, 49152)
R_SLAVE  = (0x0c100, 57344)
R_CHARS  = (0x1a100, 8192)
R_SPRITE = (0x1c100, 8192)
R_PROM   = (0x1e100, 256)

# MAME gfx_cloak layouts, in MAME's own terms: bit offsets within the region,
# plane 0 first (most significant bit of the pixel).
CHAR_LAYOUT   = dict(w=8,  h=8,  planes=(0, 1, 2, 3),
                     xoffs=(0x1000 * 8 + 0, 0x1000 * 8 + 4, 0, 4,
                            0x1000 * 8 + 8, 0x1000 * 8 + 12, 8, 12),
                     yoffs=tuple(i * 16 for i in range(8)),  inc=16 * 8)
SPRITE_LAYOUT = dict(w=8, h=16, planes=(0, 1, 2, 3),
                     xoffs=CHAR_LAYOUT['xoffs'],
                     yoffs=tuple(i * 16 for i in range(16)), inc=16 * 16)

# The three colour guns are 3-bit ladders of 10k / 4.7k / 2.2k pulled up
# through 1k; MAME's compute_resistor_weights turns that into these eight
# levels (tools/gen_palette_table.py derives them). Index bit 0 is the 10k
# leg, bit 2 the 2.2k leg. Nothing like linear -- do not approximate.
GUN = (0, 74, 82, 157, 98, 173, 181, 255)


# ----------------------------------------------------------------- state file
class State:
    """A tools/dump_state.lua dump: scalars, arrays, and the bitmap buffer."""

    def __init__(self, path):
        self.path = path
        self.scalars, self.arrays = {}, {}
        with open(path) as f:
            tokens = f.read().split('\n')
        i = 0
        while i < len(tokens):
            line = tokens[i].strip()
            i += 1
            if not line:
                continue
            parts = line.split()
            if parts[0].endswith('[]'):
                name, count = parts[0][:-2], int(parts[1])
                vals = []
                while len(vals) < count:
                    vals += [int(t, 16) for t in tokens[i].split()]
                    i += 1
                self.arrays[name] = vals[:count]
            else:
                base = 10 if parts[0] in ('frame', 'real_frame') else 16
                self.scalars[parts[0]] = int(parts[1], base)
        bin_path = path[:-4] + '.bin'
        with open(bin_path, 'rb') as f:
            self.bitmap = f.read()
        if len(self.bitmap) != 65536:
            raise ValueError(f'{bin_path}: expected 65536 bytes, got {len(self.bitmap)}')

    def __getitem__(self, k):
        return self.scalars[k]

    @property
    def videoram(self):
        return self.arrays['videoram']

    @property
    def spriteram(self):
        return self.arrays['spriteram']

    @property
    def palette(self):
        return self.arrays['palette']

    @property
    def flip(self):
        return bool(self.scalars.get('flip_x', 0))


# ---------------------------------------------------------------------- gfx
def decode_gfx(region, layout, count):
    """-> list of `count` tiles, each a flat list of w*h pixel values.

    Straight from MAME's gfx_layout semantics: pixel (x, y) of element n takes
    its plane p bit from region bit (n*inc + yoffs[y] + xoffs[x] + planes[p]),
    where bit k of the region is bit (7 - k%8) of byte k//8 and plane 0 is the
    most significant bit of the pixel.
    """
    w, h, planes = layout['w'], layout['h'], layout['planes']
    xoffs, yoffs, inc = layout['xoffs'], layout['yoffs'], layout['inc']
    nplanes = len(planes)
    tiles = []
    for n in range(count):
        base = n * inc
        tile = []
        for y in range(h):
            row = base + yoffs[y]
            for x in range(w):
                bitbase = row + xoffs[x]
                val = 0
                for p in range(nplanes):
                    k = bitbase + planes[p]
                    bit = (region[k >> 3] >> (7 - (k & 7))) & 1
                    val |= bit << (nplanes - 1 - p)
                tile.append(val)
        tiles.append(tile)
    return tiles


class Rom:
    def __init__(self, path):
        with open(path, 'rb') as f:
            self.image = f.read()
        if len(self.image) < R_PROM[0] + R_PROM[1]:
            raise ValueError(f'{path}: too short to be a cloak image')
        if self.image[:4] != b'CLDG':
            raise ValueError(f'{path}: not a cloak image (magic {self.image[:4]!r})')
        self.chars_rgn = self.region(R_CHARS)
        self.sprites_rgn = self.region(R_SPRITE)
        self.chars = decode_gfx(self.chars_rgn, CHAR_LAYOUT, 256)
        self.sprites = decode_gfx(self.sprites_rgn, SPRITE_LAYOUT, 128)
        self.prom = self.region(R_PROM)

    def region(self, r):
        return self.image[r[0]:r[0] + r[1]]


# ------------------------------------------------------------------ rendering
def render_indices(state, rom, layers='all'):
    """-> bytearray of NATIVE_W*NATIVE_H palette indices, MAME's draw order.

    Rows outside the visible window are left at 0: MAME only ever draws the
    cliprect, and the bitmap and sprite passes are clipped to it too.
    """
    idx = bytearray(NATIVE_W * NATIVE_H)
    vram, sram, bmp = state.videoram, state.spriteram, state.bitmap
    flip = state.flip

    # --- playfield: 32x32 tiles of 8x8, opaque, palette base 0 -------------
    if layers in ('all', 'pf'):
        chars = rom.chars
        for ty in range(32):
            for tx in range(32):
                tile = chars[vram[ty * 32 + tx] & 0xff]
                ox, oy = tx * 8, ty * 8
                for y in range(8):
                    o = (oy + y) * NATIVE_W + ox
                    idx[o:o + 8] = bytes(tile[y * 8:y * 8 + 8])

    # --- bitmap: pen 0 transparent, column shifted by 6, 128H picks the bank
    if layers in ('all', 'bmp'):
        for y in range(VIS_Y0, VIS_Y1 + 1):
            rowbase = y << 8
            out = y * NATIVE_W
            for x in range(VIS_X0, VIS_X1 + 1):
                pen = bmp[rowbase | x] & 0x07
                if pen:
                    idx[out + ((x - 6) & 0xff)] = 0x10 | ((x & 0x80) >> 4) | pen

    # --- motion objects: 63 down to 0, so sprite 0 lands on top ------------
    if layers in ('all', 'spr'):
        sprites = rom.sprites
        for offs in range(63, -1, -1):
            code = sram[offs + 64] & 0x7f
            flipx = bool(sram[offs + 64] & 0x80)
            flipy = False
            sx = sram[offs + 192]
            sy = 240 - sram[offs]
            if flip:
                sx -= 9
                sy = 240 - sy
                flipx = not flipx
                flipy = not flipy
            tile = sprites[code]
            for y in range(16):
                py = sy + y
                if not (VIS_Y0 <= py <= VIS_Y1):
                    continue
                sy_src = 15 - y if flipy else y
                out = py * NATIVE_W
                for x in range(8):
                    px = sx + x
                    if not (VIS_X0 <= px <= VIS_X1):
                        continue
                    pen = tile[sy_src * 8 + (7 - x if flipx else x)]
                    if pen:
                        idx[out + px] = 32 + pen
    return idx


def palette_rgb(state):
    """-> list of 64 (r, g, b), MAME's set_pen: nine active-low bits, three per
    gun, through the resistor ladder."""
    out = []
    for v in state.palette:
        inv = ~v
        out.append((GUN[(inv >> 6) & 7], GUN[(inv >> 3) & 7], GUN[inv & 7]))
    return out


def render(state, rom, layers='all'):
    """-> (VIS_W, VIS_H, bytearray RGB) -- the frame MAME snapshots."""
    idx = render_indices(state, rom, layers)
    pal = palette_rgb(state)
    rgb = bytearray(VIS_W * VIS_H * 3)
    o = 0
    for y in range(VIS_Y0, VIS_Y1 + 1):
        row = y * NATIVE_W
        for x in range(VIS_X0, VIS_X1 + 1):
            r, g, b = pal[idx[row + x] & 0x3f]
            rgb[o] = r; rgb[o + 1] = g; rgb[o + 2] = b
            o += 3
    return VIS_W, VIS_H, rgb, idx


# ----------------------------------------------------------------------- main
def compare(w, h, ours, ref_path, diff_path=None, quiet=False):
    rw, rh, theirs = pngio.read(ref_path)
    if (rw, rh) != (w, h):
        print(f'size mismatch: ours {w}x{h}, {ref_path} {rw}x{rh}')
        return 1
    ndiff = 0
    cells = {}
    out = bytearray(len(ours))
    for i in range(0, len(ours), 3):
        if ours[i:i + 3] != theirs[i:i + 3]:
            ndiff += 1
            p = i // 3
            cells[(p // w // 16, p % w // 16)] = cells.get((p // w // 16, p % w // 16), 0) + 1
            out[i:i + 3] = b'\xff\x00\x00'
        else:
            out[i] = ours[i] // 3; out[i + 1] = ours[i + 1] // 3; out[i + 2] = ours[i + 2] // 3
    total = len(ours) // 3
    if not quiet:
        print(f'diff {ndiff}/{total} ({100.0 * ndiff / total:.3f}%)')
        for k, n in sorted(cells.items(), key=lambda kv: -kv[1])[:12]:
            print(f'  cell row{k[0]:2d} col{k[1]:2d}: {n} px')
    if diff_path:
        pngio.write(diff_path, w, h, out)
    return 0 if ndiff == 0 else 1


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('state')
    ap.add_argument('--rom', default='build/cloak.rom')
    ap.add_argument('--out')
    ap.add_argument('--layer', default='all', choices=('all', 'pf', 'bmp', 'spr'))
    ap.add_argument('--compare')
    ap.add_argument('--diff')
    ap.add_argument('--indices', help='write the raw palette indices (256x256 bytes)')
    ap.add_argument('--quiet', action='store_true')
    args = ap.parse_args()

    state = State(args.state)
    rom = Rom(args.rom)
    w, h, rgb, idx = render(state, rom, args.layer)
    if args.out:
        pngio.write(args.out, w, h, rgb)
        if not args.quiet:
            print(f'wrote {args.out} ({w}x{h})')
    if args.indices:
        with open(args.indices, 'wb') as f:
            f.write(idx)
    ref = args.compare
    if ref is None:
        cand = args.state[:-4] + '.png'
        if os.path.exists(cand):
            ref = cand
    if ref:
        return compare(w, h, rgb, ref, args.diff, args.quiet)
    return 0


if __name__ == '__main__':
    sys.exit(main())
