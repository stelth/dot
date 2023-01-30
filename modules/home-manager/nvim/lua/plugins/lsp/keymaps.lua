local M = {}

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
  vim.keymap.set("n", "<leader>tf", require("plugins.lsp.formatting").toggle_formatting, { desc = "Toggle formatting" })
  vim.keymap.set("n", "<leader>cf", function()
    require("plugins.lsp.formatting").format(vim.api.nvim_get_current_buf())
  end, {
    desc = "Format Document",
    buffer = bufnr,
  })
  vim.keymap.set("v", "<leader>cf", function()
    require("plugins.lsp.formatting").format(vim.api.nvim_get_current_buf())
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

return M
