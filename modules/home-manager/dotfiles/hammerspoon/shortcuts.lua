local hyper = { "ctrl", "alt", "shift", "cmd" }
local meh = { "ctrl", "alt", "shift" }

local keymaps = {
  ["Firefox"] = {
    mods = hyper,
    key = "b",
  },
  ["Firefox New Window"] = {
    mods = meh,
    key = "b",
    callback = function()
      hs.osascript.javascript([[
        Application("Firefox").Window().make()
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
