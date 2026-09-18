# ==============================================================================
# Quartus Prime Synopsys Design Constraint File
# ==============================================================================
# Cloak & Dagger core constraints.
#
# The Pocket BSP (platform/pocket/bsp/pocket/sys_constr.sdc) creates the APF
# clocks; this file describes what is specific to this core.
#
# There is no external memory here at all -- the whole machine, ROMs and both
# 64 KB bitmap buffers included, is about 1.6 Mbit of block RAM -- so there are
# no SDRAM pin constraints to get right.
# ==============================================================================

# ==============================================================================
# Clock groups
#
# core_pll general[0] = clk_sys       40.000 MHz (8x the dot clock)
#          general[1] = clk_vid        5.000 MHz (dot clock, 90 deg)
#          general[2] = clk_vid 90deg  5.000 MHz (180 deg)
#          general[3], general[4]      unused
#
# clk_sys and the two pixel clocks stay in ONE group on purpose. The video
# output is launched on clk_sys and sampled by the APF scaler on clk_vid; they
# are integer-related outputs of the same PLL, so that crossing is synchronous
# by construction and should be verified rather than cut. Cutting it would let
# each build route it blind and make the picture depend on the fitter seed.
# core_top also phase-locks the core's own pixel enable to clk_vid (pix_sync),
# so the sample lands away from the pixel's own edge.
#
# clk_74a, clk_74b, the bridge SPI clock and the audio PLL are genuinely
# asynchronous to the machine. The one multi-bit bus that crosses into clk_74b
# -- the audio sample -- is handed over with a toggle flag in core_top, so the
# capture is always of a value that has been still for several cycles
# (METHODOLOGY section 5.4).
# ==============================================================================
set_clock_groups -asynchronous \
 -group { bridge_spiclk } \
 -group { clk_74a } \
 -group { clk_74b } \
 -group { ic|core_pll|core_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk \
          ic|core_pll|core_pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk \
          ic|core_pll|core_pll_inst|altera_pll_i|general[2].gpll~PLL_OUTPUT_COUNTER|divclk \
          ic|core_pll|core_pll_inst|altera_pll_i|general[3].gpll~PLL_OUTPUT_COUNTER|divclk \
          ic|core_pll|core_pll_inst|altera_pll_i|general[4].gpll~PLL_OUTPUT_COUNTER|divclk } \
 -group { ic|pocket_audio_mixer|audio_pll|mf_audio_pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk } \
 -group { ic|pocket_audio_mixer|audio_pll|mf_audio_pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk }

# ==============================================================================
# T65 multicycle.
#
# Both 6502s advance only on a clock enable: the master every 40 clk_sys cycles
# (40 MHz / 40 = 1.000 MHz) and the slave every 32 (1.250 MHz). Every
# register-to-register path *inside* T65 therefore has at least 32 clock periods
# to settle, and T65's microcode decode is the widest combinational block in the
# design.
#
# Deliberately scoped to paths that both start and end inside the CPU: the
# address and data buses run to block RAM ports clocked every cycle, and those
# must still meet single-cycle timing.
#
# 8 rather than 32: a quarter of the provable margin, which is plenty of relief
# and leaves the constraint correct even if the enable generation is changed.
# The same numbers the Punch-Out!!, S.T.U.N. Runner and Atari System 2 cores use.
# ==============================================================================
set_multicycle_path -setup 8 -from [get_registers {*|T65:*|*}] -to [get_registers {*|T65:*|*}]
set_multicycle_path -hold  7 -from [get_registers {*|T65:*|*}] -to [get_registers {*|T65:*|*}]

# ==============================================================================
# POKEY.
#
# rtl/pokey.sv is a single `always_ff @(posedge clk)` whose whole state machine
# is inside `if (cen && ...)`, cen being the 1.25 MHz chip enable -- one pulse
# per 32 clk_sys cycles. The only per-clock writes are the register writes,
# which cloak_main asserts for exactly one clock at a CPU enable, so those too
# change only at a cen boundary. 8 as above.
# ==============================================================================
set_multicycle_path -setup 8 -from [get_registers {*|pokey:*|*}] -to [get_registers {*|pokey:*|*}]
set_multicycle_path -hold  7 -from [get_registers {*|pokey:*|*}] -to [get_registers {*|pokey:*|*}]

# ==============================================================================
# cloak_audio's output stage steps once per POKEY clock (32 clk_sys cycles) and
# carries the widest arithmetic in the core: two 24x12 multiplies for the
# op-amp poles and a 32x12 for the decimator. Same reasoning, same numbers.
# ==============================================================================
set_multicycle_path -setup 8 -from [get_registers {*|cloak_audio:*|*}] -to [get_registers {*|cloak_audio:*|*}]
set_multicycle_path -hold  7 -from [get_registers {*|cloak_audio:*|*}] -to [get_registers {*|cloak_audio:*|*}]
