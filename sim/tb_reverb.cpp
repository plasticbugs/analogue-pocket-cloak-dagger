// Unit bench for cloak_reverb: the three comb delays, the decay, the wet level
// and the pass-through, checked against what the module claims to do.
//
// It exists for the same reason sim/tb_audio.cpp does. The DC blocker shipped
// broken once because the only test that covered it compared silence with
// silence; anything in the audio path gets its own arithmetic check now.
//
//   Vcloak_reverb            (no arguments; prints PASS or FAIL per check)
#include "Vcloak_reverb.h"
#include "verilated.h"
#include <cstdio>
#include <cmath>
#include <vector>
#include <algorithm>

static Vcloak_reverb *dut;
static vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

static void tick() {
    dut->clk = 0; dut->eval(); main_time++;
    dut->clk = 1; dut->eval(); main_time++;
}

// One 48 kHz sample period: ce for a single clock, then enough clocks for the
// nine-state sequence to settle, then read the output.
static short sample(short in) {
    dut->in = in;
    dut->ce = 1; tick();
    dut->ce = 0;
    for (int i = 0; i < 40; i++) tick();
    return (short)dut->out;
}

static int failures = 0;
static void check(const char *what, bool ok, const char *detail = "") {
    printf("%-54s %s %s\n", what, ok ? "PASS" : "FAIL", detail);
    if (!ok) failures++;
}

static void reset_dut(int mode) {
    dut->reset = 1; dut->ce = 0; dut->in = 0; dut->mode = mode;
    for (int i = 0; i < 8; i++) tick();
    dut->reset = 0;
    for (int i = 0; i < 4; i++) tick();
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    dut = new Vcloak_reverb;
    dut->clk = 0;
    char d[200];

    // ---- 1. mode 0 is a pass-through -------------------------------------
    reset_dut(0);
    bool ok = true;
    const short probe[] = {0, 1000, -1000, 32767, -32768, 12345, -4321, 0};
    for (short v : probe) {
        short got = sample(v);
        if (got != v) { ok = false; snprintf(d, sizeof d, "in %d -> out %d", v, got); break; }
    }
    check("mode 0 passes every sample through unchanged", ok, ok ? "including both rails" : d);

    // ---- 2. an impulse comes back at the three comb delays ---------------
    // The module names 1426, 1781 and 1973 samples; an impulse in should
    // produce the first echo at each of those, and nowhere before the first.
    reset_dut(2);
    std::vector<short> y;
    y.push_back(sample(16384));
    for (int i = 1; i < 4200; i++) y.push_back(sample(0));   // far enough for a second pass at 2852
    auto peak_near = [&](int n, int w) {
        int best = 0;
        for (int i = std::max(0, n - w); i <= std::min((int)y.size() - 1, n + w); i++)
            best = std::max(best, abs((int)y[i]));
        return best;
    };
    int quiet = 0;
    for (int i = 1; i < 1400; i++) quiet = std::max(quiet, abs((int)y[i]));
    int e0 = peak_near(1426, 3), e1 = peak_near(1781, 3), e2 = peak_near(1973, 3);
    snprintf(d, sizeof d, "silent to %d before, echoes %d / %d / %d at 1426 / 1781 / 1973",
             quiet, e0, e1, e2);
    check("an impulse returns at the three comb delays", quiet < 8 && e0 > 200 && e1 > 200 && e2 > 200, d);

    // ---- 3. the tail decays --------------------------------------------
    // Second pass of each comb is the feedback gain times the first, darkened.
    int e0b = peak_near(2 * 1426, 4);
    snprintf(d, sizeof d, "first pass %d, second %d", e0, e0b);
    check("the tail decays rather than ringing", e0b > 0 && e0b < e0, d);

    // ---- 4. heavy rings longer than medium ------------------------------
    // Not louder: heavy mixes the wet in at 3/16 where medium uses 1/4, and
    // buys its length from a higher feedback (13/16 against 5/8). So this has
    // to compare the LATE tail, not the total energy -- measuring the whole
    // decay makes heavy look weaker, which is what it should look like early on.
    auto late_tail = [&](int mode) {
        reset_dut(mode);
        double s = 0; int n = 0;
        sample(16384);
        for (int i = 1; i < 9000; i++) {
            double v = sample(0);
            if (i >= 6000) { s += v * v; n++; }
        }
        return sqrt(s / n);
    };
    double med = late_tail(2), hvy = late_tail(3);
    snprintf(d, sizeof d, "after 6000 samples (125 ms): medium %.2f, heavy %.2f", med, hvy);
    check("heavy's tail outlasts medium's", hvy > med * 1.5, d);

    // ---- 5. a loud sustained input does not rail -------------------------
    // The dry signal is at full scale and the wet is added on top, so the sum
    // saturates by design -- but it must not stick there once the input stops.
    reset_dut(3);
    for (int i = 0; i < 4000; i++) sample((i & 64) ? 20000 : -20000);
    int after = 0;
    for (int i = 0; i < 2000; i++) after = std::max(after, abs((int)sample(0)));
    // the max over the LAST part of the silence, not over a window that starts
    // while the tail is still loud -- the same mistake that made checks 3 and 4
    // look like RTL faults on the first run
    int settled = 0;
    for (int i = 0; i < 24000; i++) {
        int v = abs((int)sample(0));
        if (i >= 22000) settled = std::max(settled, v);
    }
    snprintf(d, sizeof d, "peak %d just after, %d half a second later", after, settled);
    check("the tail decays away after a loud passage", settled < after / 8, d);

    printf("\n%s\n", failures ? "FAIL" : "PASS");
    delete dut;
    return failures ? 1 : 0;
}
