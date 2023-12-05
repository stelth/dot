{
  lib,
  pkgs,
  ...
}: ''
  local warn = function(msg, name)
    vim.notify(msg, vim.log.levels.WARN, { title = name })
  end

  local info = function(msg, name)
    vim.notify(msg, vim.log.levels.INFO, { title = name })
  end

  local autoformat = true
  M.toggle_formatting = function()
    autoformat = not autoformat
    if autoformat then
      info("enabled format on save", "Formatting")
    else
      warn("disabled format on save", "Formatting")
    end
  end

  M.format = function(bufnr)
    if autoformat then
      vim.lsp.buf.format({
        filter = function(client)
          local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
          local nls_available = require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING")

          return (#nls_available > 0) == (client.name == "null-ls")
        end,
        bufnr = bufnr,
        timeout_ms = 2000,
      })
    end
  end

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  M.format_callback = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if autoformat then
            M.format(bufnr)
          end
        end,
      })
    end
  end

  M.keymap_callback = function(_, bufnr)
    local telescope_builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>cr", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, {
      desc = "Rename",
      buffer = bufnr,
      expr = true,
    })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set("n", "<leader>tf", M.toggle_formatting, { desc = "Toggle formatting" })
    vim.keymap.set("n", "<leader>cf", function()
      M.format(vim.api.nvim_get_current_buf())
    end, {
      desc = "Format Document",
      buffer = bufnr,
    })
    vim.keymap.set("v", "<leader>cf", function()
      M.format(vim.api.nvim_get_current_buf())
    end, {
      desc = "Format Range",
      buffer = bufnr,
    })
    vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics", buffer = bufnr })
    vim.keymap.set("n", "<leader>cli", vim.cmd.LspInfo, { desc = "Lsp Info", buffer = bufnr })
    vim.keymap.set(
      "n",
      "<leader>cla",
      vim.lsp.buf.add_workspace_folder,
      { desc = "Add Workspace Folder", buffer = bufnr }
    )
    vim.keymap.set(
      "n",
      "<leader>clr",
      vim.lsp.buf.remove_workspace_folder,
      { desc = "Remove Workspace Folder", buffer = bufnr }
    )
    vim.keymap.set(
      "n",
      "<leader>cll",
      "<cmd>lua =vim.lsp.buf.list_workspace_folders()<CR>",
      { desc = "List Folders", buffer = bufnr }
    )
    vim.keymap.set("n", "<leader>cxd", telescope_builtin.diagnostics, { desc = "Search Diagnostics", buffer = bufnr })
    vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, { desc = "Goto Definition", buffer = bufnr })
    vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { desc = "References", buffer = bufnr })
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = bufnr })
    vim.keymap.set("n", "gI", telescope_builtin.lsp_implementations, { desc = "Goto Implementation", buffer = bufnr })
    vim.keymap.set("n", "gt", telescope_builtin.lsp_type_definitions, { desc = "Goto Type Definition", buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Next Diagnostic", buffer = bufnr })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Prev Diagnostic", buffer = bufnr })
    vim.keymap.set("n", "[e", function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Prev Error", buffer = bufnr })
    vim.keymap.set("n", "]e", function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, { desc = "Next Error", buffer = bufnr })
    vim.keymap.set("n", "[w", function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARNING })
    end, { desc = "Prev Warning", buffer = bufnr })
    vim.keymap.set("n", "]w", function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARNING })
    end, { desc = "Next Warning", buffer = bufnr })
  end

  M.on_attach = function(client, bufnr)
    M.format_callback(client, bufnr)
    M.keymap_callback(client, bufnr)
  end

  M.make_config = function(custom_config)
    local default_config = {
      on_attach = M.on_attach,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      flags = {
        debounce_text_changes = 150,
      },
    }

    return vim.tbl_deep_extend("force", default_config, custom_config)
  end

  local lspconfig = require("lspconfig")

  lspconfig.bashls.setup(M.make_config({
    cmd = { '${lib.getExe pkgs.nodePackages.bash-language-server}', 'start' },
  }))

  lspconfig.clangd.setup(M.make_config({
    cmd = {
      "${pkgs.clang-tools}/bin/clangd",
      "--background-index",
    },
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    },
  }))

  lspconfig.jdtls.setup(M.make_config({
    cmd = { '${lib.getExe pkgs.jdt-language-server}' },
  }))

  lspconfig.jsonls.setup(M.make_config({
    cmd = { "${lib.getExe pkgs.nodePackages.vscode-json-languageserver}", "--stdio" },
  }))

  lspconfig.marksman.setup(M.make_config({
    cmd = { '${lib.getExe pkgs.marksman}', '--stdio' }
  }))

  lspconfig.cmake.setup(M.make_config({
    cmd = { '${lib.getExe pkgs.cmake-language-server}' }
  }))

  lspconfig.pyright.setup(M.make_config({
    cmd = { '${lib.getExe pkgs.nodePackages.pyright}', '--stdio' }
  }))

  lspconfig.nil_ls.setup(M.make_config({
    cmd = { '${lib.getExe pkgs.nil}' }
  }))

  require("neodev").setup({})

  lspconfig.lua_ls.setup(M.make_config({
    cmd = { '${lib.getExe pkgs.lua-language-server}' },
    settings = {
      Lua = {
        callSnippet = "Replace",
      },
    },
  }))

  lspconfig.yamlls.setup(M.make_config({
    cmd = { '${lib.getExe pkgs.nodePackages.yaml-language-server}', '--stdio' }
  }))

  local nls = require('null-ls')
  nls.setup({
    debug = true,
    sources = {
      -- code actions
      nls.builtins.code_actions.gitsigns,
      nls.builtins.code_actions.shellcheck,
      nls.builtins.code_actions.statix,

      -- diagnostics
      nls.builtins.diagnostics.clang_check.with({
        command = '${pkgs.clang-tools}/bin/clang-check'
      }),
      nls.builtins.diagnostics.cmake_lint,
      nls.builtins.diagnostics.deadnix,
      nls.builtins.diagnostics.flake8,
      nls.builtins.diagnostics.gitlint,
      nls.builtins.diagnostics.jsonlint,
      nls.builtins.diagnostics.markdownlint,
      nls.builtins.diagnostics.pylint,
      nls.builtins.diagnostics.selene,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.statix,
      nls.builtins.diagnostics.yamllint,

      -- formatting
      nls.builtins.formatting.alejandra,
      nls.builtins.formatting.beautysh,
      nls.builtins.formatting.black,
      nls.builtins.formatting.clang_format.with({
        command = '${pkgs.clang-tools}/bin/clang-format'
      }),
      nls.builtins.formatting.cmake_format,
      nls.builtins.formatting.fixjson,
      nls.builtins.formatting.google_java_format,
      nls.builtins.formatting.markdownlint,
      nls.builtins.formatting.reorder_python_imports,
      nls.builtins.formatting.stylua,
    }
  })
''
