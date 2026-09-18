-- Snapshot MAME's self-test at chosen frames, for sim/run_selftest.sh to diff
-- the RTL against. The self-test switch has to be on before the game boots --
-- it is read once during power-on and never polled again -- and MAME's Lua
-- cannot set a DIPSWITCH field early enough, so tools/capture_selftest.sh
-- writes a cfg file instead and this script only takes the snapshots.
--   CLOAK_FRAMES  comma-separated frames to snapshot
--   CLOAK_STOP    frame to exit at
local want = {}
for f in string.gmatch(os.getenv("CLOAK_FRAMES") or "", "[^,]+") do want[tonumber(f)] = true end
local stopf = tonumber(os.getenv("CLOAK_STOP") or "400")
local m = manager.machine
local n = 0
emu.register_frame_done(function()
  n = n + 1
  if n == 1 then
    print(string.format("SYSTEM at frame 1 = %02x (bit 1 clear = self-test on)",
                        m.ioport.ports[":SYSTEM"]:read()))
  end
  if want[n] then m.video:snapshot(); print("snap", n) end
  if n >= stopf then m:exit() end
end)
