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

## 5. Open questions

### 5.1 Frame rate: 61.04 Hz, not MAME's 60

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

### 5.2 The master CPU clock

MAME runs the master at 1.000 MHz and the slave at 1.250 MHz and flags both
`????`. Both POKEYs sit on the **master's** bus, and a POKEY's single clock pin
is both its bus clock and its audio clock, so on the real board the master's phi2
and the 1.25 MHz POKEY clock are very likely the same signal -- which would make
the master 1.25 MHz too.

The core follows MAME until this is settled, because MAME is what every gate
diffs against. Changing it is one constant in `rtl/cloak_core.sv`.

### 5.3 Things MAME does not model, and neither does this

* **3e00 bit 0**, the NVRAM write enable. MAME latches it and never uses it.
  Gating writes on it is not something the oracle can confirm, so it is left
  alone and noted.
* **2600 and slave 1400**, the "custom write" the driver comment says has
  something to do with positioning the display. Ignored in both.
* **The watchdog.** The kick at 3a00 is decoded and discarded. A watchdog can
  only ever mask a fault in a core this size, never fix one.

### 5.4 The bitmap clear

A 65536-pixel clear cannot be instantaneous on hardware, and MAME's is a
`memset`. Measured in MAME: clears are rare (0.12 per frame) but **35 of 36 are
followed by the slave drawing into that buffer in the same frame**, so the clear
has to finish before the slave gets going. The core therefore sweeps the buffer
at the system clock and holds the slave's clock enable while it does -- 1.6 ms,
atomic, and about 1% of the slave's time averaged over a session.

### 5.5 Audio has not been checked against a recording yet

The output stage is derived exactly (see `rtl/cloak_audio.sv`: the op-amp path
collapses to a sum of four per-volume conductances, checked identical to MAME's
expression on 2,000 random values) but no A/B against MAME's `-wavwrite` has
been run. METHODOLOGY section 5.1 applies: until that measurement exists, the
audio is *derived*, not *verified*.
