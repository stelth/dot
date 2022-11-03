local hyper = { "ctrl", "alt", "shift", "cmd" }
local meh = { "ctrl", "alt", "shift" }

local keymaps = {
  ["Brave Browser"] = {
    mods = hyper,
    key = "b",
  },
  ["Brave New Window"] = {
    mods = meh,
    key = "b",
    callback = function()
      hs.osascript.javascript([[
        Application("Brave").Window().make()
    ]])
    end,
  },
  ["Firefox Developer Edition"] = {
    mods = hyper,
    key = "f",
  },
  ["kitty"] = {
    mods = hyper,
    key = "k",
  },
  ["Microsoft Outlook"] = {
    mods = hyper,
    key = "o",
  },
  ["Slack"] = {
    mods = hyper,
    key = "s",
  },
  ["Discord"] = {
    mods = hyper,
    key = "d",
  },
  ["Cyberduck"] = {
    mods = hyper,
    key = "c",
  },
  ["Lock Screen"] = {
    mods = hyper,
    key = "l",
    callback = hs.caffeinate.lockScreen,
  },
  ["Load Default Setup"] = {
    mods = hyper,
    key = "i",
    callback = function()
      local initialApps = {
        "Brave Browser",
        "Firefox Developer Edition",
        "kitty",
        "Microsoft Outlook",
        "Slack",
        "Discord",
      }

      for _, app in ipairs(initialApps) do
        hs.application.launchOrFocus(app)
      end

      hs.alert.show("Launched all applications")
    end,
  },
}

for name, options in pairs(keymaps) do
  local fn = function()
    hs.application.launchOrFocus(name)
  end

  if options.callback ~= nil then
    fn = options.callback
  end
  hs.hotkey.bind(options.mods or {}, options.key, fn)
end
