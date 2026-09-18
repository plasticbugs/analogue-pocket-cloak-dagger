#!/usr/bin/env python3
"""Compare the core's audio against MAME's recording of the same sequence.

    compare_audio.py <mame.wav> <rtl.wav> [--onset] [--skip 0.05] [--window 1.0]

MAME writes stereo 16-bit at whatever -samplerate asks for; the core's bench
writes mono at 48,077 Hz (1.25 MHz / 26, see rtl/cloak_audio.sv). Both are
resampled to a common rate before anything is measured.

Reports peak, RMS and per-octave-band energy, with each signal's standing DC
offset removed first -- MAME's POKEY model leaves the op-amp summing node's
offset in and the core takes it out, and comparing them with it in place
measures that and nothing else.

Phase is NOT comparable and no attempt is made to compare it: this core runs
the board's 61.04 Hz rather than MAME's round 60 (docs/verification.md 6.1), so
the two drift 1.7% apart and the same note lands in a different place within
seconds. That is why the default window is one second from the first sound, and
why only the bands within 30 dB of the loudest are gated.

No dependencies; the DFT is a direct sum over a few band centres, which is
plenty for twelve bands and far cheaper than pulling in numpy.
"""
import sys, wave, math, argparse


def read_wav(path):
    """-> (rate, [float samples in -1..1], mono)"""
    with wave.open(path, 'rb') as w:
        nch, width, rate, n = w.getnchannels(), w.getsampwidth(), w.getframerate(), w.getnframes()
        raw = w.readframes(n)
    if width != 2:
        sys.exit(f'{path}: expected 16-bit, got {width * 8}-bit')
    out = []
    step = 2 * nch
    for i in range(0, len(raw), step):
        v = int.from_bytes(raw[i:i + 2], 'little', signed=True)
        if nch == 2:
            v2 = int.from_bytes(raw[i + 2:i + 4], 'little', signed=True)
            v = (v + v2) // 2
        out.append(v / 32768.0)
    return rate, out


def resample(xs, src, dst):
    """Linear resample; the signals here are band-limited well below Nyquist."""
    if src == dst:
        return xs
    n = int(len(xs) * dst / src)
    out = []
    for i in range(n):
        t = i * src / dst
        j = int(t)
        if j + 1 >= len(xs):
            break
        f = t - j
        out.append(xs[j] * (1 - f) + xs[j + 1] * f)
    return out


def rms(xs):
    return math.sqrt(sum(x * x for x in xs) / len(xs)) if xs else 0.0


def band_energy(xs, rate, centres):
    """Goertzel-ish: energy in a half-octave around each centre."""
    out = []
    n = len(xs)
    for fc in centres:
        lo, hi = fc / (2 ** 0.25), fc * (2 ** 0.25)
        # sum |X(f)|^2 over a few bins across the band
        tot = 0.0
        nf = 5
        for k in range(nf):
            f = lo * (hi / lo) ** (k / (nf - 1))
            w = 2 * math.pi * f / rate
            cr = si = 0.0
            for i in range(0, n, 2):          # every other sample: plenty here
                cr += xs[i] * math.cos(w * i)
                si += xs[i] * math.sin(w * i)
            tot += (cr * cr + si * si)
        out.append(tot / nf / ((n / 2) ** 2))
    return out


def db(x):
    return -99.0 if x <= 1e-12 else 20 * math.log10(x)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mame')
    ap.add_argument('rtl')
    ap.add_argument('--skip', type=float, default=1.0, help='seconds to drop from the start')
    ap.add_argument('--onset', action='store_true',
                    help='align on the first sound instead of on time zero -- the two run at '
                         'different frame rates, so the same event is at a different second')
    ap.add_argument('--window', type=float, default=1.0, help='seconds to measure')
    ap.add_argument('--tolerance', type=float, default=1.5,
                    help='dB the peak and RMS may differ by')
    args = ap.parse_args()

    ra, a = read_wav(args.mame)
    rb, b = read_wav(args.rtl)
    RATE = 48000
    a = resample(a, ra, RATE)
    b = resample(b, rb, RATE)
    if args.onset:
        def onset(xs):
            # the machine idles at a constant offset; sound is the first time
            # the signal moves away from its own running level
            base = xs[RATE // 10] if len(xs) > RATE // 10 else 0.0
            for i in range(0, len(xs) - RATE // 100):
                if abs(xs[i] - base) > 0.005:
                    return i
            return 0
        oa, ob = onset(a), onset(b)
        print(f'onset: MAME {oa/RATE:.2f} s, core {ob/RATE:.2f} s')
        a, b = a[oa:], b[ob:]
    s, n = int(args.skip * RATE), int(args.window * RATE)
    a, b = a[s:s + n], b[s:s + n]
    if len(a) < RATE or len(b) < RATE:
        sys.exit(f'not enough audio: mame {len(a)/RATE:.2f}s, rtl {len(b)/RATE:.2f}s after skipping {args.skip}s')
    n = min(len(a), len(b))
    a, b = a[:n], b[:n]

    # Remove each signal's mean before measuring anything. MAME's POKEY model
    # leaves the op-amp summing node's standing offset in the stream -- its
    # output is unipolar -- and the core takes it out with a DC blocker, which
    # is the whole point of having one. Comparing them with the offset in place
    # measures that difference and nothing else: it made the core look 0.55 dB
    # quiet on peak and 1.1 dB quiet on RMS when the audio bands agreed.
    ma, mb = sum(a) / n, sum(b) / n
    print(f'mean (the standing offset): MAME {ma:+.5f}, core {mb:+.5f} -- removed from both')
    a = [x - ma for x in a]
    b = [x - mb for x in b]

    pa, pb = max(abs(x) for x in a), max(abs(x) for x in b)
    ra_, rb_ = rms(a), rms(b)
    print(f'window {n/RATE:.2f} s at {RATE} Hz')
    print(f'  peak   MAME {pa:.4f}   core {pb:.4f}   ratio {pb/pa if pa else 0:.3f} ({db(pb/pa) if pa and pb else 0:+.2f} dB)')
    print(f'  RMS    MAME {ra_:.4f}   core {rb_:.4f}   ratio {rb_/ra_ if ra_ else 0:.3f} ({db(rb_/ra_) if ra_ and rb_ else 0:+.2f} dB)')

    centres = [125 * (2 ** (i / 2)) for i in range(12)]     # 125 Hz .. 8 kHz
    ea, eb = band_energy(a, RATE, centres), band_energy(b, RATE, centres)
    print('  band       MAME       core     diff      (reported, not gated)')
    for fc, x, y in zip(centres, ea, eb):
        lx, ly = db(math.sqrt(x)), db(math.sqrt(y))
        d = ly - lx if x > 0 and y > 0 else 0.0
        print(f'  {fc:7.0f} Hz  {lx:7.1f}  {ly:7.1f}  {d:+6.1f} dB')

    # The bands are printed but NOT gated, and that is a measured decision
    # rather than a soft one. This material is a sequence of effects, not a
    # steady tone: sliding the window 0.2 s along MAME's OWN recording moves its
    # 500 Hz band by 14 dB and its 707 Hz band by 6 dB. The two machines run at
    # different frame rates and are ~17 ms apart by the end of a one-second
    # window, so any per-band difference under about 6 dB says nothing at all.
    #
    # Peak and RMS over the window are stable against that shift, so they are
    # what the gate uses. The exact level check lives in sim/run_audio_unit.sh,
    # where the core is compared against MAME's own op-amp expression rather
    # than against a recording, and agrees to under three LSBs of 32,767.
    dp = abs(db(pb / pa)) if pa and pb else 99.0
    dr = abs(db(rb_ / ra_)) if ra_ and rb_ else 99.0
    worst = max(dp, dr)
    print(f'  worst of peak/RMS: {worst:.2f} dB (tolerance {args.tolerance:.1f})')
    return 0 if worst <= args.tolerance else 1


if __name__ == '__main__':
    sys.exit(main())
