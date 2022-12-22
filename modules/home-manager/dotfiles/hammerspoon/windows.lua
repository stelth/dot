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

  for _ = 1, numSpaces - #allSpaces, 1 do
    hs.spaces.addSpaceToScreen(screen, false)
  end
end

M.officeMobile = function()
  hs.spaces.openMissionControl()
  -- Get screens
  local screen = hs.screen.mainScreen()
  ensureSpaces(screen, 4)

  local allSpaces = hs.spaces.spacesForScreen(screen:id())

  table.sort(allSpaces)

  positionApp("kitty", screen, allSpaces[1], hs.layout.left50)
  positionApp("Google Chrome", screen, allSpaces[1], hs.layout.right50)
  positionApp("Discord", screen, allSpaces[2], hs.layout.maximize)
  positionApp("Firefox Developer Edition", screen, allSpaces[3], hs.layout.maximize)
  positionApp("Microsoft Outlook", screen, allSpaces[4], hs.layout.left50)
  positionApp("Slack", screen, allSpaces[4], hs.layout.right50)

  hs.spaces.closeMissionControl()
end

M.office = function()
  hs.spaces.openMissionControl()
  -- Get screens
  local leftScreen = nil
  local rightScreen = nil
  local centerScreen = nil
  for _, v in pairs(hs.screen.allScreens()) do
    local x, _ = v:position()

    if x == -1 then
      leftScreen = v
    elseif x == 1 then
      rightScreen = v
    else
      centerScreen = v
    end
  end

  if leftScreen == nil or rightScreen == nil then
    hs.alert.show("Did not detect 3 monitors")
    return
  end

  ensureSpaces(leftScreen, 1)
  ensureSpaces(centerScreen, 1)
  ensureSpaces(rightScreen, 1)

  local leftSpaces = hs.spaces.spacesForScreen(leftScreen:id())
  table.sort(leftSpaces)
  local centerSpaces = hs.spaces.spacesForScreen(centerScreen:id())
  table.sort(centerSpaces)
  local rightSpaces = hs.spaces.spacesForScreen(rightScreen:id())
  table.sort(rightSpaces)

  positionApp("kitty", leftScreen, leftSpaces[1], hs.layout.left50)
  positionApp("Firefox Developer Edition", leftScreen, leftSpaces[1], hs.layout.right50)

  positionApp("Google Chrome", centerScreen, centerSpaces[1], hs.layout.left50)
  positionApp("Discord", centerScreen, centerSpaces[1], hs.layout.right50)

  positionApp("Microsoft Outlook", rightScreen, rightSpaces[1], hs.layout.left50)
  positionApp("Slack", rightScreen, rightSpaces[1], hs.layout.right50)

  hs.spaces.closeMissionControl()
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
