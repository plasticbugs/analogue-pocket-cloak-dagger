// Unit bench for cloak_audio: the op-amp output stage, the decimator and the
// DC blocker, checked against the arithmetic they are supposed to implement
// rather than against a recording.
//
// It exists because the whole-machine audio bench could not have caught the bug
// it was written for: Cloak & Dagger is silent through the first fifteen
// seconds of attract, so comparing the core with MAME there compares one
// constant with another. The DC blocker's leak term was truncating to zero for
// any quiet signal and the offset never decayed -- visible here in a second.
//
//   Vcloak_audio            (no arguments; prints PASS or FAIL per check)
#include "Vcloak_audio.h"
#include "verilated.h"
#include <cstdio>
#include <cmath>
#include <vector>
#include <algorithm>

static Vcloak_audio *dut;
static vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

// MAME's vol_init, recomputed here so the RTL's table is checked against the
// source it came from rather than against a copy of itself.
static double r_chan[16];
static void vol_init() {
    const double R[4] = {90000.0, 26500.0, 8050.0, 3400.0}, r_off = 8e6;
    for (int j = 0; j < 16; j++) {
        double t = 1.0 / 1e12;
        for (int i = 0; i < 4; i++) t += (j & (1 << i)) ? 1.0 / R[i] : 1.0 / r_off;
        r_chan[j] = 1.0 / t;
    }
}
static double v0_of(unsigned raw) {
    double inv = 0;
    for (int i = 0; i < 4; i++) inv += 1.0 / r_chan[(raw >> (4 * i)) & 0xf];
    return 1000.0 * inv;                       // r_pullup / rTot, v_ref/5 == 1
}

static void tick() {
    dut->clk = 0; dut->eval(); main_time++;
    dut->clk = 1; dut->eval(); main_time++;
}

// one POKEY clock: cen high for a single system clock out of 32
static std::vector<short> run(unsigned raw1, unsigned raw2, int pokey_clocks, bool collect) {
    std::vector<short> out;
    dut->raw1 = raw1; dut->raw2 = raw2;
    for (int i = 0; i < pokey_clocks; i++) {
        dut->cen_pokey = 1; tick();
        dut->cen_pokey = 0;
        for (int k = 0; k < 31; k++) {
            tick();
            if (collect && dut->audio_valid) out.push_back((short)dut->audio);
        }
        if (collect && dut->audio_valid) out.push_back((short)dut->audio);
    }
    return out;
}

static int failures = 0;
static void check(const char *what, bool ok, const char *detail = "") {
    printf("%-52s %s %s\n", what, ok ? "PASS" : "FAIL", detail);
    if (!ok) failures++;
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    vol_init();
    dut = new Vcloak_audio;
    dut->clk = 0; dut->reset = 1; dut->cen_pokey = 0;
    dut->raw1 = 0; dut->raw2 = 0; dut->dcblock_en = 0;
    for (int i = 0; i < 8; i++) tick();
    dut->reset = 0;

    // ---- 1. the level, with the blocker off, against MAME's own expression
    // Both POKEYs at full volume on every channel is the loudest the board can
    // be; the low-pass settles in a few hundred chip clocks.
    struct { unsigned raw1, raw2; const char *name; } cases[] = {
        {0x0000, 0x0000, "all channels off (the idle offset)"},
        {0x0f0f, 0x0f0f, "two channels at 15 on each chip"},
        {0x8000, 0x0008, "one channel at 8 on each chip"},
        {0x1234, 0x5678, "a mixed set of volumes"},
    };
    for (auto &c : cases) {
        run(c.raw1, c.raw2, 4000, false);
        double want = 32767.0 * (v0_of(c.raw1) + v0_of(c.raw2)) / 2.0;
        double got = (double)(short)dut->audio;
        double err = fabs(got - want);
        char d[160];
        snprintf(d, sizeof d, "%-38s want %8.1f got %6d (err %.1f)", c.name, want, (short)dut->audio, err);
        // the one-pole filters settle to V0 exactly; allow a couple of LSBs of
        // fixed-point rounding through the ladder, the decimator and the scale
        check("level matches MAME's op-amp expression", err <= 3.0, d);
    }

    // ---- 2. the board's loudest possible output clips, and so does MAME's
    // Every channel on both chips at 15 is 1.87 of full scale through MAME's
    // own routing (0.50 each), so the 16-bit conversion clips -- in MAME too.
    // Matching the oracle here means matching its clipping.
    run(0xffff, 0xffff, 4000, false);
    char d[200];
    snprintf(d, sizeof d, "all 8 channels at 15 -> %d (MAME's float would be %.2f of full scale)",
             (short)dut->audio, (v0_of(0xffff) + v0_of(0xffff)) / 2.0);
    check("the loudest case clips exactly as MAME's does", (short)dut->audio == 32767, d);

    // ---- 3. the DC blocker actually blocks DC
    // A quiet offset, well clear of saturation: one channel at 8 on one chip.
    dut->dcblock_en = 1;
    run(0x0008, 0x0000, 2000, false);              // settle
    int before = (short)dut->audio;
    // the pole is 2^-13 per output sample at 48.08 kHz: a time constant of
    // 8,192 samples, or 170 ms. Four of those is 700 ms -- 850,000 chip clocks.
    run(0x0008, 0x0000, 850000, false);
    int after = (short)dut->audio;
    snprintf(d, sizeof d, "settled %d -> %d after 700 ms (four time constants) of constant input", before, after);
    check("DC blocker decays a constant to near zero", abs(after) <= before / 20 && abs(before) > 50, d);

    // ---- 4. with the blocker off the same constant stays put
    dut->dcblock_en = 0;
    run(0x0008, 0x0000, 4000, false);
    int held = (short)dut->audio;
    snprintf(d, sizeof d, "held at %d", held);
    check("blocker off leaves the offset alone", abs(held) > 50, d);

    // ---- 5. the decimator produces samples at 1.25 MHz / 26
    dut->dcblock_en = 1;
    auto s = run(0x0f00, 0x00f0, 2600, true);
    snprintf(d, sizeof d, "%zu samples from 2600 chip clocks (want 100)", s.size());
    check("one output sample per 26 chip clocks", s.size() >= 99 && s.size() <= 101, d);

    // ---- 6. a square wave survives the blocker with its amplitude intact
    // 100 chip clocks high, 100 low: 6.25 kHz, far above the 0.93 Hz pole, at a
    // level that does not saturate.
    // The blocker's own time constant is 8,192 output samples, so the mean only
    // reaches zero after a few of those -- about 4,300 cycles of this square.
    dut->dcblock_en = 1;
    int lo = 0, hi = 0;
    const int CYCLES = 5000;
    for (int cyc = 0; cyc < CYCLES; cyc++) {
        bool measure = cyc >= CYCLES - 50;
        auto a = run(0x0008, 0x0000, 100, measure);
        auto b = run(0x0000, 0x0000, 100, measure);
        if (measure) {
            for (short v : a) hi = std::max(hi, (int)v);
            for (short v : b) lo = std::min(lo, (int)v);
        }
    }
    // the op-amp poles roll 6.25 kHz off by a good deal, so this is a sanity
    // bound rather than a tight one: the swing must survive, and it must
    // straddle zero now that the offset is gone
    snprintf(d, sizeof d, "swing %d .. %d", lo, hi);
    check("a 6 kHz square survives and straddles zero", hi > 20 && lo < -20, d);

    printf("\n%s\n", failures ? "FAIL" : "PASS");
    delete dut;
    return failures ? 1 : 0;
}
