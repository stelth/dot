hs.window.animationDuration = 0

hs.loadSpoon("SpoonInstall")
Install = spoon.SpoonInstall
Install.use_syncinstall = true

Install:andUse("ReloadConfiguration", { start = true })
Install:andUse("RoundedCorners", { start = true, config = { radius = 8 } })
Install:andUse("Caffeine", {
  start = true,
})

spoon.Caffeine:setState(true)

require("shortcuts")
require("yabai")

hs.alert.show("Hammerspoon Loaded!")
