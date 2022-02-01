local M = {}

local setup = function()
  vim.keymap.set(
    "n",
    "n",
    "<cmd>execute('normal!' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>",
    {}
  )
  vim.keymap.set(
    "n",
    "N",
    "<cmd>execute('normal!' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>",
    {}
  )
  vim.keymap.set("n", "*", "*<cmd>lua require('hlslens').start()<CR>", {})
  vim.keymap.set("n", "#", "#<cmd>lua require('hlslens').start()<CR>", {})
  vim.keymap.set("n", "g*", "g*<cmd>lua require('hlslens).start()<CR>", {})
  vim.keymap.set("n", "g#", "g#<cmd>lua require('hlslens').start()<CR>", {})
  vim.keymap.set("n", "<BS>", ":noh<CR>", {})
end

M.use = function(use)
  use({
    "kevinhwang91/nvim-hlslens",
    config = setup,
  })
end

return M
