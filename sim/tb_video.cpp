// Frozen-state video bench: load a MAME capture (tools/dump_state.lua) and the
// .rom image into cloak_video's memories through the ports the CPUs use, run a
// few frames, and write the frame the beam produces as a PPM for
// tools/diff_frames.py to compare against the reference renderer's output.
//
//   Vcloak_video <state.txt> <image.rom> <out.ppm>
//
// The state's .bin (the displayed bitmap buffer) is loaded into buffer 0 with
// bm_sel pointing at it, and bm_sel is then flipped so buffer 0 becomes the one
// the beam shows -- which is what "displayed" means (hardware.md 5.2).
#include "Vcloak_video.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>
#include <map>

static Vcloak_video *dut;
static vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

// image layout (docs/hardware.md section 7 / cloak.mra)
static const int R_CHARS = 0x1a100, N_CHARS = 8192;
static const int R_SPRITE = 0x1c100, N_SPRITE = 8192;
static const int R_PROM = 0x1e100, N_PROM = 256;

static const int VIS_W = 256, VIS_H = 232;

// ---------------------------------------------------------------- state file
struct State {
    std::map<std::string, unsigned> scalars;
    std::map<std::string, std::vector<unsigned>> arrays;
    std::vector<unsigned char> bitmap;
};

static bool load_state(const char *path, State &st) {
    FILE *f = fopen(path, "r");
    if (!f) { fprintf(stderr, "cannot open %s\n", path); return false; }
    char line[8192];
    while (fgets(line, sizeof line, f)) {
        char name[128];
        unsigned count = 0, size = 0;
        if (sscanf(line, "%127s", name) != 1) continue;
        std::string n(name);
        if (n.size() > 2 && n.compare(n.size() - 2, 2, "[]") == 0) {
            n = n.substr(0, n.size() - 2);
            sscanf(line, "%*s %u %u", &count, &size);
            std::vector<unsigned> vals;
            while (vals.size() < count && fgets(line, sizeof line, f)) {
                char *p = line;
                while (*p) {
                    while (*p == ' ' || *p == '\n' || *p == '\r') p++;
                    if (!*p) break;
                    vals.push_back(strtoul(p, &p, 16));
                }
            }
            vals.resize(count);
            st.arrays[n] = vals;
        } else {
            unsigned v = 0;
            int base = (n == "frame" || n == "real_frame") ? 10 : 16;
            char valbuf[64];
            if (sscanf(line, "%*s %63s", valbuf) == 1) v = strtoul(valbuf, nullptr, base);
            st.scalars[n] = v;
        }
    }
    fclose(f);
    std::string bp(path);
    bp = bp.substr(0, bp.size() - 4) + ".bin";
    FILE *b = fopen(bp.c_str(), "rb");
    if (!b) { fprintf(stderr, "cannot open %s\n", bp.c_str()); return false; }
    st.bitmap.resize(65536);
    if (fread(st.bitmap.data(), 1, 65536, b) != 65536) {
        fprintf(stderr, "%s: short read\n", bp.c_str()); fclose(b); return false;
    }
    fclose(b);
    return true;
}

// ------------------------------------------------------------------- clocking
static void tick() {
    dut->clk = 0; dut->eval(); main_time++;
    dut->clk = 1; dut->eval(); main_time++;
}

// One dot: cen_pix high for a single clock out of eight, as the core's enable
// divider produces it.
static void dot() {
    dut->cen_pix = 1; tick();
    dut->cen_pix = 0;
    for (int i = 0; i < 7; i++) tick();
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    if (argc < 4) { fprintf(stderr, "usage: %s <state.txt> <image.rom> <out.ppm>\n", argv[0]); return 2; }

    State st;
    if (!load_state(argv[1], st)) return 2;
    FILE *rf = fopen(argv[2], "rb");
    if (!rf) { fprintf(stderr, "cannot open %s\n", argv[2]); return 2; }
    std::vector<unsigned char> rom;
    { fseek(rf, 0, SEEK_END); long n = ftell(rf); fseek(rf, 0, SEEK_SET);
      rom.resize(n); if (fread(rom.data(), 1, n, rf) != (size_t)n) { fclose(rf); return 2; } fclose(rf); }
    if (rom.size() < (size_t)(R_PROM + N_PROM) || memcmp(rom.data(), "CLDG", 4)) {
        fprintf(stderr, "%s is not a cloak image\n", argv[2]); return 2;
    }

    dut = new Vcloak_video;
    dut->clk = 0; dut->reset = 1; dut->cen_pix = 0;
    dut->pf_we = 0; dut->mo_we = 0; dut->pal_we = 0; dut->bm_we = 0;
    dut->gfx_we = 0; dut->prom_we = 0; dut->bm_clear = 0; dut->bm_sel = 0; dut->flip = 0;
    for (int i = 0; i < 16; i++) tick();
    dut->reset = 0;
    for (int i = 0; i < 4; i++) tick();

    // ---- graphics ROMs and the timing PROM
    for (int i = 0; i < N_CHARS; i++) {
        dut->gfx_we = 1; dut->gfx_waddr = i; dut->gfx_wdata = rom[R_CHARS + i]; tick();
    }
    for (int i = 0; i < N_SPRITE; i++) {
        dut->gfx_we = 1; dut->gfx_waddr = 0x2000 + i; dut->gfx_wdata = rom[R_SPRITE + i]; tick();
    }
    dut->gfx_we = 0;
    for (int i = 0; i < N_PROM; i++) {
        dut->prom_we = 1; dut->prom_waddr = i; dut->prom_wdata = rom[R_PROM + i]; tick();
    }
    dut->prom_we = 0;

    // ---- playfield, motion objects, palette
    const auto &vram = st.arrays["videoram"];
    for (size_t i = 0; i < vram.size(); i++) {
        dut->pf_we = 1; dut->pf_addr = i; dut->pf_wdata = vram[i]; tick();
    }
    dut->pf_we = 0;
    const auto &sram = st.arrays["spriteram"];
    for (size_t i = 0; i < sram.size(); i++) {
        dut->mo_we = 1; dut->mo_addr = i; dut->mo_wdata = sram[i]; tick();
    }
    dut->mo_we = 0;
    const auto &pal = st.arrays["palette"];
    for (size_t i = 0; i < pal.size(); i++) {
        dut->pal_we = 1; dut->pal_addr = ((pal[i] >> 8) & 1) << 6 | (i & 0x3f);
        dut->pal_wdata = pal[i] & 0xff; tick();
    }
    dut->pal_we = 0;

    // ---- the displayed bitmap buffer: write it as buffer 0, then show it
    dut->bm_sel = 0;                        // writes land in buffer 0
    for (int i = 0; i < 65536; i++) {
        dut->bm_we = 1; dut->bm_addr = i; dut->bm_wdata = st.bitmap[i] & 0xf; tick();
    }
    dut->bm_we = 0;
    dut->bm_sel = 1;                        // buffer 1 is drawn into, 0 is shown

    dut->flip = st.scalars.count("flip_x") ? (st.scalars["flip_x"] ? 1 : 0) : 0;

    // ---- run: throw the first two frames away so the line buffers and the
    //      prefetch pipelines are in steady state, then capture the third
    std::vector<unsigned char> img(VIS_W * VIS_H * 3, 0);
    int frames_seen = 0, captured = 0, last_vs = 0;
    long guard = 0;
    bool capturing = false;
    while (frames_seen < 4 && guard++ < 4000000) {
        dot();
        int vs = dut->vsync;
        if (vs && !last_vs) {
            frames_seen++;
            if (frames_seen == 3) { capturing = true; captured = 0; }
            else if (capturing) capturing = false;
        }
        last_vs = vs;
        if (capturing && dut->de) {
            if (captured < VIS_W * VIS_H) {
                img[captured * 3 + 0] = dut->red;
                img[captured * 3 + 1] = dut->green;
                img[captured * 3 + 2] = dut->blue;
            }
            captured++;
        }
    }
    if (captured != VIS_W * VIS_H) {
        fprintf(stderr, "captured %d pixels, expected %d\n", captured, VIS_W * VIS_H);
        return 1;
    }
    FILE *o = fopen(argv[3], "wb");
    if (!o) { fprintf(stderr, "cannot write %s\n", argv[3]); return 2; }
    fprintf(o, "P6\n%d %d\n255\n", VIS_W, VIS_H);
    fwrite(img.data(), 1, img.size(), o);
    fclose(o);
    printf("captured %d pixels over %d frames\n", captured, frames_seen);
    delete dut;
    return 0;
}
