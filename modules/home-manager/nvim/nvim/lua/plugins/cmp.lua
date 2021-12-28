local M = {}

local setup = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
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
        elseif has_words_before() then
          cmp.complete()
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
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
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
        cmp.config.compare.sort_text,
        cmp.config.compare.offset,
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
    config = setup,
    requires = {
      { "onsails/lspkind-nvim", module = "lspkind" },
      { "L3MON4D3/LuaSnip" },
      { "hrsh7th/cmp-buffer", opt = true },
      { "hrsh7th/cmp-path", opt = true },
      { "saadparwaiz1/cmp_luasnip", opt = true },
      { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp", opt = true },
      { "hrsh7th/cmp-calc", opt = true },
      { "kdheepak/cmp-latex-symbols", opt = true },
      { "hrsh7th/cmp-emoji", opt = true },
      { "f3fora/cmp-spell", opt = true },
      { "ray-x/cmp-treesitter", opt = true },
    },
  })
end

return M
