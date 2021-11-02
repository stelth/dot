local nls = require("null-ls")

local M = {}

function M.setup()
  nls.config({
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.black,
      nls.builtins.formatting.clang_format.with({
        filetypes = { "c", "cpp" },
      }),
      nls.builtins.formatting.cmake_format,
      nls.builtins.formatting.eslint_d,
      nls.builtins.formatting.fish_indent,
      nls.builtins.formatting.isort,
      nls.builtins.formatting.nixfmt,
      nls.builtins.formatting.prettierd,
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
      nls.builtins.diagnostics.luacheck,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.proselint,
      nls.builtins.diagnostics.pylint,
      nls.builtins.diagnostics.selene,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.vint,
      nls.builtins.diagnostics.write_good,

      nls.builtins.code_actions.gitsigns,
      nls.builtins.code_actions.proselint,

      nls.builtins.hover.dictionary,
    },
  })
end

function M.has_formatter(ft)
  local generators = require("null-ls.generators")
  local formatters = generators.get_available(ft, "NULL_LS_FORMATTING")

  return formatters ~= {}
end

return M
