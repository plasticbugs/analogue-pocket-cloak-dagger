# Cloak & Dagger arcade hardware

Everything the core needs to know about the machine, taken from MAME 0.288
(`src/mame/atari/cloak.cpp`, `devices/sound/pokey.cpp`, `devices/machine/74259.cpp`,
all vendored under `ref/mame/`), from the vertical timing PROM in the romset, and
from interrogating the running driver with Lua. Written first, per METHODOLOGY
section 3 phase 1, and updated whenever a measurement contradicts it.

Target set: **`cloak`** -- Cloak & Dagger (rev 5), Atari, 1983. Addresses are hex.

---

## 1. Chips and clocks

| Part | Role | Clock | Source |
|---|---|---|---|
| MOS **6502** ("master") | game logic, video RAM, sprites, palette, sound, inputs | **1.0 MHz** (MAME; marked `????` in the driver -- see 1.1) | `M6502(config, m_maincpu, 1'000'000)` |
| MOS **6502** ("slave") | the bitmap graphics processor | **1.25 MHz** (MAME; also `????`) | `M6502(config, m_slave, 1'250'000)` |
| 2x Atari **POKEY** (C012294) | all sound; also the two input ports read through ALLPOT | **1.25 MHz** (10 MHz XTAL / 8) | `POKEY(config, "pokey1", XTAL(10'000'000)/8)`, commented "Accurate to recording" |
| **74LS259** (10B) | 8-bit addressable output latch: coin counters, flip screen, start LEDs | | `LS259(config, "outlatch")` |
| NVRAM | 512 bytes of non-volatile RAM at 2800-29ff (an X2212-class novram on the board) | | `NVRAM(config, "nvram", nvram_device::DEFAULT_ALL_0)` |
| Watchdog | kicked at 3a00 | | `WATCHDOG_TIMER(config, "watchdog")` |

The board has a single **10 MHz** crystal. The POKEY rate (10/8 = 1.25 MHz) is
the one number in this table that has been checked against a recording of real
hardware; everything else below is derived or assumed.

### 1.1 Open question: the master CPU clock

MAME runs the master at 1.000 MHz and the slave at 1.250 MHz, and flags both
with `????`. Both POKEYs sit on the **master's** bus (1000-100f and 1800-180f),
and a POKEY's single clock pin is both its bus clock and its audio clock, so on
the real board the master's phi2 and the POKEY clock are very likely the same
signal -- which would make the master 1.25 MHz as well, i.e. 10 MHz / 8 for the
master, the slave and both POKEYs alike.

The core follows MAME (1.0 / 1.25) until this is settled, because MAME is the
oracle every bench diffs against. Tracked in `docs/verification.md`; the game is
frame-locked to its IRQs, so the visible effect of getting this wrong is limited
to how much work each CPU completes between interrupts.

---

## 2. Video timing

The romset's `136023-116.3n` is an 82S129 (256 x 4) **vertical timing PROM**,
addressed by the 8-bit vertical counter. Only bits 1:0 are programmed:

| V | bit 1 | bit 0 | meaning |
|---|---|---|---|
| 0-2 | 1 | 0 | vertical blank |
| 3-5 | **0** | 0 | vertical blank + **VSYNC** (3 lines) |
| 6-22 | 1 | 0 | vertical blank |
| 23-254 | 1 | **1** | **active video** (232 lines) |
| 255 | 1 | 0 | vertical blank |

So: **256 lines per frame, 232 of them visible.** That matches MAME's visible
area exactly (`set_visarea(0, 255, 24, 255)` = 256 x 232); MAME's screen y is the
PROM's V index + 1, i.e. the video counter leads the displayed line by one.

MAME does not model horizontal timing at all (`set_refresh_hz(60)` and nothing
else). The working model here, to be confirmed:

- dot clock **5 MHz** (10 MHz / 2), **320 clocks per line**, 256 of them visible
- 320 x 256 = 81,920 dot clocks per frame -> **61.035 Hz**

320 clocks per line divides cleanly by both CPU dividers, which is the reason to
believe it: 320/4 = **80 slave cycles per line**, 320/5 = **64 master cycles per
line**. (If section 1.1 resolves to a 1.25 MHz master, that is 80 cycles for both.)

### 2.1 Interrupts

Both CPUs take IRQ only; neither uses NMI.

- **Master**: driver comment, "4 IRQ's per frame at even intervals, 4th IRQ is at
  start of VBLANK". Active video ends after V=254, so VBLANK begins at **V=255**.
  Four evenly spaced interrupts ending there put them at **V = 63, 127, 191, 255**
  -- that is, whenever the low 6 bits of V are all ones, which is exactly what a
  64V tap off the vertical counter gives. MAME instead uses a free-running
  240 Hz periodic timer, which is the same rate but not phase-locked to the beam.
- **Slave**: MAME uses 120 Hz, i.e. **2 per frame**, at **V = 127 and 255** on the
  same reasoning (128V). The driver's prose comment says one per frame at the
  start of VBLANK and is contradicted by its own `machine_config`; the config wins.

Each IRQ is a level held until the CPU writes its acknowledge register
(master **3c00**, slave **1000**).

---

## 3. Master 6502 memory map

```
0000-03ff  R/W  work RAM (1 KB)
0400-07ff  R/W  playfield RAM (1 KB) -- 32x32 tile codes
0800-0fff  R/W  communication RAM, shared with the slave (2 KB)
1000-100f  R/W  POKEY 1.  1008 reads ALLPOT = the START port
1800-180f  R/W  POKEY 2.  1808 reads ALLPOT = the DIP switches
2000       R    P1: both joysticks (active low, see section 6)
2200       R    P2: second player's joysticks, not fitted -- reads ff
2400       R    SYSTEM (active low except where noted, section 6)
2600       W    "custom write" -- display positioning; MAME ignores it, so do we
2800-29ff  R/W  NVRAM (512 bytes)
2f00-2fff       unmapped (explicitly)
3000-30ff  R/W  motion object (sprite) RAM, 256 bytes = 64 sprites x 4 fields
3200-327f  W    palette RAM window (64 entries; A6 is the 9th colour bit)
3800-3807  W    74LS259 output latch, addressed by A2:0, data is **D7**
3a00       W    watchdog kick
3c00       W    IRQ acknowledge
3e00       W    D0 = NVRAM write enable
4000-ffff  R    program ROM (48 KB)
```

ROM placement: `136023-501` at 4000, `-502` at 6000, `-503` at 8000 (16 KB),
`-504` at c000 (16 KB).

### 3.1 The 74LS259 at 3800

Written with `write_d7`: the latched bit is **D7** of the written byte, the
latch address is A2:0.

| Q | function |
|---|---|
| 0 | right coin counter |
| 1 | left coin counter |
| 2 | (unused) |
| 3 | **flip screen** |
| 4 | (unused) |
| 5 | set_nop in MAME -- unknown |
| 6 | start 2 LED (inverted) |
| 7 | start 1 LED (inverted) |

---

## 4. Slave 6502 memory map

```
0000-0007  R/W  work RAM (8 bytes)
0008-000f  R/W  the graphics processor window (section 5.2)
0010-07ff  R/W  work RAM
0800-0fff  R/W  communication RAM, shared with the master (2 KB)
1000       W    IRQ acknowledge
1200       W    D0 = displayed/drawn bitmap select, D1 = clear the drawn bitmap
1400       W    "custom write" -- ignored
2000-ffff  R    program ROM (56 KB)
```

ROM placement: `136023-509` at 2000 through `-515` at e000, 8 KB each.

---

## 5. Video

Three layers, composited in this order (MAME's `screen_update`):

1. **playfield** (tilemap) -- opaque, fills the frame
2. **bitmap** -- pen 0 transparent
3. **motion objects** (sprites) -- pen 0 transparent

### 5.1 Playfield

32 x 32 tiles of 8 x 8 pixels, 4 bits per pixel, no per-tile colour or flip:
the tile code is the whole byte of playfield RAM, and the palette base is 0.
Tile row/column is the usual `TILEMAP_SCAN_ROWS`, so playfield RAM offset
`(row * 32) + col`. There is no scrolling.

Character ROM (`chars`, 8 KB = `136023-105` at 0, `136023-106` at 1000) holds
256 tiles. MAME's `charlayout` places one pixel per nibble; with
`A = code*16 + row*2`, the eight pixels of a row are, left to right:

```
ROM106[A]>>4  ROM106[A]&f  ROM105[A]>>4  ROM105[A]&f
ROM106[A+1]>>4 ROM106[A+1]&f ROM105[A+1]>>4 ROM105[A+1]&f
```

(that is, `chars[0x1000+A]` supplies pixels 0,1,4,5 and `chars[A]` pixels 2,3,6,7).
**To be confirmed against MAME's decoded tiles before any RTL is written.**

Pen n maps to palette entry n (colours 0-15).

### 5.2 The bitmap and its graphics processor

Two 256 x 256 buffers of 4-bit pixels, one displayed and one drawn into. The
slave CPU reaches them only through the eight-byte window at 0008-000f, which is
an auto-incrementing address generator, not a RAM:

| offset | write | read |
|---|---|---|
| 0008 | store pixel, then X--, Y++ | read pixel, then X--, Y++ |
| 0009 | store pixel, then Y-- | read pixel, then Y-- |
| 000a | store pixel, then X-- | read pixel, then X-- |
| 000b | **set X** to the written byte | read pixel, no move |
| 000c | store pixel, then X++, Y++ | read pixel, then X++, Y++ |
| 000d | store pixel, then Y++ | read pixel, then Y++ |
| 000e | store pixel, then X++ | read pixel, then X++ |
| 000f | **set Y** to the written byte | read pixel, no move |

X and Y are 8-bit and wrap. The stored pixel is `data & 0x0f`. The buffer
address is `(Y << 8) | X`.

Writes go to the **drawn** buffer (the one `1200` bit 0 selects); reads come from
the **displayed** buffer (the other one). Reads at 000b and 000f return a pixel
but do not move the pointer -- the read handler adjusts only for offsets 0,1,2,4,5,6.

A write to **1200** sets bit 0 as the drawn-buffer select and, if bit 1 is set,
clears that buffer to zero. MAME renders the screen up to the current scanline
before acting on it, so a mid-frame swap tears exactly where the beam is.

**Display**: for each source pixel `(x, y)` of the displayed buffer, with
`pen = value & 0x07`, a non-zero pen is drawn at screen column `(x - 6) & 0xff`,
row `y`, in palette entry:

```
0x10 | ((x & 0x80) >> 4) | pen
```

so colours 16-23 for source x < 128 and 24-31 for x >= 128 -- the driver's "2
palettes selected by 128H". Note the palette bit comes from the **source** x, and
only the screen position is shifted by six.

### 5.3 Motion objects

64 sprites, 8 x 16 pixels, 4 bits per pixel, from the 8 KB `sprites` region
(128 sprites' worth) in the same nibble layout as the characters. Sprite RAM is
four 64-byte fields at 3000:

| offset | field |
|---|---|
| `3000 + n` | Y: screen y = `240 - value` |
| `3040 + n` | D6:0 = tile code, D7 = flip X |
| `3080 + n` | unused |
| `30c0 + n` | X: screen x |

There is no flip Y and no per-sprite colour; the palette base is 32, so pen p
is palette entry `32 + p`. Pen 0 is transparent.

Sprites are drawn from n = 63 down to n = 0, each overwriting the last, so
**sprite 0 is on top**.

Flip screen (LS259 Q3) subtracts 9 from x, mirrors y about 240, and flips x.

### 5.4 Palette

64 entries of 9 bits, written through the 128-byte window at 3200:

```
palette_ram[offset & 0x3f] = ((offset & 0x40) << 2) | data
```

so the low 8 bits come from the data and **bit 8 from address bit 6**.

The nine bits are three per gun, and they are **active low**. Bit assignment,
from `set_pen`:

```
bit 8..6 = red   (bit 8 = most significant)
bit 5..3 = green
bit 2..0 = blue
```

Each gun is a 3-bit R-2R-ish ladder of 2.2k / 4.7k / 10k pulled up through 1k,
which is not linear. MAME computes the weights with `compute_resistor_weights`;
the reference renderer must reproduce the same eight levels rather than scale
linearly. Allocation: 0-15 playfield, 16-31 bitmap, 32-47 sprites, 48-63 unused.

---

## 6. Inputs

**P1 (2000)**, active low -- a *dual* 8-way joystick game (left hand moves, right
hand fires directionally):

| bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
|---|---|---|---|---|---|---|---|---|
| | LEFT stick L | LEFT stick R | LEFT stick U | LEFT stick D | RIGHT stick L | RIGHT stick R | RIGHT stick U | RIGHT stick D |

**P2 (2200)**: not fitted, reads ff.

**SYSTEM (2400)**, active low except bit 0:

| bit | function |
|---|---|
| 0 | VBLANK (1 = in blanking, read straight off the video counter) |
| 1 | self-test switch |
| 2 | coin 2 (right) |
| 3 | coin 1 (left) |
| 4 | cocktail switch (not fitted) |
| 5 | service / aux coin |
| 6 | player 2 button 1 (not fitted) |
| 7 | player 1 button ("igniter") |

**START (POKEY 1 ALLPOT, read at 1008)**, active **high**:

| bit | function |
|---|---|
| 7 | start 1 |
| 6 | start 2 |
| 5:4 | pulled high |
| 3:0 | not connected |

**DSW (POKEY 2 ALLPOT, read at 1808)** -- switch 5A, and MAME's `diplocation`
entries are all `inverted`, so a switch pushed ON reads 0:

| bits | switch | function |
|---|---|---|
| 1:0 | 5A:8,7 | credits: 2 = 1C/1G (default), 1 = 1C/2G, 3 = 2C/1G, 0 = free play |
| 3:2 | 5A:6,5 | coin B: 0 = 1C/1C (default), 4 = 1C/4C, 8 = 1C/5C, c = 1C/6C |
| 4 | 5A:4 | coin A: 0 = 1C/1C (default), 1 = 1C/2C |
| 5 | 5A:3 | must be off |
| 6 | 5A:2 | demo freeze mode (hold button 1 to freeze) |
| 7 | 5A:1 | not used |

A POKEY only presents ALLPOT when `SKCTL & 3 != 0`; `rtl/pokey.sv` already
models that.

---

## 7. Memory budget

Everything fits in block RAM; there is no SDRAM in this core.

| block | bits |
|---|---|
| master ROM 48 KB | 393,216 |
| slave ROM 56 KB | 458,752 |
| char ROM 8 KB | 65,536 |
| sprite ROM 8 KB | 65,536 |
| bitmap 2 x 64 K x 4 bits | 524,288 |
| master work RAM 1 KB + playfield 1 KB + shared 2 KB | 32,768 |
| slave work RAM 2 KB | 16,384 |
| sprite RAM 256 B + NVRAM 512 B | 6,144 |
| palette 64 x 9 | 576 |
| **total** | **~1.56 Mbit** |

The 5CEBA4 has 3,080 Kbit of M10K, so this is about half the device before the
APF framework's own usage. METHODOLOGY section 6 applies: single-cycle,
deterministic access everywhere, no arbiter, no bandwidth budget.
