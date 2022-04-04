hs.window.animationDuration = 0

local hyper = require("hyper")
hyper.bindApp({}, "f", "Firefox")
hyper.bindApp({ "cmd" }, "f", function()
  hs.osascript.javascript([[
        Application("Firefox").Window().make()
    ]])
end)
hyper.bindApp({}, "b", "Google Chrome")
hyper.bindApp({ "cmd" }, "b", function()
  hs.osascript.javascript([[
        Application("Google Chrome").Window().make()
    ]])
end)

hyper.bindApp({}, "k", "kitty")
hyper.bindApp({}, "o", "Microsoft Outlook")
hyper.bindApp({}, "s", "Slack")
hyper.bindApp({}, "d", "Discord")
hyper.bindApp({}, "c", "Cyberduck")

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
spoon.SpoonInstall:andUse("ReloadConfiguration", { start = true })
spoon.SpoonInstall:andUse("RoundedCorners", { start = true, config = { radius = 8 } })
spoon.SpoonInstall:andUse("AClock", {
  config = { showDuration = 2 },
  fn = function(clock)
    hyper:bind({ "ctrl" }, "t", function()
      clock:toggleShow()
    end)
  end,
})
spoon.SpoonInstall:andUse("Caffeine", {
  start = true,
})

yabai = require("yabai")

hs.alert.show("Hammerspoon Loaded!")
