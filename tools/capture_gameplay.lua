-- Snapshot MAME through a coin, a start and the opening of a game, for
-- sim/run_gameplay.sh to diff the core against frame by frame.
--   CLOAK_FRAMES  comma-separated frames to snapshot
--   CLOAK_STOP    frame to exit at
--   CLOAK_INPUTS  "frame:field:len" presses, as tools/dump_state.lua takes
local want = {}
for f in string.gmatch(os.getenv("CLOAK_FRAMES") or "", "[^,]+") do want[tonumber(f)] = true end
local stopf = tonumber(os.getenv("CLOAK_STOP") or "1500")
local presses = {}
for p in string.gmatch(os.getenv("CLOAK_INPUTS") or "", "[^,]+") do
  local f, name, len = string.match(p, "^(%d+):([^:]+):(%d+)$")
  if f then table.insert(presses, {f = tonumber(f), name = name, len = tonumber(len)}) end
end
local m = manager.machine
local fields = {}
for _, pn in ipairs({":P1", ":SYSTEM", ":START", ":DSW"}) do
  local port = m.ioport.ports[pn]
  if port then for n, fl in pairs(port.fields) do fields[n] = fl end end
end
local n = 0
emu.register_frame_done(function()
  n = n + 1
  for _, p in ipairs(presses) do
    if n == p.f then fields[p.name]:set_value(1) end
    if n == p.f + p.len then fields[p.name]:set_value(0) end
  end
  if want[n] then m.video:snapshot() end
  if n >= stopf then m:exit() end
end)
