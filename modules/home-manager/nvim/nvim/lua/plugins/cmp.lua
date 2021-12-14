local M = {}

local setup = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

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
