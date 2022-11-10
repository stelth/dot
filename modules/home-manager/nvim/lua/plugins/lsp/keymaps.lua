local M = {}

M.keymap_callback = function(client, bufnr)
  local cap = client.server_capabilities

  local keymap = {
    buffer = bufnr,
    ["<leader>"] = {
      c = {
        name = "+code",
        r = {
          function()
            return ":IncRename " .. vim.fn.expand("<cword>")
          end,
          "Rename",
          cond = cap.renameProvider,
          expr = true,
        },
        a = {
          { vim.lsp.buf.code_action, "Code Action" },
          { vim.lsp.buf.code_action, "Code Action", mode = "v" },
        },
        f = {
          {
            function()
              require("plugins.lsp.formatting").format(vim.api.nvim_get_current_buf())
            end,
            "Format Document",
            cap.documentFormatting,
          },
          {
            function()
              require("plugins.lsp.formatting").format(vim.api.nvim_get_current_buf())
            end,
            "Format Range",
            cap.documentRangeFormatting,
            mode = "v",
          },
        },
        d = { vim.diagnostic.open_float, "Line Diagnostics" },
        l = {
          name = "+lsp",
          i = { vim.cmd.LspInfo, "Lsp Info" },
          a = { vim.lsp.buf.add_workspace_folder, "Add Folder" },
          r = { vim.lsp.buf.remove_workspace_folder, "Remove Folder" },
          l = { "<cmd>lua =vim.lsp.buf.list_workspace_folders()<cr>", "List Folders" },
        },
        x = {
          d = { require("telescope.builtin").diagnostics, "Search Diagnostics" },
        },
      },
    },
    g = {
      name = "+goto",
      d = { require("telescope.builtin").lsp_definitions, "Goto Definition" },
      r = { require("telescope.builtin").lsp_references, "References" },
      D = { require("telescope.builtin").lsp_declarations, "Goto Declaration" },
      s = { vim.lsp.buf.signature_help, "Signature Help" },
      I = { require("telescope.builtin").lsp_implementations, "Goto Implementation" },
      t = { require("telescope.builtin").lsp_type_definitions, "Goto Type Definition" },
    },
    ["K"] = { vim.lsp.buf.hover, "Hover" },
    ["[d"] = { vim.diagnostic.goto_prev, "Next Diagnostic" },
    ["]d"] = { vim.diagnostic.goto_next, "Prev Diagnostic" },
    ["[e"] = {
      function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end,
      "Next Error",
    },
    ["]e"] = {
      function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
      end,
      "Prev Error",
    },
    ["[w"] = {
      function()
        vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARNING })
      end,
      "Next Warning",
    },
    ["]w"] = {
      function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARNING })
      end,
      "Prev Warning",
    },
  }

  require("which-key").register(keymap)
end

return M
