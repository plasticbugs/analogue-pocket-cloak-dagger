-- Dump Cloak & Dagger video state (+ a PNG snapshot) from MAME at chosen
-- frames, driving the game with a scripted input sequence.
--
--   tools/mame_run.sh tools/dump_state.lua   with environment:
--     CLOAK_OUT     output directory (default artifacts/states)
--     CLOAK_TAG     name prefix for the dumps
--     CLOAK_FRAMES  comma-separated frame numbers to dump
--     CLOAK_INPUTS  comma-separated "frame:field:frames" presses, e.g.
--                   "400:Coin 1:8,500:1 Player Start:8"
--     CLOAK_STOP    frame to exit at
--
-- Each dump writes two files, named for the frame:
--   <tag>_<frame>.txt  scalars and the small arrays, hex, read by render_model.py
--   <tag>_<frame>.bin  the displayed bitmap buffer, 65536 bytes, one pixel each
-- and a PNG snapshot into MAME's snapshot directory, in dump order.
--
-- The .txt format is "name value" per line for scalars, then "name[] count size"
-- followed by whitespace-separated hex values.
--
-- Coherence: not every frame can be reproduced from an end-of-frame state.
-- MAME draws this screen lazily and in bands (every slave write to 1200 calls
-- screen->update_partial), so on a frame where the master changes the playfield
-- part-way through, the snapshot holds the older contents while this dump holds
-- the newer -- proved on attract frame 1800, whose snapshot matches exactly once
-- the playfield is put back to frame 1799's contents (docs/verification.md).
-- Write taps cannot detect it: the 6502's writes into the playfield RAM bypass
-- them (measured -- a tap over 0400-07ff counts zero while the RAM demonstrably
-- changes). tools/make_corpus.sh therefore dumps a few consecutive frames per
-- target and keeps the first one the reference renderer reproduces exactly.
local out   = os.getenv("CLOAK_OUT") or "artifacts/states"
local tag   = os.getenv("CLOAK_TAG") or "state"
local stopf = tonumber(os.getenv("CLOAK_STOP") or "3000")
local frames_wanted = {}
for f in string.gmatch(os.getenv("CLOAK_FRAMES") or "", "[^,]+") do frames_wanted[tonumber(f)] = true end
local presses = {}
for p in string.gmatch(os.getenv("CLOAK_INPUTS") or "", "[^,]+") do
  local f, name, len = string.match(p, "^(%d+):([^:]+):(%d+)$")
  if f then table.insert(presses, {f = tonumber(f), name = name, len = tonumber(len)}) end
end

local machine = manager.machine
local root    = machine.devices[":"]
local shares  = machine.memory.shares
local ioport  = machine.ioport

-- every input field the corpus can press, by its MAME name
local fields = {}
for _, pname in ipairs({":P1", ":SYSTEM", ":START", ":DSW"}) do
  local port = ioport.ports[pname]
  if port then for n, f in pairs(port.fields) do fields[n] = f end end
end

local function item(name) return emu.item(root.items["0/" .. name]) end

local function dump(frame)
  local sel   = item("m_bitmap_videoram_selected"):read(0)
  local palit = item("m_palette_ram")
  local path  = string.format("%s/%s_%05d.txt", out, tag, frame)
  local f = io.open(path, "w")
  f:write(string.format("frame %d\n", frame))
  f:write(string.format("bitmap_selected %x\n", sel))
  f:write(string.format("bitmap_x %x\n", item("m_bitmap_videoram_address_x"):read(0)))
  f:write(string.format("bitmap_y %x\n", item("m_bitmap_videoram_address_y"):read(0)))
  f:write(string.format("flip_x %x\n", item("m_flip_screen_x"):read(0)))
  f:write(string.format("flip_y %x\n", item("m_flip_screen_y"):read(0)))

  local function arr_share(name, sh, n)
    f:write(string.format("%s[] %d 1\n", name, n))
    local line = {}
    for i = 0, n - 1 do
      line[#line + 1] = string.format("%x", sh:read_u8(i))
      if #line == 64 then f:write(table.concat(line, " "), "\n"); line = {} end
    end
    if #line > 0 then f:write(table.concat(line, " "), "\n") end
  end
  arr_share("videoram",  shares[":videoram"],  1024)
  arr_share("spriteram", shares[":spriteram"], 256)
  arr_share("nvram",     shares[":nvram"],     512)

  f:write(string.format("palette[] %d 2\n", 64))
  local line = {}
  for i = 0, 63 do
    line[#line + 1] = string.format("%x", palit:read(i))
    if #line == 32 then f:write(table.concat(line, " "), "\n"); line = {} end
  end
  if #line > 0 then f:write(table.concat(line, " "), "\n") end
  f:close()

  -- the DISPLAYED bitmap is the buffer the slave is not drawing into:
  -- m_bitmap_videoram[!selected], and share "bitmap_videoram1" is index 0.
  local disp = (sel ~= 0) and shares[":bitmap_videoram1"] or shares[":bitmap_videoram2"]
  local bf = io.open(string.format("%s/%s_%05d.bin", out, tag, frame), "wb")
  local chunk = {}
  for i = 0, 65535 do
    chunk[#chunk + 1] = string.char(disp:read_u8(i) & 0x0f)
    if #chunk == 4096 then bf:write(table.concat(chunk)); chunk = {} end
  end
  if #chunk > 0 then bf:write(table.concat(chunk)) end
  bf:close()

  machine.video:snapshot()
  print("dumped", path)
end

local frames = 0
emu.register_frame_done(function()
  frames = frames + 1
  for _, p in ipairs(presses) do
    if frames == p.f then fields[p.name]:set_value(1) end
    if frames == p.f + p.len then fields[p.name]:set_value(0) end
  end
  if frames_wanted[frames] then dump(frames) end
  if frames >= stopf then machine:exit() end
end)
