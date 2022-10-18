local make_config = require("lsp.config").make_config

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

lspconfig.cmake.setup(make_config({}))

lspconfig.dockerls.setup(make_config({}))

lspconfig.gopls.setup(make_config({
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}))

lspconfig.jsonls.setup(make_config({
  cmd = { "vscode-json-languageserver", "--stdio" },
}))

lspconfig.pyright.setup(make_config({}))

lspconfig.rnix.setup(make_config({}))

require("rust-tools").setup({
  tools = {
    inlay_hints = {
      auto = false,
    },
  },
  server = make_config({}),
})

lspconfig.sumneko_lua.setup(make_config({
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}))

lspconfig.yamlls.setup(make_config({}))

local nls = require("null-ls")
nls.setup(make_config({
  save_after_format = false,
  sources = {
    -- Python
    nls.builtins.formatting.black,
    nls.builtins.formatting.isort,
    nls.builtins.diagnostics.flake8,
    nls.builtins.diagnostics.pylint,

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
    nls.builtins.diagnostics.cpplint,

    -- Lua
    nls.builtins.diagnostics.selene,
    nls.builtins.formatting.stylua,

    -- Rust
    nls.builtins.formatting.rustfmt,

    -- Go
    nls.builtins.diagnostics.golangci_lint,
    nls.builtins.formatting.gofmt,

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
