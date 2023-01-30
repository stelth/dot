local make_config = require("plugins.lsp.config").make_config

local lspconfig = require("lspconfig")

lspconfig.bashls.setup(make_config({}))

lspconfig.clangd.setup(make_config({
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=bundled",
    "--cross-file-rename",
    "--header-insertion=iwyu",
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
}))

lspconfig.dockerls.setup(make_config({}))

lspconfig.jdtls.setup(make_config({}))

lspconfig.jsonls.setup(make_config({
  cmd = { "vscode-json-languageserver", "--stdio" },
}))

lspconfig.marksman.setup(make_config({}))

lspconfig.neocmake.setup(make_config({}))

lspconfig.pyright.setup(make_config({}))

lspconfig.rnix.setup(make_config({}))

require("neodev").setup({})

lspconfig.sumneko_lua.setup(make_config({
  settings = {
    Lua = {
      callSnippet = "Replace",
    },
  },
}))

lspconfig.yamlls.setup(make_config({}))

local should_enable_cpp = function(utils)
  local kernel_repo_dir = vim.fn.expand("~/dev/repos/linux")

  return utils.root_matches(kernel_repo_dir)
end

local nls = require("null-ls")
nls.setup(make_config({
  should_attach = function(bufnr)
    return vim.api.nvim_buf_line_count(bufnr) < 1000
  end,
  save_after_format = false,
  sources = {
    -- Python
    nls.builtins.formatting.black,
    nls.builtins.formatting.isort,
    nls.builtins.diagnostics.flake8,
    nls.builtins.diagnostics.pylint,

    -- Shell
    nls.builtins.formatting.shfmt.with({
      extra_args = { "-i", "2", "-s" },
    }),
    nls.builtins.formatting.shellharden,
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.code_actions.shellcheck,

    -- yaml, markdown
    nls.builtins.formatting.prettier,
    nls.builtins.diagnostics.yamllint,
    nls.builtins.diagnostics.markdownlint,

    -- C/C++
    nls.builtins.formatting.clang_format.with({
      condition = should_enable_cpp,
      filetypes = { "c", "cpp" },
    }),
    nls.builtins.diagnostics.cppcheck.with({
      condition = should_enable_cpp,
    }),
    nls.builtins.diagnostics.cpplint.with({
      condition = should_enable_cpp,
    }),

    -- Lua
    nls.builtins.formatting.stylua.with({
      extra_args = { "--indent-type", "Spaces" },
    }),

    -- Nix
    nls.builtins.formatting.alejandra,
    nls.builtins.diagnostics.statix,
    nls.builtins.code_actions.statix,

    -- Docker
    nls.builtins.diagnostics.hadolint,

    -- {C}Make
    nls.builtins.formatting.cmake_format,
    nls.builtins.diagnostics.checkmake,

    -- Additional
    nls.builtins.diagnostics.actionlint,
    nls.builtins.diagnostics.gitlint,
    nls.builtins.diagnostics.jsonlint,
    nls.builtins.code_actions.proselint,
    nls.builtins.formatting.taplo,
    nls.builtins.formatting.trim_whitespace.with({
      filetypes = { "*" },
    }),
  },
  root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".nvim.settings.json", ".git"),
}))
