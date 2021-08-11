local nls = require("null-ls")

local M = {}

function M.setup()
  nls.config({
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.prettierd,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.eslint_d,
      nls.builtins.formatting.clangformat,
      nls.builtins.formatting.shfmt,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.selene,
      nls.builtins.diagnostics.vint,
      nls.builtins.code_actions.gitsigns,
    },
  })
end

function M.has_formatter(ft)
  local generators = require("null-ls.generators")
  local formatters = generators.get_available(ft, "NULL_LS_FORMATTING")

  return formatters ~= {}
end

return M
