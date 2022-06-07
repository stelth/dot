local cmp = require("cmp")

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = require("lspkind").cmp_format({
      with_text = false,
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(nil), { "i" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      local luasnip = require("luasnip")
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      local luasnip = require("luasnip")
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-y"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "calc" },
    { name = "buffer" },
  }),
  experimental = {
    ghost_text = {
      hl_group = "LspCodeLens",
    },
  },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))
