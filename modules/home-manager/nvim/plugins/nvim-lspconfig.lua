local warn = function(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

local info = function(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

local autoformat = true
local toggle = function()
  autoformat = not autoformat
  if autoformat then
    info("enabled format on save", "Formatting")
  else
    warn("disabled format on save", "Formatting")
  end
end

local lsp_formatting = function(bufnr)
  if autoformat then
    vim.lsp.buf.format({
      filter = function(client)
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
        local nls_available = require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING")

        return (#nls_available > 0) == (client.name == "null-ls")
      end,
      bufnr = bufnr,
    })
  end
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local format_callback = function(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

local keymap_callback = function(_, bufnr)
  vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, {
    buffer = bufnr,
    desc = "Line Diagnostics",
  })

  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {
    buffer = bufnr,
    desc = "Code Action",
  })

  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, {
    buffer = bufnr,
    desc = "Rename",
  })

  vim.keymap.set("n", "<leader>cli", ":LspInfo<CR>", { buffer = bufnr, desc = "Lsp Info" })

  vim.keymap.set("n", "<leader>cla", vim.lsp.buf.add_workspace_folder, {
    buffer = bufnr,
    desc = "Add folder to workspace",
  })

  vim.keymap.set("n", "<leader>clr", vim.lsp.buf.remove_workspace_folder, {
    buffer = bufnr,
    desc = "Remove folder from workspace",
  })

  vim.keymap.set("n", "<leader>cll", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, {
    buffer = bufnr,
    desc = "List workspace folders",
  })

  vim.keymap.set("n", "<leader>tf", toggle, {
    buffer = bufnr,
    desc = "Toggle format on save",
  })

  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {
    buffer = bufnr,
    desc = "References",
  })

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
    buffer = bufnr,
    desc = "Goto definition",
  })

  vim.keymap.set(
    "n",
    "gdv",
    ":vsplit | lua vim.lsp.buf.definition()<CR>",
    { buffer = bufnr, desc = "Goto definition in vsplit" }
  )

  vim.keymap.set(
    "n",
    "gds",
    ":split | lua vim.lsp.buf.definition()<CR>",
    { buffer = bufnr, desc = "Goto definition in split" }
  )

  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, {
    buffer = bufnr,
    desc = "Goto signature help",
  })

  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {
    buffer = bufnr,
    desc = "Goto implementation",
  })

  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {
    buffer = bufnr,
    desc = "Goto type definition",
  })

  vim.keymap.set("n", "K", vim.lsp.buf.hover, {
    buffer = bufnr,
    desc = "Hover",
  })

  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
    buffer = bufnr,
    desc = "Goto previous diagnostic",
  })

  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
    buffer = bufnr,
    desc = "Goto next diagnostic",
  })

  vim.keymap.set("n", "[e", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end, {
    buffer = bufnr,
    desc = "Goto previous error",
  })

  vim.keymap.set("n", "]e", function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
  end, {
    buffer = bufnr,
    desc = "Goto next error",
  })
end

local on_attach = function(client, bufnr)
  format_callback(client, bufnr)
  keymap_callback(client, bufnr)
end

local config = function(customConfig)
  local default_config = {
    on_attach = on_attach,
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    flags = {
      debounce_text_changes = 150,
    },
  }

  local new_config = vim.tbl_deep_extend("force", default_config, customConfig)

  return require("coq").lsp_ensure_capabilities(new_config)
end

local luadev = require("lua-dev").setup({})
table.insert(luadev.settings.Lua.workspace.library, "/Users/coxj/.hammerspoon/Spoons/EmmyLua.spoon/annotations")

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
lspconfig.bashls.setup(config({}))

lspconfig.dockerls.setup(config({}))

lspconfig.gopls.setup(config({}))

lspconfig.jsonls.setup(config({
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
      on_attach = on_attach,
    },
  }
end
lspconfig.neocmake.setup(config({}))

lspconfig.pyright.setup(config({}))

lspconfig.rnix.setup(config({}))

lspconfig.sumneko_lua.setup(config(luadev))

lspconfig.yamlls.setup(config({}))

local jdtls_setup = function()
  require("jdtls").start_or_attach({
    cmd = { "jdt-language-server" },
    on_attach = on_attach,
  })
end

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "java",
  callback = jdtls_setup,
})

require("clangd_extensions").setup({
  server = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
  },
})

require("rust-tools").setup({
  server = {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            "cargo",
            "clippy",
            "--workspace",
            "--message-format=json",
            "--all-targets",
            "--all-features",
          },
        },
      },
    },
  },
})

local nls = require("null-ls")
nls.setup(config({
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
    nls.builtins.diagnostics.deadnix,
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
    nls.builtins.diagnostics.todo_comments,
    nls.builtins.formatting.trim_whitespace.with({
      filetypes = { "*" },
    }),
  },
  root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".nvim.settings.json", ".git"),
}))
