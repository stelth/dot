local M = {}

local setup = function()
  local cmp = require("cmp")

  require("cmp_buffer")
  require("cmp_path")
  require("cmp_luasnip")
  require("cmp_calc")
  require("cmp_latex_symbols")
  require("cmp_emoji")
  require("cmp-spell")
  require("cmp_treesitter")

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
    formatting = {
      format = require("lspkind").cmp_format(),
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
    },
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.order,
      },
    },
  })

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

M.use = function(use)
  use({
    "hrsh7th/nvim-cmp",
    module = "cmp",
    config = setup,
    after = { "LuaSnip", "nvim-autopairs" },
    requires = {
      { "onsails/lspkind-nvim", module = "lspkind" },
      { "hrsh7th/cmp-buffer", module = "cmp_buffer" },
      { "hrsh7th/cmp-path", module = "cmp_path" },
      { "saadparwaiz1/cmp_luasnip", module = "cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
      { "hrsh7th/cmp-calc", module = "cmp_calc" },
      { "kdheepak/cmp-latex-symbols", module = "cmp_latex_symbols" },
      { "hrsh7th/cmp-emoji", module = "cmp_emoji" },
      { "f3fora/cmp-spell", module = "cmp-spell" },
      { "ray-x/cmp-treesitter", module = "cmp_treesitter" },
    },
  })
end

return M
