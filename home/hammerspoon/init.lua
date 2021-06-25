hs.window.animationDuration = 0

local monocle = require("monocle")

hs.hotkey.bind({ "alt" }, "z", "Zoom", function(event)
  print(hs.inspect(event))
  local win = hs.window.focusedWindow()
  if win then
    moncole.toggle(win)
  end
end)

hs.alert.show("Hammerspoon Loaded!")
