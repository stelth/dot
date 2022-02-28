local util = require("util")

local M = {}

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    util.info("enabled format on save", "Formatting")
  else
    util.warn("disabled format on save", "Formatting")
  end
end

function M.format()
  if M.autoformat then
    vim.lsp.buf.formatting_sync(nil, 2000)
  end
end

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  local nls = require("lsp.null-ls")

  local enable = false
  if nls.has_formatter(ft) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  client.resolved_capabilities.document_formatting = enable
  -- format on save
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_create_autocmd({
      event = "BufWritePre",
      pattern = "<buffer>",
      callback = function()
        require("lsp.formatting").format()
      end,
    })
  end
end

return M
