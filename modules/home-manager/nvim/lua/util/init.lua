local M = {}

M.warn = function(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

M.info = function(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

M.toggle = function(option, silent)
  local option_info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[option_info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      M.info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      M.warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

local notifs = {}
local notify = {
  orig = vim.notify,
  lazy = function(...)
    table.insert(notifs, { ... })
  end,
}

local lazy_notify = function()
  local check = vim.loop.new_check()
  local start = vim.loop.hrtime()
  check:start(function()
    if vim.notify ~= notify.lazy then
    elseif (vim.loop.hrtime() - start) / 1e6 > 300 then
      vim.notify = notify.orig
    else
      return
    end
    check:stop()
    vim.schedule(function()
      for _, notif in ipairs(notifs) do
        vim.notify(unpack(notif))
      end
    end)
  end)
end

M.setup_notify = lazy_notify

return M
