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

  M.on_attach = function(client, bufnr)
    M.format_callback(client, bufnr)
    -- require("plugins.lsp.keymaps").keymap_callback(client, bufnr)
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
      "--clang-tidy",
    },
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    },
  }))

  lspconfig.dockerls.setup(M.make_config({
    cmd = { '${lib.getExe pkgs.nodePackages.dockerfile-language-server-nodejs}', '--stdio' },
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
''
