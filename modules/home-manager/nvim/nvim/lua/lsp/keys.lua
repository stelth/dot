local M = {}

M.setup = function(client, bufnr)
  vim.keymap.set("n", "<leader>cd", "", {
    callback = vim.diagnostic.open_float,
    desc = "Line Diagnostics",
  })

  vim.keymap.set("n", "<leader>ca", "", {
    callback = vim.lsp.buf.code_action,
    desc = "Code Action",
  })

  vim.keymap.set("n", "<leader>cr", "", {
    callback = vim.lsp.buf.rename,
    desc = "Rename",
  })

  vim.keymap.set("n", "<leader>cli", ":LspInfo<CR>", { desc = "Lsp Info" })

  vim.keymap.set("n", "<leader>cla", "", {
    callback = vim.lsp.buf.add_workspace_folder,
    desc = "Add folder to workspace",
  })

  vim.keymap.set("n", "<leader>clr", "", {
    callback = vim.lsp.buf.remove_workspace_folder,
    desc = "Remove folder from workspace",
  })

  vim.keymap.set("n", "<leader>cll", "", {
    callback = function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    desc = "List workspace folders",
  })

  vim.keymap.set("n", "<leader>tf", "", {
    callback = require("lsp.formatting").toggle,
    desc = "Toggle format on save",
  })

  vim.keymap.set("n", "<leader>xs", ":Telescope document_diagnostics", { desc = "Document Diagnostics" })

  vim.keymap.set("n", "<leader>xw", ":Telescope lsp_workspace_diagnostics", { desc = "Workspace Diagnostics" })

  vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", { desc = "References" })

  vim.keymap.set("n", "gd", "", {
    callback = vim.lsp.buf.definition,
    desc = "Goto definition",
  })

  vim.keymap.set("n", "gdv", ":vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "Goto definition in vsplit" })

  vim.keymap.set("n", "gds", ":split | lua vim.lsp.buf.definition()<CR>", { desc = "Goto definition in split" })

  vim.keymap.set("n", "gs", "", {
    callback = vim.lsp.buf.signature_help,
    desc = "Goto signature help",
  })

  vim.keymap.set("n", "gI", "", {
    callback = vim.lsp.buf.implementation,
    desc = "Goto implementation",
  })

  vim.keymap.set("n", "gt", "", {
    callback = vim.lsp.buf.type_definition,
    desc = "Goto type definition",
  })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "", {
    callback = vim.lsp.buf.hover,
    desc = "Hover",
  })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "", {
    callback = vim.diagnostic.goto_prev,
    desc = "Goto previous diagnostic",
  })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "", {
    callback = vim.diagnostic.goto_next,
    desc = "Goto next diagnostic",
  })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "[e", "", {
    callback = function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end,
    desc = "Goto previous error",
  })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "]e", "", {
    callback = function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end,
    desc = "Goto next error",
  })

  local trigger_chars = client.resolved_capabilities.signature_help_trigger_characters
  trigger_chars = { "," }
  for _, c in ipairs(trigger_chars) do
    vim.api.nvim_buf_set_keymap(bufnr, "n", c, "", {
      callback = function()
        vim.defer_fn(function()
          pcall(vim.lsp.buf.signature_help)
        end, 0)
        return c
      end,
      desc = "Auto signature help",
      noremap = true,
      silent = true,
      expr = true,
    })
  end

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.keymap.set("n", "<leader>cf", "", {
      callback = vim.lsp.buf.formatting,
      desc = "Format document",
    })
  elseif client.resolved_capabilities.document_range_formatting then
    vim.keymap.set("v", "<leader>cf", "", {
      callback = vim.lsp.buf.range_formatting,
      desc = "Format range",
    })
  end
end

return M
