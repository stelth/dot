local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  window = {
    completion = {
      border = "single",
    },
    documentation = {
      border = "single",
    },
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
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
        luasnip.expand_or_jump()
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
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<CR>"] = cmp.mapping.confirm({}),
  },
  sources = cmp.config.sources({
    { name = "buffer" },
    { name = "calc" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "treesitter" },
  }),
  experimental = {
    ghost_text = {
      hl_group = "LspCodeLens",
    },
  },
  formatting = {
    format = function(entry, vim_item)
      local alias = {
        buffer = "Buffer",
        calc = "Calc",
        luasnip = "Snippet",
        nvim_lsp = "LSP",
        path = "Path",
        treesitter = "treesitter",
      }

      if entry.source.name == "nvim_lsp" then
        vim_item.menu = entry.source.source.client.name
      else
        vim_item.menu = alias[entry.source.name] or entry.source.name
      end
      return vim_item
    end,
  },
  sorting = {
    comparators = {
      cmp.config.compare.sort_text,
      cmp.config.compare.offset,
      cmp.config.compare.score,
      cmp.config.compare.order,
    },
  },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
