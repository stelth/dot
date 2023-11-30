local M = {}

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
    -- if autoformat then
    --     vim.lsp.buf.format({
    --         filter = function(client)
    --             local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    --             local nls_available = require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING")
    --
    --             return (#nls_available > 0) == (client.name == "null-ls")
    --         end,
    --         bufnr = bufnr,
    --         timeout_ms = 2000,
    --     })
    -- end
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.format_callback = function(client, bufnr)
    -- if client.supports_method("textDocument/formatting") then
    --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --     vim.api.nvim_create_autocmd("BufWritePre", {
    --         group = augroup,
    --         buffer = bufnr,
    --         callback = function()
    --             if autoformat then
    --                 M.format(bufnr)
    --             end
    --         end,
    --     })
    -- end
end

return M
