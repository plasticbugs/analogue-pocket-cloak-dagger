# The Analogizer

[Analogizer](https://github.com/RndMnkIII/Analogizer) is RndMnkIII's adapter
for the Pocket's cartridge slot. It gives analog video out of a VGA connector
(RGBS, RGsB, YPbPr, Y/C, and a scandoubled RGBHV) and takes native controllers
through SNAC adapters. Its wiki is the authority on the adapter itself:
[specifications](https://github.com/RndMnkIII/Analogizer/wiki/Analogizer-Specifications),
[how to configure it](https://github.com/RndMnkIII/Analogizer/wiki/Supported-Cores-and-How-to-Configure-Them).

This core supports it (`USE_ANALOGIZER = 1` in `core_top.sv`), added after
release from the pocket-core-template (`docs/analogizer-retrofit.md` there is
the order of work it followed). This page is what the player needs to know,
what the core does with the adapter, and what has been proven.

## For the player

**Settings are in the core's own menu**, under the game's other options,
like RndMnkIII's own "Pocket Menu" Analogizer cores (the wiki's list calls the
other kind, which reads a shared `analogizer.bin`, "Analogizer File"; this
core does not read that file). The Pocket remembers them per
core.

| entry | options |
|---|---|
| Analogizer | Off (the default), On, On, Pocket off (the picture goes to the CRT only) |
| Analogizer Video | RGBS, RGsB, YPbPr, Y/C NTSC, Y/C PAL, Scandoubler, Scandoubler 25% / 50% / 75%, Scandoubler HQ2x |
| SNAC Adapter | None, DB15, NES, SNES, PCE 2-button, PCE 6-button, PCE Multitap, DB15 Fast, SNES A,B<->X,Y, PSX Digital, PSX Digital Fast, PSX Analog, PSX Analog Fast |
| SNAC Assignment | the six below |
| Analogizer H Position | -8 to +15 dots; + moves the picture right |
| Analogizer V Position | -16 to +3 lines; + moves the picture down |
| Analogizer H Size | -20% to +4%; + wider (15 kHz modes) |

With **Analogizer** off the core behaves exactly as it did without Analogizer
support. The adapter itself is set up as its wiki's
[How to use it](https://github.com/RndMnkIII/Analogizer/wiki/How-to-use-it%3F)
says: SNAC switch in position A, 5 V into its USB-C port, the SCART cable's
audio jack in the Pocket's headphone socket.

**Width.** "Analogizer H Size" makes the picture narrower or wider about
its centre, in percent, in the 15 kHz modes, for a set with no width
control of its own: the core plays each line back a little faster or
slower. The board leaves little room: 16 dots either side of hsync, and
its own timing already lets the Y/C colour burst reach the picture's first
two dots. So it widens by only 4%, after centring with H Position (about
+9), and narrows by up to 20%. Where H Position and H Size together would
put picture on the sync or the burst, the core crops the picture's edge
instead, so the set never loses sync. How it works is in the template's
docs/analogizer.md, "Picture width". Demo Freeze Mode left the menu to
make room (it stays Off). Bench: centred by H Position 9, +4% and -20%
give 232 lines of 2,130 and 1,639 clocks (asked 2,130 and 1,638), centred
to the clock, every dot in order, lines as far from vsync as at 0; +5% is
cropped by a clock and fails; at +4% with H Position at either end, csync
is never low while a dot is drawn.

**Position.** The two sliders move the picture on the CRT, in the core's
own dots and lines, for a set whose picture sits off centre (the first one
tried with Moo Mesa showed it about 10 lines high). They move the syncs,
not the picture, so nothing is cropped and every mode follows; the size is
still the set's to adjust. 0 is the board's own timing.

**Video.** The core sends the board's own signal: 256 × 232 visible, 320 ×
256 dots at 5 MHz, 15.625 kHz lines, 61.04 Hz. The cabinet is horizontal
(ROT0), so a CRT stands the usual way up. The vertical timing is the board's
own, off its timing PROM; the horizontal (front porch 16 dots, hsync 32, back
porch 16) is this core's working model, since MAME does not describe it
(`docs/hardware.md` section 2).

| mode | SOG switch | notes |
|---|---|---|
| RGBS | off | VGA-to-SCART or VGA-to-BNC |
| RGsB | on | R2/R3 adapters only |
| YPbPr | on | R2/R3 adapters only |
| Y/C NTSC, Y/C PAL | off | needs an active Y/C adapter on the VGA port |
| SC 0% / 25% / 50% / 75% / HQ2x | off | scandoubled for a VGA monitor: twice the line rate |

"On, Pocket off" turns the Pocket's own picture black while the CRT keeps
it.

**Controllers.** SNAC pads (DB15, NES, SNES, PC Engine 2/6-button and
multitap, PlayStation) replace the Pocket's controls according to the
**SNAC Assignment** chosen in the menu:

| assignment | player 1 | player 2 | player 3 | player 4 |
|---|---|---|---|---|
| SNAC P1 → Pocket P1 | SNAC 1 | the Pocket's own controls | dock 3 | dock 4 |
| SNAC P1 → Pocket P2 | Pocket | SNAC 1 | dock 3 | dock 4 |
| SNAC P1,P2 → P1,P2 | SNAC 1 | SNAC 2 | dock 3 | dock 4 |
| SNAC P1,P2 → P2,P1 | SNAC 2 | SNAC 1 | dock 3 | dock 4 |
| SNAC P1,P2 → P3,P4 | Pocket | dock 2 | SNAC 1 | SNAC 2 |
| SNAC P1-P4 → P1-P4 | SNAC 1 | SNAC 2 | SNAC 3 | SNAC 4 |

Cloak & Dagger is one player at a time (two alternate), so "SNAC P1 →
Pocket P1" is the one to use; the others are offered as in every Analogizer
core. A pad's buttons arrive as the Pocket's own (SNAC's A is the Pocket's A,
and so on), so a SNAC pad plays the twin-stick cabinet the way the Pocket
does:

| pad | game |
|---|---|
| d-pad (or a PlayStation pad's left stick, in analog mode) | walk |
| X / A / B / Y | fire up / right / down / left; two at once for a diagonal |
| L or R | igniter |
| Select / Start | coin / start |

A PlayStation pad's right stick does not fire: the adapter's module hands the
wrapper only the left stick. A docked controller's right stick still fires,
but with an adapter in the slot the Pocket is handheld.

**Picture position.** Front porch, sync and back porch are 16, 32 and 16
dots, so the horizontal range is small: +15 leaves one dot of front porch,
and moving left shortens the back porch the Y/C colour burst sits in. The
burst (about 3.5 µs after hsync ends, 17.6 dots at 5 MHz) already reaches
1.6 dots into the picture at 0; at -8 it reaches about 10 dots in, which may
tint the left edge in Y/C modes only. Vertically, vsync has 4 blank lines
before it and 17 after, so +3 and -16 each leave a line.

**Cart power is on for everyone.** `core.json` declares the cartridge adapter,
so the Pocket powers the slot whether or not an Analogizer is in it. Do not
leave a game cartridge in the slot while this core runs.

Confirmed on a Pocket with an Analogizer and a CRT (0.2.0). What the bench proves is
listed under *What was measured* below. Send problems with
the adapter itself to the Analogizer project.

## For the developer

### The pieces

| file | what |
|---|---|
| `target/pocket/analogizer/` | RndMnkIII's `openFPGA_Pocket_Analogizer` and what it instantiates, **verbatim** (modules/VENDOR.md has the commit). Its `analogizer.qip` is ours: only what is used. |
| `target/pocket/pocket_analogizer.sv` | the wrapper: clock hand-over, Y/C constants, SNAC → controller words. Core-agnostic; the same file in the template. |
| `target/pocket/core_top.sv` | `USE_ANALOGIZER`, the instance (`LINE_LEN` 320, `CLK_HZ` 40 MHz, `clk_sys` as both clocks), `key1..key4` in place of `cont1..4_key` into the `gamepad` helper, the bridge read at `0xF7xxxxxx`, the Pocket-screen blank, cloak_video's hblank/vblank delayed two dots to line up with its colours and syncs, and the cart pins' idle levels when it is off. |
| `pkg/.../interact.json` | the entries above: ids 70–73, each a masked field of the word at `0xF7000000`, and 74–75, signed sliders at `0xF7000004` and `0xF7000008`. With the game's ten entries the menu is at Analogue's limit of 16 (18 with the two data slots, of 20), and 54 options, two more than any core seen loading; Analogue says list options do not count toward the limit (`tools/check_json.py` notes it rather than failing) |
| `pkg/.../core.json` | `"cartridge_adapter": 0` (powers the slot) |
| `sim/run_analogizer.sh` | the bench (below), at this core's raster (top of `sim/tb_analogizer.sv`) |
| `sim/lint.sh`, `sim/lint_platform.sh` | the wrapper on its own, and inside `core_top`; the vendored files' warnings dropped by path |
| `tools/check_json.py` | fails if an entry writes outside its mask, none sets the enable, a position slider is not signed within ±127, a data slot also writes `0xF7000000`, or the slot is not powered |

### The settings word

One 32-bit word at `0xF7000000`, the layout RndMnkIII's adapter module (1.4)
decodes. Each menu entry is a list with a mask that keeps every bit but its
own field (or fields), so the four entries share the word:

| bits | field | values |
|---|---|---|
| 4:0 | SNAC type | 0 none, 1 DB15, 2 NES, 3 SNES, 4 PCE 2-button, 5 PCE 6-button, 6 PCE multitap, 9 DB15 fast, 0xB SNES A/B↔X/Y, 0xC–0xF PS/2 keyboard (+ pad; not in the menu, the wrapper does not wire the keyboard out), 0x10/0x11 PSX digital (125/250 kHz), 0x12/0x13 PSX analog. 16 and up select the adapter's B wiring. |
| 5 | enable | 0: the port stays idle and nothing else applies |
| 9:6 | SNAC assignment | 0–5 as in the table above |
| 13:10 | video | 0 RGBS, 1 RGsB, 2 YPbPr, 3 Y/C NTSC, 4 Y/C PAL, 5–9 scandoubler 0/25/50/75%/HQ2x |
| 14 | blank the Pocket screen | |
| 15 | OSD on the Analogizer output | not used by this core; no menu entry |

**Read-back.** The word is written as a number (the adapter module is told
`bridge_endian_little = 1`, so it does not byte-swap it as it would a file),
and `pocket_analogizer` keeps its own copy to read back, combinationally.
The Pocket's bridge (`io_bridge_peripheral.sv`) samples read data four clocks
after it presents the address and pulses `bridge_rd` only afterwards; the
adapter module updates its read-back on that pulse, so it would hand back
the *previous* read's value. The firmware merges a masked entry by
reading the word back (Analogue's interact.json docs: every entry not
`writeonly` is read back every frame), so that stale value would wipe the
other fields: in the bench, choosing a video mode turned the Analogizer off. RndMnkIII's menu
cores (Gauntlet) read the word back the same way, from a register.

**Picture position.** Two more words, each a whole signed slider value
(no mask): `0xF7000004` horizontal in dots, + right, and `0xF7000008`
vertical in lines, + down. `pocket_analogizer` reads the low 8 bits and
reads both words back. The adapter module stores them in a table it never
reads (`config_mem`). They move the syncs, not the picture: hsync n dots
earlier puts the picture n dots right, vsync n lines earlier puts it n
lines down. Earlier is built as a line (or frame) less n later: each sync
is re-made from the source's own rising edge after a delay counted in
dots, as wide as the source's, with the line and frame measured from the
source's syncs; the vsync's delay is whole lines, so its edges keep their
place in the line. RGB and blanking go through one clock later with them,
and at 0 each sync passes straight through.

A re-made sync starts only once it has been off at least as long as it is
on. The adapter module's `sync_fix` decides each sync's polarity afresh
every period, by whether the signal was high longer than low. A jump
between settings in one write (one "large" slider step, or a value loaded
at start) can put the next pulse just after the last one ends, and that
period reads as active-low: csync turned inside out for a frame (a line,
for hsync). With the rule such a jump skips one pulse instead.

**The range is this core's blanking** (above, for the player). The bench
tries both ends of the range in `interact.json` and fails if csync is low
while a dot is drawn: it passes to +16 dots and -17 lines, where the porch is
used up, and fails at +17 and -18; the menu stops one short of each. Left is
held to -8 for the Y/C burst.

The wrapper passes the source's sync straight through at 0, and that path
has no off-time guard: a jump from +k lines to 0 with the vsync's width W <
k < 2W would put two pulses less than W apart. Here W is 3 lines, and the
largest slider step is 4, so a jump to 0 from +4 or +5 is the case; the
range stops at +3, so it cannot happen. (The other direction, and every jump
that does not land on 0, goes through the guard.)

**The file scheme, not used here.** The adapter module 1.4 was written for
`analogizer.bin`, a file Pupdate and AnalogizerConfigurator write to
`/Assets/analogizer/common/`, loaded through a data slot at the same address.
It needs a data slot naming the file, a second platform id `analogizer`
that the slot's parameters point at, and the file on the card before the
adapter does anything. A player who has never heard of the file has an
Analogizer that stays dark, so this core uses the menu. A data slot at
`0xF7000000` would load the file over the menu's word; `tools/check_json.py`
refuses one.

### Clocks

`openFPGA_Pocket_Analogizer` runs its logic on `i_clk`, puts `video_clk` on the
cartridge pin that clocks the ADV7123, and assumes that is `i_clk` too. The
scandoubler halves the pixel period, so the clock has to be at least four
times the dot rate. The shipped Analogizer cores use 42.95–48 MHz. This
core's `clk_sys` is 40 MHz, eight clocks to each 5 MHz dot, so it is the
Analogizer's clock as well as the picture's: no PLL output is added and the
SDC is unchanged. `pocket_analogizer` takes each pixel `PIX_LAG` (2) clocks
after the dot enable, when cloak_video's registered colours have settled, and
hands it over with a toggle, here between two flops on the same clock.

The Y/C encoder's subcarrier step and colour-burst window are computed in
integers from `CLK_HZ`. The reals used elsewhere lose the bits past 32 in some
tools, and MSX2's hand-typed NTSC step is a few counts off.

### Using SNAC in the game's inputs

`pocket_analogizer` outputs `key1..key4`, the Pocket's controller words with
SNAC pads put in place by the assignment. SNAC's bit order is the Pocket's
(0 up, 1 down, 2 left, 3 right, 4 A, 5 B, 6 X, 7 Y, 8 L1, 9 R1, … 14 select,
15 start). They feed the `gamepad` helper and the direct player-3/4 reads in
place of `cont1..4_key`. **Wherever a core reads `cont*_key` directly**
(players 3 and 4 often are), read `key*` instead, or SNAC will not reach it.

### What was measured

- `sim/run_analogizer.sh`: the wrapper and the vendored module at this
  core's raster and clock (320 × 256 dots, 8 clocks a dot, clk_sys for both),
  read at the cartridge pins as the DAC reads them.
  - With the menu at its defaults, every pin sits as on a core without the
    adapter, and the controller words pass through.
  - Every option of every Analogizer entry in the package's `interact.json`
    (32), set as the firmware sets a masked entry, read back the word as the
    bridge samples it, merged and written: the word, the adapter's copy and
    the enable each followed. With the adapter's own read-back in place of
    the wrapper's, the same run fails at the second entry.
  - RGBS: all 59,392 visible dots of a frame (256 × 232) reach the DAC pins,
    in raster order, as their top six bits per channel, with 0 differing.
    Csync is one 32-dot pulse a line (253 of them outside vsync).
  - Scandoubler: 512 lines per frame (twice 256) at 1280 clocks, half the
    core's 2560.
  - YPbPr and Y/C NTSC/PAL: no unknown on any pin for a frame.
  - All six SNAC assignments, the analog stick, and type "none" map as
    tabled.
  - Position, at both ends of the shipped sliders (+15,+3 and -8,-16):
    read back as written, the settings word untouched; at the pins csync
    moves by exactly 120 and 64 clocks (15 and 8 dots) and 3 and 16 lines,
    the picture is still every dot with 0 differing, csync is never low
    while a dot is drawn, and the scandoubler's lines and period are
    unchanged; back at 0, csync is where it started. Jumps written just
    after a pulse (V +3 to -1, H +15 to -8 at once) leave csync out of the
    picture for three frames. +17 dots and -18 lines fail it (a sync in
    the picture); +16 and -17 pass with no porch left.
  - The blank bit, and enable off again returning the port to idle.
- `sim/lint.sh`: the wrapper lints clean. The vendored files' warnings are
  dropped by path; their errors are not.
- Quartus 18.1: compiles with no negative slack at any corner: worst setup
  +2.167 ns (slow 85C, clk_74a; clk_sys +6.617), worst hold +0.081 ns (fast
  0C, clk_sys). The Analogizer costs 1,832 ALMs (4,031 → 5,863, 32%), 13 RAM
  blocks (211 → 224 of 308) and 2 DSP blocks (12 → 14). Before it: setup
  +2.867, hold +0.124. Cloak's own `set_clock_groups` (cloak_pocket.sdc line
  36) is ignored, as it was before this change: the qsf reads it before the
  platform's `sys_constr.sdc` has created the clocks, so the platform's
  groups are the ones in force. The Analogizer adds no clock.
- The core's video gate (`sim/run_video.sh`): 20 states, 0 failed; nothing
  in `rtl/` changed.

**Not proven:** anything on hardware with this core (the adapter module
itself ships in RndMnkIII's cores and in plasticbugs' MSX2); that the
firmware writes a signed slider as a two's-complement word; that it loads a
menu with 54 options (documented, not yet seen); a 61.04 Hz, 256-line raster
on any particular set; and the SNAC serial protocols, which are the adapter
module's and are forced at its outputs in the bench rather than driven over
the pins. The Y/C and YPbPr encodings have no reference to compare against,
only a run without unknowns, and the burst already touches the picture's
first dots at 0 (above).

### Turning it off

Set `USE_ANALOGIZER = 0` in `core_top.sv`, and take the six menu entries
out of `interact.json` and `cartridge_adapter` back to -1 in `core.json`
(the slot then stays unpowered, as before).
