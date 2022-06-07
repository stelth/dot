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
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
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
