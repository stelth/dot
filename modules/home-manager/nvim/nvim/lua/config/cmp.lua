local luasnip = require("luasnip")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local util = require("util")

require("cmp_buffer")
require("cmp_path")
require("cmp_luasnip")
require("cmp_calc")
require("cmp_latex_symbols")
require("cmp_emoji")
require("cmp-spell")
require("cmp_treesitter")

cmp.setup({
  formatting = {
    format = require("lspkind").cmp_format({
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        path = "[Path]",
        luansip = "[Luasnip]",
        nvim_lsp = "[LSP]",
        calc = "[Calc]",
        latex_symbols = "[Latex]",
        emoji = "[Emoji]",
        spell = "[Spell]",
        treesitter = "[Treesitter]",
      },
    }),
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
      if cmp.visible() then
        cmp.select_next_item()
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
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(util.t("<Plug>luasnip-jump-prev"), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
    { name = "spell" },
    { name = "treesitter" },
    { name = "orgmode" },
  },
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
