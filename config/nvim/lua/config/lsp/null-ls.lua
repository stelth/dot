local nls = require("null-ls")

local M = {}

function M.setup()
  nls.setup_lspconfig({
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
    }
  })
end

function M.has_formatter(ft)
  local config = require("null-ls.config")
  local formatters = config.generators("NULL_LS_FORMATTING")
  for _, f in ipairs(formatters) do
    if vim.tbl_contains(f.filetypes, ft) then
      return true
    end
  end
end

return M
