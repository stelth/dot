local ai = require("mini.ai")
require("mini.ai").setup({
  n_lines = 500,
  -- search_method = "cover_or_next",
  custom_textobjects = {
    o = ai.gen_spec.treesitter({
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }, {}),
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
  },
})

local map = function(text_obj, desc)
  for _, side in ipairs({ "left", "right" }) do
    for dir, d in pairs({ prev = "[", next = "]" }) do
      local lhs = d .. (side == "right" and text_obj:upper() or text_obj:lower())
      for _, mode in ipairs({ "n", "x", "o" }) do
        vim.keymap.set(mode, lhs, function()
          ai.move_cursor(side, "a", text_obj, { search_method = dir })
        end, {
          desc = dir .. " " .. desc,
        })
      end
    end
  end
end

map("f", "function")
map("c", "class")
map("o", "block")

require("mini.comment").setup({
  hooks = {
    pre = function()
      require("ts_context_commentstring.internal").update_commentstring()
    end,
  },
})

require("mini.indentscope").setup({
  draw = {
    animation = require("mini.indentscope").gen_animation.none(),
  },
})

require("mini.pairs").setup({})

require("mini.surround").setup({
  mappings = {
    add = "gza", -- Add surrounding in Normal and Visual modes
    delete = "gzd", -- Delete surrounding
    find = "gzf", -- Find surrounding (to the right)
    find_left = "gzF", -- Find surrounding (to the left)
    highlight = "gzh", -- Highlight surrounding
    replace = "gzr", -- Replace surrounding
    update_n_lines = "gzn", -- Update `n_lines`
  },
})
