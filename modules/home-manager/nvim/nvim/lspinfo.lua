local M = {}

local warn = require("utils").warn
local info = require("utils").info

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
      timeout_ms = 2000,
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

M.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
  format_callback(client, bufnr)
  keymap_callback(client, bufnr)
end

M.config = function(customConfig)
  local default_config = {
    on_attach = M.on_attach,
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = {
      debounce_text_changes = 150,
    },
  }

  return vim.tbl_deep_extend("force", default_config, customConfig)
end

return M
