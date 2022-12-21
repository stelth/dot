M = {}

hs.window.animationDuration = 0
hs.application.enableSpotlightForNameSearches(true)

local spaces = require("hs.spaces")
local wf = hs.window.filter
local eventtap = hs.eventtap
local timer = hs.timer

local maxScreens = 6
local sleep_interval = 1

local logger = hs.logger.new("windowManager")
logger.setLogLevel("debug")

local sleep = function(n)
  os.execute("sleep " .. tonumber(n))
end

local positionApp = function(appTitle, screen, space)
  logger.d("Positioning " .. appTitle)
  if hs.application.get(appTitle) == nil then
    logger.e("Application " .. appTitle .. " not found")
    return
  end

  hs.application.get(appTitle):activate()
  local windows = wf.new(appTitle):setCurrentSpace(nil):getWindows()
  if #windows == 0 then
    logger.w("No windows found for " .. appTitle)
  end
  for _, v in pairs(windows) do
    logger.w("Positioning window " .. v:id() .. " of app " .. appTitle)
    v:moveToScreen(screen)
    logger.d(space)
    spaces.moveWindowToSpace(v:id(), space)
    v:maximize()
    sleep(sleep_interval)
  end
end

M.officeMobile = function()
  -- Get screens
  local screen = hs.screen.mainScreen()
  local allSpaces = hs.spaces.spacesForScreen(screen:id())

  table.sort(allSpaces)

  positionApp("kitty", screen, allSpaces[1])
  positionApp("Google Chrome", screen, allSpaces[1])
  positionApp("Discord", screen, allSpaces[2])
  positionApp("Firefox Developer Edition", screen, allSpaces[3])
  positionApp("Microsoft Outlook", screen, allSpaces[4])
  positionApp("Slack", screen, allSpaces[4])
end

M.office = function()
  -- Get screens
  local leftScreen
  local rightScreen
  local centerScreen
  for _, v in pairs(hs.screen.allScreens()) do
    local x, _ = v:position()
    logger.d(tostring(x))

    if x == -1 then
      leftScreen = v
    elseif x == 1 then
      rightScreen = v
    else
      centerScreen = v
    end
  end

  local leftSpaces = hs.spaces.spacesForScreen(leftScreen:id())
  table.sort(leftSpaces)
  local centerSpaces = hs.spaces.spacesForScreen(centerScreen:id())
  table.sort(centerSpaces)
  local rightSpaces = hs.spaces.spacesForScreen(rightScreen:id())
  table.sort(rightSpaces)

  positionApp("kitty", leftScreen, leftSpaces[1])
  positionApp("Firefox Developer Edition", leftScreen, leftSpaces[1])

  positionApp("Google Chrome", centerScreen, centerSpaces[1])
  positionApp("Discord", centerScreen, centerSpaces[1])

  positionApp("Microsoft Outlook", rightScreen, rightSpaces[1])
  positionApp("Slack", rightScreen, rightSpaces[1])
end

menubar = hs.menubar.new()
menubar:setIcon(hs.image.imageFromName("NSHandCursor"))

if menubar then
  menubar:setMenu({
    { title = "Office", fn = office },
    { title = "Office Mobile", fn = officeMobile },
  })
end

return M
