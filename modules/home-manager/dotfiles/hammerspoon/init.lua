hs.window.animationDuration = 0

local tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
  -- print(hs.inspect(event))
  local isCmd = event:getFlags():containExactly({ "cmd" })
  local isQ = event:getKeyCode() == hs.keycodes.map["q"]
  if isCmd and isQ then
    local win = hs.window.focusedWindow()
    if win and win:application():name():find("kitty") then
      hs.alert("Use alt+cmd+q instead!")
      return true
    end
  end
end)
tap:start()

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.us_syncinstall = true
Install = spoon.SpoonInstall

Install:andUse("ReloadConfiguration", { start = true })
Install:andUse("RoundedCorners", { start = true, config = { radius = 8 } })
Install:andUse("Caffeine", {
  start = true,
})

require("shortcuts")
require("yabai")

hs.alert.show("Hammerspoon Loaded!")
