local cmp = require("cmp")
local luasnip = require("luasnip")
local util = require("util")

require("cmp_buffer")
require("cmp_path")
require("cmp_luasnip")
require("cmp_calc")
require("cmp_latex_symbols")
require("cmp_emoji")

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

      vim_item.menu = ({
        buffer = "[Buffer]",
        path = "[Path]",
        luasnip = "[Luasnip]",
        nvim_lsp = "[LSP]",
        calc = "[Calc]",
        latex_symbols = "[Latex]",
        emoji = "[Emoji]",
      })[entry.source.name]

      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(util.t("<C-n>"), "n")
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(util.t("<Plug>luasnip-expand-or-jump"), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(util.t("<C-p>"), "n")
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(util.t("<Plug>luasnip-jump-prev"), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  sources = {
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "calc" },
    { name = "latex_symbols" },
    { name = "emoji" },
  },
})
