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

local notify = {
  old = vim.notify,
  lazy = nil,
}

notify.lazy = function(...)
  local args = { ... }
  vim.defer_fn(function()
    if vim.notify == notify.lazy then
      notify.old(unpack(args))
    else
      vim.notify(unpack(args))
    end
  end, 300)
end

M.notify = notify.lazy

return M
