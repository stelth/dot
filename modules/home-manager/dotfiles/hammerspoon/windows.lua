M = {}

hs.window.animationDuration = 0
hs.application.enableSpotlightForNameSearches(true)

local spaces = require("hs.spaces")
local wf = hs.window.filter

local sleep_interval = 1

local sleep = function(n)
  os.execute("sleep " .. tonumber(n))
end

local positionApp = function(appTitle, screen, space, layout)
  if hs.application.get(appTitle) == nil then
    return
  end

  hs.application.get(appTitle):activate()
  local windows = wf.new(appTitle):setCurrentSpace(nil):getWindows()
  for _, win in pairs(windows) do
    win:moveToScreen(screen)
    spaces.moveWindowToSpace(win:id(), space)
    spaces.gotoSpace(space)
    hs.layout.apply({
      { nil, win, screen, layout, nil, nil },
    })
    sleep(sleep_interval)
  end
end

local ensureSpaces = function(screen, numSpaces)
  local allSpaces = hs.spaces.spacesForScreen(screen:id())
  table.sort(allSpaces)

  local activeSpace = hs.spaces.spacesForScreen(screen:id())

  for _, space in pairs(allSpaces) do
    if space ~= activeSpace then
      hs.spaces.removeSpace(space, false)
    end
  end

  allSpaces = hs.spaces.spacesForScreen(screen:id())
  for _ = 1, numSpaces - #allSpaces, 1 do
    hs.spaces.addSpaceToScreen(screen, false)
  end
end

local positionWindows = function(appLayout)
  hs.spaces.openMissionControl()

  local screens = hs.screen.allScreens()

  table.sort(screens, function(a, b)
    local ax, _ = a:position()
    local bx, _ = b:position()

    return ax < bx
  end)

  for displayIndex, display in ipairs(appLayout.displays) do
    ensureSpaces(screens[displayIndex], #display.spaces)

    local screenSpaces = hs.spaces.spacesForScreen(screens[displayIndex])
    table.sort(screenSpaces)

    for spaceIndex, space in ipairs(display.spaces) do
      for appName, appInfo in pairs(space.apps) do
        positionApp(appName, screens[displayIndex], screenSpaces[spaceIndex], appInfo.layout)
      end
    end
  end

  hs.spaces.closeMissionControl()

  hs.alert.show("Finished organizing windows")
end

M.officeMobile = function()
  local mobileLayout = {
    displays = {
      {
        spaces = {
          {
            apps = {
              ["kitty"] = {
                layout = hs.layout.left50,
              },
              ["Google Chrome"] = {
                layout = hs.layout.right50,
              },
            },
          },
          {
            apps = {
              ["Discord"] = {
                layout = hs.layout.maximized,
              },
            },
          },
          {
            apps = {
              ["Firefox Developer Edition"] = {
                layout = hs.layout.maximized,
              },
            },
          },
          {
            apps = {
              ["Microsoft Outlook"] = {
                layout = hs.layout.left50,
              },
              ["Slack"] = {
                layout = hs.layout.right50,
              },
            },
          },
        },
      },
    },
  }

  positionWindows(mobileLayout)
end

M.office = function()
  local homeOfficeLayout = {
    displays = {
      {
        spaces = {
          {
            apps = {
              ["kitty"] = {
                layout = hs.layout.left50,
              },
              ["Firefox Developer Edition"] = {
                layout = hs.layout.right50,
              },
            },
          },
        },
      },
      {
        spaces = {
          {
            apps = {
              ["Google Chrome"] = {
                layout = hs.layout.left50,
              },
              ["Discord"] = {
                layout = hs.layout.right50,
              },
            },
          },
        },
      },
      {
        spaces = {
          {
            apps = {
              ["Microsoft Outlook"] = {
                layout = hs.layout.left50,
              },
              ["Slack"] = {
                layout = hs.layout.right50,
              },
            },
          },
        },
      },
    },
  }

  positionWindows(homeOfficeLayout)
end

local menubar = hs.menubar.new()
menubar:setIcon(hs.image.imageFromName("NSHandCursor"))

if menubar then
  menubar:setMenu({
    { title = "Office", fn = M.office },
    { title = "Office Mobile", fn = M.officeMobile },
  })
end

return M
