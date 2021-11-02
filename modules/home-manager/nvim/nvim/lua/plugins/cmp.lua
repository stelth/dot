local M = {}

local setup = function()
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
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
        elseif luasnip.jumpable(1) then
          vim.fn.feedkeys(util.t("<Plug>luasnip-jump-next"), "")
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
end

function M.use(use)
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
