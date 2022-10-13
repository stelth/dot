local make_config = require("lsp.config").make_config

local lspconfig = require("lspconfig")

lspconfig.bashls.setup(make_config({}))

require("clangd_extensions").setup({
  server = make_config({}),
})

lspconfig.cmake.setup(make_config({}))

lspconfig.dockerls.setup(make_config({}))

lspconfig.gopls.setup(make_config({}))

lspconfig.jsonls.setup(make_config({
  cmd = { "vscode-json-languageserver", "--stdio" },
}))

lspconfig.neocmake.setup(make_config({}))

lspconfig.pyright.setup(make_config({}))

lspconfig.rnix.setup(make_config({}))

require("rust-tools").setup({
  server = make_config({}),
})

local luadev = require("lua-dev").setup({})
table.insert(luadev.settings.Lua.workspace.library, "/Users/coxj/.hammerspoon/Spoons/EmmyLua.spoon/annotations")
lspconfig.sumneko_lua.setup(make_config(luadev))

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
