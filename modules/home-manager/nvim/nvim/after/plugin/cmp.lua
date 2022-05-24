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
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(nil), { "i" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<C-y"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
  }),
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
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))

cmp.setup.cmdline("/", {
  sources = {
    { name = "nvim_lsp_document_symbol" },
    { name = "buffer" },
  },
  mapping = cmp.mapping.preset.cmdline({}),
})
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  mapping = cmp.mapping.preset.cmdline({}),
})
