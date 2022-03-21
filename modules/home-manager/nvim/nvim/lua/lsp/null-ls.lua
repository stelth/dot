local nls = require("null-ls")

local M = {}

function M.setup()
  nls.setup(require("lsp.util").make_config({
    save_after_format = false,
    sources = {
      -- Python
      nls.builtins.formatting.autopep8,
      nls.builtins.formatting.isort,
      nls.builtins.diagnostics.flake8,

      -- Shell
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.shellharden,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.code_actions.shellcheck,

      -- yaml, markdown
      nls.builtins.formatting.prettier,
      nls.builtins.diagnostics.yamllint,
      nls.builtins.diagnostics.markdownlint,

      -- C/C++
      nls.builtins.formatting.clang_format.with({
        filetypes = { "c", "cpp" },
      }),
      nls.builtins.diagnostics.cppcheck,

      -- Lua
      nls.builtins.diagnostics.selene,
      nls.builtins.formatting.stylua,

      -- Nix
      nls.builtins.formatting.nixfmt,
      nls.builtins.diagnostics.statix,
      nls.builtins.code_actions.statix,

      -- Additional
      nls.builtins.formatting.trim_whitespace.with({
        filetypes = { "*" },
      }),
    },
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".nvim.settings.json", ".git"),
  }))
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")

  return #available > 0
end

return M
