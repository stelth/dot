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
