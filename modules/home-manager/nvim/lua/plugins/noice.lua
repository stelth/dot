local focused = true

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    focused = true
  end,
})
vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    focused = false
  end,
})

require("noice").setup({
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
    lsp_doc_border = true,
  },
  routes = {
    {
      filter = {
        cond = function()
          return not focused
        end,
        view = "notify_send",
        opts = { stop = false },
      },
    },
    {
      filter = {
        event = "msg_show",
        find = "%d+L, %d+B",
      },
      view = "mini",
    },
    {
      filter = {
        warning = true,
        find = "offset_encodings",
      },
      opts = {
        skip = true,
      },
    },
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  lsp_progress = {
    enabled = true,
  },
  commands = {
    all = {
      view = "split",
      opts = { enter = true, format = "details" },
      filter = {},
    },
  },
})
