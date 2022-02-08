local nls = require("null-ls")

local M = {}

function M.setup()
  nls.setup(require("lsp.util").setup({
    save_after_format = false,
    sources = {
      nls.builtins.formatting.black,
      nls.builtins.formatting.brittany,
      nls.builtins.formatting.clang_format.with({
        filetypes = { "c", "cpp" },
      }),
      nls.builtins.formatting.cmake_format,
      nls.builtins.formatting.eslint_d,
      nls.builtins.formatting.fish_indent,
      nls.builtins.formatting.isort,
      nls.builtins.formatting.nixfmt,
      nls.builtins.formatting.prettier,
      nls.builtins.formatting.shellharden,
      nls.builtins.formatting.shfmt,
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.trim_whitespace.with({
        filetypes = { "*" },
      }),
      nls.builtins.formatting.uncrustify.with({
        filetypes = { "c", "cpp" },
      }),

      nls.builtins.diagnostics.cppcheck,
      nls.builtins.diagnostics.flake8,
      nls.builtins.diagnostics.hadolint,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.proselint,
      nls.builtins.diagnostics.pylint,
      nls.builtins.diagnostics.selene,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.vint,
      nls.builtins.diagnostics.write_good,

      nls.builtins.code_actions.proselint,

      nls.builtins.hover.dictionary,
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
