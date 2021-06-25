local module = { state = {} }
local config = require("config")

module.toggle = function(win)
  local screenFrame = win:screen():frame()

  screenFrame = hs.geometry.new({
    screenFrame.x + config.monocle.margin[1],
    screenFrame.y + config.topbar + config.monocle.margin[2],
    screenFrame.w - 2 * config.monocle.margin[1],
    screenFrame.h - config.topbar * 2 * config.monocle.margin[2],
  })

  if win:frame():equals(screenFrame) then
    if module.state[win:id()] ~= nil then
      win:setFrame(module.state[win:id()])
      module.state[win:id()] = nil
    end
  else
    module.state[win:id()] = win:frame()
    win:setFrame(screenFrame)
  end
end

return module
