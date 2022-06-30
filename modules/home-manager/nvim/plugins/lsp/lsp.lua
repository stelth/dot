-- Automatically update diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

local autoformat = true

local warn = function(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

local info = function(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

local toggle = function()
  autoformat = not autoformat
  if autoformat then
    info("enabled format on save", "Formatting")
  else
    warn("disabled format on save", "Formatting")
  end
end

local nls_has_formatter = function(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")

  return #available > 0
end

local format = function()
  if autoformat then
    vim.lsp.buf.format()
  end
end

local format_callback = function(client, bufnr)
  local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local enable = false

  if nls_has_formatter(ft) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  client.server_capabilities.documentFormatting = enable
  if client.server_capabilities.documentFormatting then
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "<buffer>",
      callback = format,
    })
  end
end

local keymap_callback = function(client, bufnr)
  vim.keymap.set("n", "<leader>cd", "", {
    buffer = bufnr,
    callback = vim.diagnostic.open_float,
    desc = "Line Diagnostics",
  })

  vim.keymap.set("n", "<leader>ca", "", {
    buffer = bufnr,
    callback = vim.lsp.buf.code_action,
    desc = "Code Action",
  })

  vim.keymap.set("n", "<leader>cr", "", {
    buffer = bufnr,
    callback = vim.lsp.buf.rename,
    desc = "Rename",
  })

  vim.keymap.set("n", "<leader>cli", ":LspInfo<CR>", { buffer = bufnr, desc = "Lsp Info" })

  vim.keymap.set("n", "<leader>cla", "", {
    buffer = bufnr,
    callback = vim.lsp.buf.add_workspace_folder,
    desc = "Add folder to workspace",
  })

  vim.keymap.set("n", "<leader>clr", "", {
    buffer = bufnr,
    callback = vim.lsp.buf.remove_workspace_folder,
    desc = "Remove folder from workspace",
  })

  vim.keymap.set("n", "<leader>cll", "", {
    buffer = bufnr,
    callback = function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    desc = "List workspace folders",
  })

  vim.keymap.set("n", "<leader>tf", "", {
    buffer = bufnr,
    callback = toggle,
    desc = "Toggle format on save",
  })

  vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", { buffer = bufnr, desc = "References" })

  vim.keymap.set("n", "gd", "", {
    buffer = bufnr,
    callback = vim.lsp.buf.definition,
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

  vim.keymap.set("n", "gs", "", {
    buffer = bufnr,
    callback = vim.lsp.buf.signature_help,
    desc = "Goto signature help",
  })

  vim.keymap.set("n", "gI", "", {
    buffer = bufnr,
    callback = vim.lsp.buf.implementation,
    desc = "Goto implementation",
  })

  vim.keymap.set("n", "gt", "", {
    buffer = bufnr,
    callback = vim.lsp.buf.type_definition,
    desc = "Goto type definition",
  })

  vim.keymap.set("n", "K", "", {
    buffer = bufnr,
    callback = vim.lsp.buf.hover,
    desc = "Hover",
  })

  vim.keymap.set("n", "[d", "", {
    buffer = bufnr,
    callback = vim.diagnostic.goto_prev,
    desc = "Goto previous diagnostic",
  })

  vim.keymap.set("n", "]d", "", {
    buffer = bufnr,
    callback = vim.diagnostic.goto_next,
    desc = "Goto next diagnostic",
  })

  vim.keymap.set("n", "[e", "", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end,
    desc = "Goto previous error",
  })

  vim.keymap.set("n", "]e", "", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end,
    desc = "Goto next error",
  })

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormatting then
    vim.keymap.set("n", "<leader>cf", "", {
      buffer = bufnr,
      callback = vim.lsp.buf.format,
      desc = "Format document",
    })
  end

  if client.server_capabilities.documentRangeFormatting then
    vim.keymap.set("v", "<leader>cf", "", {
      callback = vim.lsp.buf.range_formatting,
      desc = "Format range",
    })
  end
end

local on_attach = function(client, bufnr)
  format_callback(client, bufnr)
  keymap_callback(client, bufnr)
  require("lsp_signature").on_attach()
end

local config = function(customConfig)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local default_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  local new_config = vim.tbl_deep_extend("force", default_config, customConfig)

  return new_config
end

local luadev = require("lua-dev").setup({})
table.insert(luadev.settings.Lua.workspace.library, "/Users/coxj/.hammerspoon/Spoons/EmmyLua.spoon/annotations")

local lspconfig = require("lspconfig")
lspconfig.bashls.setup(config({}))

lspconfig.cmake.setup(config({}))

lspconfig.gopls.setup(config({}))

lspconfig.jsonls.setup(config({
  cmd = { { "vscode-json-languageserver", "--stdio" } },
}))

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

    -- Rust
    nls.builtins.formatting.rustfmt,

    -- Go
    nls.builtins.diagnostics.golangci_lint,
    nls.builtins.formatting.gofmt,

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
