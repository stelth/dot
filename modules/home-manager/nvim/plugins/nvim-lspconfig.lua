local lspinfo = require("lspinfo")

local luadev = require("lua-dev").setup({})
table.insert(luadev.settings.Lua.workspace.library, "/Users/coxj/.hammerspoon/Spoons/EmmyLua.spoon/annotations")

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

lspconfig.bashls.setup(lspinfo.config({}))

require("clangd_extensions").setup({
  server = lspinfo.config({}),
})

lspconfig.dockerls.setup(lspinfo.config({}))

lspconfig.gopls.setup(lspinfo.config({}))

lspconfig.jsonls.setup(lspinfo.config({
  cmd = { "vscode-json-languageserver", "--stdio" },
}))

if not configs.neocmake then
  configs.neocmake = {
    default_config = {
      cmd = { "neocmakelsp" },
      filetypes = { "cmake" },
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
      end,
      single_file_support = true,
      on_attach = lspinfo.on_attach,
    },
  }
end
lspconfig.neocmake.setup(lspinfo.config({}))

lspconfig.pyright.setup(lspinfo.config({}))

lspconfig.rnix.setup(lspinfo.config({}))

require("rust-tools").setup({
  server = lspinfo.config({}),
})

lspconfig.sumneko_lua.setup(lspinfo.config(luadev))

lspconfig.yamlls.setup(lspinfo.config({}))

local nls = require("null-ls")
nls.setup(lspinfo.config({
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
