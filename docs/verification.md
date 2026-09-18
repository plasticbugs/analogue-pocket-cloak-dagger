# Verification

What is checked, how, and what each check has actually caught. Per METHODOLOGY
section 1: make the correct answer cheap to compute, then check against it
constantly.

---

## The gates

| gate | what it proves | cost |
|---|---|---|
| `tools/regress_render.sh` | the reference renderer reproduces MAME's own snapshot, pixel for pixel, on every state in the corpus | ~20 s |
| `sim/run_video.sh` | `cloak_video` reproduces the reference renderer, pixel for pixel, on every state | ~3 s |
| `sim/run_selftest.sh` | the whole machine -- both 6502s, the memory map, the communication RAM, the video -- reproduces MAME frame for frame through the game's own power-on self-test | ~60 s |
| `sim/run_audio_unit.sh` | `cloak_audio`'s output level against MAME's own op-amp expression, plus the decimator and the DC blocker | ~4 s |
| `sim/run_audio.sh` | the whole machine's sound against a MAME recording of the same sequence | ~3 min |
| `sim/run_gameplay.sh` | both machines through the same coin and start, diffed frame by frame | ~3 min |
| `sim/lint.sh` | Verilator over the whole core | ~1 s |

All four are green. The video gates are at **zero differing pixels**, not "close".

---

## 1. The reference renderer (`tools/render_model.py`)

Renders one frame from a `tools/dump_state.lua` capture the way
`cloak_state::screen_update` does. Twenty states -- attract and gameplay, from
the boot screen to heavy sprite loads -- all match MAME's snapshot exactly.

It was pixel-identical on the first run, which is worth saying plainly: the
places it could have gone wrong were all resolved by reading MAME rather than
guessing.

* **The colour ladder is not linear.** Each gun is three bits through
  10k/4.7k/2.2k resistors pulled up by 1k, and MAME's
  `compute_resistor_weights` makes the eight levels
  `0, 74, 82, 157, 98, 173, 181, 255`. Note that level 3 (157) is *brighter*
  than level 4 (98) -- the weights are 74.5 / 82.1 / 98.5, nothing like 1:2:4,
  because the 1k pull-up dominates. Treating them as a linear ramp would have
  been wrong by up to 24%.
* **The bitmap's palette bank comes from the source column, not the screen
  column.** A pixel read at bitmap x is drawn at screen `(x - 6) & 0xff`, but
  its palette bank is `(x & 0x80) >> 4` -- computed before the shift. Six pixels
  either side of x=128 land in the other bank.
* **The character layout is one pixel per nibble across two ROM halves.** MAME's
  `gfx_layout` is decoded generically here from its own `xoffs`/`yoffs`/`planes`
  rather than by hand, so there was nothing to get wrong.

## 2. Frames MAME itself cannot reproduce

About one frame in ten cannot be rendered from an end-of-frame state at all, and
this cost real time before it was understood.

MAME draws this screen lazily and in bands: every slave write to 1200 calls
`screen->update_partial(vpos)`, so rows above that point are drawn with the
state as it was then and rows below with whatever it becomes. On a frame where
the master also changes the playfield, no single state reproduces the snapshot.

**Proved, not assumed**: attract frame 1800's snapshot differs from its own dump
by one line of text (392 pixels, all in tile row 7), and matches *exactly* --
zero pixels -- when the playfield is put back to frame 1799's contents.

Write taps cannot detect the condition. A tap installed over 0400-07ff counts
**zero** writes across 1,800 frames while the playfield RAM demonstrably changes
every other frame: the 6502's writes into that RAM bypass the tap entirely.
(METHODOLOGY section 4 warns about this; here it is total, not partial.) Two
other things also crash MAME 0.288 outright when called from inside a tap:
`screen:vpos()` -- which does not exist in its Lua binding at all -- and
`ioport:read()`.

So `tools/make_corpus.sh` captures each target frame together with its next few
neighbours and keeps the first one the renderer reproduces exactly. The corpus
is therefore exactly the set of frames for which "load this state, draw one
frame" is a well-posed question, which is the question the RTL bench asks.

## 3. The video RTL (`sim/run_video.sh`)

Loads a state into `cloak_video`'s memories through the ports the CPUs use,
renders a frame, and diffs it. Twenty states, zero differing pixels, three
seconds.

The RTL is deliberately *not* a model of MAME here. It scans out live, a line at
a time, as the board does, so a playfield write lands on the rows the beam has
not reached and no others. That is why section 2's problem exists for MAME and
not for this core.

## 4. The whole machine (`sim/run_selftest.sh`)

The strongest single check available, and it is the game's own: hold the
self-test switch at power-on and Cloak & Dagger checks its master RAM, its
master ROM checksums, the motion object RAM, the EAROM, the slave RAM, the
slave ROM, and the communication path between the two CPUs, printing a line for
each. Eight frames of that sequence match MAME's snapshots at **zero differing
pixels**.

`EAROM PARITY ?? LOC 21-K` appears in both: the NVRAM starts all zero, which has
bad parity, exactly as MAME's `NVRAM(..., DEFAULT_ALL_0)` gives it.

The switch has to be on *before* the game boots -- it is read during power-on and
never polled again. MAME's Lua cannot set a DIPSWITCH field that early
(`field:set_value()` does nothing for one, and `field.user_value = 0` takes
effect only from the next frame), so `tools/capture_selftest.sh` writes the cfg
file a player's F2 would have produced.

---

## 5. Free-running gameplay, and the limit of comparing against MAME

`tools/capture_gameplay.sh` and `sim/run_gameplay.sh` put both machines through
the same coin and start from power-on and diff every captured frame. Through
the first 21 seconds -- the attract tail, the difficulty select, the mission
briefing and the level-entry screen -- **34 of 43 frames are identical**. The
nine that are not differ by 0.16% to 2.06% of the picture, and every one of them
is animation phase: a blinking selection box, or the briefing's typewriter text
caught mid-character with its two figures a frame out.

Past that, the two stop being the same game, and no amount of work on the core
will bring them back together. **The master reads POKEY's RANDOM register in 36
places** -- 25 reads of `$100A` and 11 of `$180A`, found by searching the
program ROM -- and RANDOM is a free-running 17-bit LFSR clocked at 1.25 MHz.
The two machines do not give it the same number of clocks per frame:

| | POKEY clocks per frame |
|---|---|
| MAME, at a round 60.000 Hz | 20,833 |
| this core, at the board's 61.035 Hz | 20,480 |

So every read returns a different number and the playthroughs diverge: different
enemy placement, and the level-entry screen showing the exit on the other side
of the room. Deep in a game the frame-by-frame difference runs 14-16%, but it is
two correct machines playing two different games, not one of them drawing
wrongly. Confirmed independently by the person this core was built for, who
recognised the level-entry variation as the game's own behaviour -- the villain
leaves by the side the player enters from on the next screen, and it reads
correctly either way.

That is the ceiling on this gate, and it is a consequence of choosing the
board's frame rate over the oracle's (section 7.1). The obvious way through it,
if a deeper comparison is ever wanted, is a bench-only mode that runs the CPU
and POKEY enables off fractional accumulators delivering MAME's counts instead
of the board's; the arithmetic is 50,000 and 62,500 pulses per three frames of
655,360 clocks.

---

## 6. The build

Quartus 18.1.1 in Docker (`raetro/quartus:pocket`), the 5CEBA4F23C8 on the
Pocket. Full compilation: **0 errors**, and the Timing Analyzer reports the
design **fully constrained for both setup and hold** with **no negative slack in
any of its 104 checks**.

| resource | used | of | |
|---|---|---|---|
| ALMs | 3,753 | 18,480 | 20% |
| block memory bits | 1,576,993 | 3,153,920 | **50%** |
| M10K blocks | 201 | 308 | 65% |
| DSP blocks | 12 | 66 | 18% |
| PLLs | 2 | 4 | 50% |
| registers | 5,100 | | |

The memory figure is the one to watch, and it lands where section 7 of
`docs/hardware.md` said it would: 1,576,993 bits against a prediction of
~1,565,760. Half of that is the two 64 KB bitmap buffers.

Worst slack on the 40 MHz system clock is **+7.88 ns** of a 25 ns period at the
slow 85C corner, and +0.345 ns on hold. The T65 and POKEY multicycle exceptions
in `projects/cloak_pocket.sdc` are what buy the setup margin; both CPUs advance
on an enable every 32 or 40 cycles, so the constraint claims a quarter of the
margin that is actually there.

`./build-local.sh map` runs analysis and synthesis alone in under a minute and
catches syntax and inference errors without paying for a fit; the full compile
takes four.

---

## 7. Open questions

### 7.1 Frame rate: 61.04 Hz, not MAME's 60

The vertical timing PROM settles the vertical half absolutely: 256 lines, 232 of
them active. The horizontal half is not in the romset and MAME does not model it
(`set_refresh_hz(60)` and nothing else).

The working model is a 5 MHz dot clock (the board's single 10 MHz crystal / 2)
and 320 dots per line, giving a 15.625 kHz line rate and **61.035 Hz**. The
reasons to believe it:

* 60.000 Hz is arithmetically impossible with a 5 MHz dot clock and 256 lines --
  it needs 325.5 dots per line.
* 320 dots leaves 64 of horizontal blanking, the usual Atari layout.
* It divides cleanly by both CPU dividers: **64 master cycles and 80 slave
  cycles per scanline**, which is what a designer taking both clocks off one
  counter chain would get.

The measurable consequence: this core gives the master **16,384** cycles per
frame where MAME gives **16,666**, 1.7% fewer. Nothing in the self-test's
content depends on it, but the *rate* at which the test prints its lines and
turns its pages does, which is why the gate uses the settled pages. In attract
mode it shows as the demo's animation running a hair ahead of MAME's.

If a horizontal timing PROM or a schematic ever settles this, the only thing to
change is `HTOTAL` in `rtl/cloak_pkg.sv`.

### 7.2 The master CPU clock

MAME runs the master at 1.000 MHz and the slave at 1.250 MHz and flags both
`????`. Both POKEYs sit on the **master's** bus, and a POKEY's single clock pin
is both its bus clock and its audio clock, so on the real board the master's phi2
and the 1.25 MHz POKEY clock are very likely the same signal -- which would make
the master 1.25 MHz too.

The core follows MAME until this is settled, because MAME is what every gate
diffs against. Changing it is one constant in `rtl/cloak_core.sv`.

### 7.3 Things MAME does not model, and neither does this

* **3e00 bit 0**, the NVRAM write enable. MAME latches it and never uses it.
  Gating writes on it is not something the oracle can confirm, so it is left
  alone and noted.
* **2600 and slave 1400**, the "custom write" the driver comment says has
  something to do with positioning the display. Ignored in both.
* **The watchdog.** The kick at 3a00 is decoded and discarded. A watchdog can
  only ever mask a fault in a core this size, never fix one.

### 7.4 The bitmap clear

A 65536-pixel clear cannot be instantaneous on hardware, and MAME's is a
`memset`. Measured in MAME: clears are rare (0.12 per frame) but **35 of 36 are
followed by the slave drawing into that buffer in the same frame**, so the clear
has to finish before the slave gets going. The core therefore sweeps the buffer
at the system clock and holds the slave's clock enable while it does -- 1.6 ms,
atomic, and about 1% of the slave's time averaged over a session.

---

## 8. Audio

### 8.1 The level is right

`sim/run_audio_unit.sh` recomputes MAME's `vol_init` ladder in the bench itself
and checks the core's settled output against
`32767 * (V0(raw1) + V0(raw2)) / 2` -- MAME's own expression, including its
0.50-per-POKEY routing. Four cases:

| input | expected | core | error |
|---|---|---|---|
| all channels off (the idle offset) | 65.5 | 64 | 1.5 |
| two channels at 15 on each chip | 30,649.5 | 30,652 | 2.5 |
| one channel at 8 on each chip | 9,698.8 | 9,700 | 1.2 |
| a mixed set of volumes | 16,199.6 | 16,201 | 1.4 |

Under three LSBs of 32,767 -- 0.008% -- through the 16-entry conductance table,
the one-pole filters, the boxcar decimator and the output scale.

**The board can clip, and MAME clips with it.** Every channel of both POKEYs at
volume 15 is 1.87 of full scale through MAME's routing, so the 16-bit
conversion saturates. The core saturates at the same point; matching the oracle
here means matching its clipping, and the bench asserts that rather than
quietly scaling the output down.

### 8.2 The bug the end-to-end bench could not have caught

The first audio comparison ran fifteen seconds of attract against MAME and
reported the two identical to within 0.1 dB in every band. It was comparing one
constant with another: **Cloak & Dagger is silent for the first fifteen seconds
of attract**, and both sides were sitting at the POKEY's idle offset of 0.002.

Underneath that, the DC blocker was broken. Its leak term is `y >>> 13`, which
is **zero for any `|y|` below 8192** -- and the machine idles at about 4,000. The
pole never moved and the offset would have sat there for ever. The fix keeps the
filter state twelve bits below the sample's own scale; `sim/run_audio_unit.sh`
now asserts that a constant decays to under a twentieth of itself in four time
constants, and that a 6 kHz square still straddles zero afterwards.

The lesson is METHODOLOGY section 5.1's, sharpened: an end-to-end test that
passes on silence is not evidence. `tools/capture_audio.sh` therefore drives a
coin and a start and records the game's opening, where there is actually
something to measure.

### 8.3 The whole machine against a MAME recording

`tools/capture_audio.sh` drives MAME through a coin at frame 120 and a start at
frame 200 and records the game's opening; `sim/run_audio.sh` drives the core
through the same schedule and compares. One second from the first sound:

```
onset: MAME 12.56 s, core 12.35 s
mean (the standing offset): MAME +0.01719, core -0.00261 -- removed from both
  peak   MAME 0.1410   core 0.1512   ratio 1.072 (+0.61 dB)
  RMS    MAME 0.0450   core 0.0430   ratio 0.955 (-0.40 dB)
  worst of peak/RMS: 0.61 dB (tolerance 1.5)
```

Two things had to be got right for that number to mean anything.

**The offset has to come out of both.** MAME's stream is unipolar -- its POKEY
model leaves the summing node's standing offset in -- and the core's is not,
because the DC blocker is the whole point. Compared with the offset in place the
core measured 0.55 dB down on peak and 1.1 dB down on RMS, all of it that one
difference.

**Per-band energy is reported but not gated, and that is a measured decision.**
This material is a sequence of effects, not a steady tone. Sliding the window
0.2 s along **MAME's own recording** moves its 500 Hz band by **14 dB** and its
707 Hz band by **6 dB**:

```
  start(s)   500 Hz   707 Hz  1000 Hz
    0.05     -56.5    -73.9    -88.8
    0.25     -45.6    -77.1    -94.9
    0.65     -54.0    -70.7    -90.1
    0.85     -59.9    -76.5    -86.6
```

The core and MAME are ~17 ms apart by the end of a one-second window, so any
per-band difference under about 6 dB says nothing. Peak and RMS are stable
against that shift, so they are what the gate uses; the exact level check is
section 8.1's, against MAME's own expression rather than against a recording.

### 8.4 Two menu entries that are new to this series

`interact.json` uses two framework addresses that none of the sibling cores
expose, so they are the likeliest things to be wrong the first time this runs on
a Pocket:

* **0xF0000010, "Self-Test Switch".** `interact.sv` latches bit 0 into `svc_mode`
  *and* starts a reset, which is exactly what this game needs: the self-test
  switch is read once during power-on and never polled again, so it has to be on
  before the machine boots. The entry is `persist: false`, so it is Off at the
  start of every session rather than trapping someone in the test.
* **0xF0000020, "Clear Settings & Scores".** Raises `nvclear_sw` for a reset
  window; `cloak_main` sweeps the 512-byte NVRAM to zero on the CPU port while
  that is high (512 writes, 13 us) and toggles `nv_dirty` at the end so the wipe
  is written back to the .sav rather than coming straight back on the next load.

### 8.5 What is still open

Nothing has been listened to on hardware, and the output has not been checked
against a recording of a real board -- only against MAME, which is a model of
one. The RC network after the POKEYs is modelled as MAME models it, and MAME's
own comment says it is an approximation of what the board does next.
