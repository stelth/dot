local yabaiOutput, _, _, _ = hs.execute("which yabai", true)
local yabai = string.gsub(yabaiOutput, "%s+", "")

local function execYabai(args)
  local command = string.format("%s %s", yabai, args)
  print(string.format("yabai: %s", command))
  os.execute(command)
end

local directions = {
  a = "west",
  u = "east",
  e = "north",
  o = "south",
}
for key, direction in pairs(directions) do
  -- focus windows
  hs.hotkey.bind({ "cmd", "ctrl" }, key, function()
    execYabai(string.format("-m window --focus %s", direction))
  end)
  -- move windows
  hs.hotkey.bind({ "cmd", "shift" }, key, function()
    execYabai(string.format("-m window --warp %s", direction))
  end)
  -- swap windows
  hs.hotkey.bind({ "shift", "alt" }, key, function()
    execYabai(string.format("-m window --swap %s", direction))
  end)
end

-- window float settings
local floating = {
  -- full
  up = "1:1:0:0:1:1",
  -- left half
  left = "1:2:0:0:1:1",
  -- right half
  right = "1:2:1:0:1:1",
}
for key, gridConfig in pairs(floating) do
  hs.hotkey.bind({ "alt", "shift" }, key, function()
    execYabai(string.format("--grid %s", gridConfig))
  end)
end
-- balance window size
hs.hotkey.bind({ "alt", "shift" }, "down", function()
  execYabai("-m space --balance")
end)

-- layout settings
local layouts = {
  j = "bsp",
  k = "float",
}
for key, layout in pairs(layouts) do
  hs.hotkey.bind({ "alt", "shift" }, key, function()
    execYabai(string.format("-m space --layout %s", layout))
  end)
end

-- toggle settings
local toggleArgs = {
  g = "-m space --toggle padding; yabai -m space --toggle gap",
  c = "-m window --toggle zoom-parent",
  r = "-m window --toggle split",
  h = "-m window --toggle zoom-fullscreen",
  t = "-m window --toggle topmost",
  n = "-m space --rotate 90",
  m = "-m window --toggle sticky",
  w = "-m space --mirror x-axis",
  v = "-m space --mirror y-axis",
}
for key, args in pairs(toggleArgs) do
  hs.hotkey.bind({ "alt" }, key, function()
    execYabai(args)
  end)
end

-- throw/focus monitors
local targets = {
  x = "recent",
  p = "prev",
  y = "next",
}
for key, target in pairs(targets) do
  hs.hotkey.bind({ "ctrl", "alt" }, key, function()
    execYabai(string.format("-m display --focus %s", target))
  end)
  hs.hotkey.bind({ "ctrl", "cmd" }, key, function()
    execYabai(string.format("-m window --display %s", target))
    execYabai(string.format("-m display --focus %s", target))
  end)
end

local displayMaps = {
  a = 2,
  o = 1,
  e = 3,
  u = 4,
}
-- numbered monitors
for key, screen in pairs(displayMaps) do
  hs.hotkey.bind({ "ctrl", "alt" }, key, function()
    execYabai(string.format("-m display --focus %s", screen))
  end)
  hs.hotkey.bind({ "alt", "cmd" }, key, function()
    execYabai(string.format("-m window --display %s", screen))
    execYabai(string.format("-m display --focus %s", screen))
  end)
end
