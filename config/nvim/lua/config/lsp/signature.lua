local M = {}

function M.setup()
  require("lsp_signature").on_attach({
    bind = true,
    floating_window = true,
    fix_pos = true,
    hi_parameter = "Search",
    handler_opts = {
      border = "single",
    },
  })
end

return M
