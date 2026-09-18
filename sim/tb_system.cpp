// Whole-machine bench: load the .rom image into cloak_core and run the real
// game -- both 6502s, the video, the POKEYs -- capturing frames as PPM.
//
//   Vcloak_core <image.rom> <out-dir> [frames] [frame,frame,...] [inputs]
//
// `inputs` is the same "frame:name:len" list tools/dump_state.lua takes, with
// names coin1, coin2, start1, start2, service, test, button, and the eight
// stick directions lup/ldown/lleft/lright/rup/rdown/rleft/rright.
#include "Vcloak_core.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>
#include <set>
#include <map>

static Vcloak_core *dut;
static vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

static const int VIS_W = 256, VIS_H = 232;

static void tick() {
    dut->clk_sys = 0; dut->eval(); main_time++;
    dut->clk_sys = 1; dut->eval(); main_time++;
}

struct Press { int frame, len; std::string name; };

static void set_input(const std::string &n, int v) {
    if      (n == "coin1")   dut->coin1 = v;
    else if (n == "coin2")   dut->coin2 = v;
    else if (n == "start1")  dut->start1 = v;
    else if (n == "start2")  dut->start2 = v;
    else if (n == "service") dut->service = v;
    else if (n == "test")    dut->test = v;
    else if (n == "button")  dut->p1_button = v;
    else if (n == "lup")     dut->p1_left_up = v;
    else if (n == "ldown")   dut->p1_left_down = v;
    else if (n == "lleft")   dut->p1_left_left = v;
    else if (n == "lright")  dut->p1_left_right = v;
    else if (n == "rup")     dut->p1_right_up = v;
    else if (n == "rdown")   dut->p1_right_down = v;
    else if (n == "rleft")   dut->p1_right_left = v;
    else if (n == "rright")  dut->p1_right_right = v;
    else fprintf(stderr, "unknown input '%s'\n", n.c_str());
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    if (argc < 3) {
        fprintf(stderr, "usage: %s <image.rom> <out-dir> [frames] [f,f,..] [inputs]\n", argv[0]);
        return 2;
    }
    const char *rompath = argv[1];
    std::string outdir = argv[2];
    int nframes = (argc > 3) ? atoi(argv[3]) : 600;
    std::set<int> want;
    if (argc > 4 && argv[4][0]) {
        char *s = strdup(argv[4]);
        for (char *t = strtok(s, ","); t; t = strtok(nullptr, ",")) want.insert(atoi(t));
        free(s);
    }
    std::vector<Press> presses;
    if (argc > 5 && argv[5][0]) {
        char *s = strdup(argv[5]);
        for (char *t = strtok(s, ","); t; t = strtok(nullptr, ",")) {
            char nm[64]; int f, l;
            if (sscanf(t, "%d:%63[^:]:%d", &f, nm, &l) == 3) presses.push_back({f, l, nm});
        }
        free(s);
    }

    std::vector<unsigned char> rom;
    { FILE *f = fopen(rompath, "rb");
      if (!f) { fprintf(stderr, "cannot open %s\n", rompath); return 2; }
      fseek(f, 0, SEEK_END); long n = ftell(f); fseek(f, 0, SEEK_SET);
      rom.resize(n);
      if (fread(rom.data(), 1, n, f) != (size_t)n) { fclose(f); return 2; }
      fclose(f); }
    if (rom.size() < 0x1e200 || memcmp(rom.data(), "CLDG", 4)) {
        fprintf(stderr, "%s is not a cloak image\n", rompath); return 2;
    }

    dut = new Vcloak_core;
    dut->clk_sys = 0; dut->reset = 1;
    dut->ioctl_wr = 0; dut->ioctl_download = 0; dut->ioctl_addr = 0; dut->ioctl_data = 0;
    dut->p1_left_up = dut->p1_left_down = dut->p1_left_left = dut->p1_left_right = 0;
    dut->p1_right_up = dut->p1_right_down = dut->p1_right_left = dut->p1_right_right = 0;
    dut->p1_button = dut->start1 = dut->start2 = dut->coin1 = dut->coin2 = 0;
    dut->service = dut->test = 0;
    dut->pause = 0;
    dut->pix_sync = 0;      // the bench drives cen_pix itself; no platform clock here
    dut->nvclear = 0;
    dut->dsw = 0x02;                        // MAME's defaults: 1 credit / 1 game
    dut->dcblock_en = 1;
    dut->nv_addr = 0; dut->nv_we = 0; dut->nv_wdata = 0;
    for (int i = 0; i < 64; i++) tick();
    dut->reset = 0;
    for (int i = 0; i < 16; i++) tick();

    // ---- load the image
    dut->ioctl_download = 1;
    for (size_t i = 0; i < rom.size(); i++) {
        dut->ioctl_addr = i; dut->ioctl_data = rom[i]; dut->ioctl_wr = 1; tick();
        dut->ioctl_wr = 0; tick();
    }
    dut->ioctl_download = 0;
    for (int i = 0; i < 64; i++) tick();
    printf("loaded %zu bytes\n", rom.size());

    // ---- run
    std::vector<unsigned char> img(VIS_W * VIS_H * 3, 0);
    int frame = 0, px = 0, last_vs = 0;
    long clocks = 0;
    const long max_clocks = (long)nframes * 700000 + 4000000;
    while (frame <= nframes && clocks < max_clocks) {
        tick(); clocks++;
        if (!dut->cen_pix_out) continue;
        int vs = dut->vsync;
        if (vs && !last_vs) {
            if (want.count(frame)) {
                char path[512];
                snprintf(path, sizeof path, "%s/frame_%05d.ppm", outdir.c_str(), frame);
                FILE *o = fopen(path, "wb");
                if (o) {
                    fprintf(o, "P6\n%d %d\n255\n", VIS_W, VIS_H);
                    fwrite(img.data(), 1, img.size(), o);
                    fclose(o);
                    printf("frame %d -> %s (%d px)\n", frame, path, px);
                }
            }
            frame++;
            px = 0;
            for (auto &p : presses) {
                if (frame == p.frame) set_input(p.name, 1);
                if (frame == p.frame + p.len) set_input(p.name, 0);
            }
        }
        last_vs = vs;
        if (dut->de && px < VIS_W * VIS_H) {
            img[px * 3 + 0] = dut->red;
            img[px * 3 + 1] = dut->green;
            img[px * 3 + 2] = dut->blue;
            px++;
        } else if (dut->de) {
            px++;
        }
    }
    printf("ran %d frames, %ld clocks\n", frame, clocks);
    delete dut;
    return 0;
}
