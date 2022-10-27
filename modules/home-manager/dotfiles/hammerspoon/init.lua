hs.window.animationDuration = 0

hs.loadSpoon("SpoonInstall")
local Install = spoon.SpoonInstall
Install.use_syncinstall = true

Install:andUse("EmmyLua")
Install:andUse("ReloadConfiguration", { start = true })
Install:andUse("RoundedCorners", { start = true, config = { radius = 8 } })
Install:andUse("Caffeine", {
  start = true,
})

spoon.Caffeine:setState(true)

require("shortcuts")

hs.alert.show("Hammerspoon Loaded!")
