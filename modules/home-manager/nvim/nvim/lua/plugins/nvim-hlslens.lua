local M = {}

local setup = function()
  vim.api.nvim_set_keymap(
    "n",
    "n",
    "<cmd>execute('normal!' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>",
    {}
  )
  vim.api.nvim_set_keymap(
    "n",
    "N",
    "<cmd>execute('normal!' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>",
    {}
  )
  vim.api.nvim_set_keymap("n", "*", "*<cmd>lua require('hlslens').start()<CR>", {})
  vim.api.nvim_set_keymap("n", "#", "#<cmd>lua require('hlslens').start()<CR>", {})
  vim.api.nvim_set_keymap("n", "g*", "g*<cmd>lua require('hlslens).start()<CR>", {})
  vim.api.nvim_set_keymap("n", "g#", "g#<cmd>lua require('hlslens').start()<CR>", {})
  vim.api.nvim_set_keymap("n", "<BS>", ":noh<CR>", {})
end

M.use = function(use)
  use({
    "kevinhwang91/nvim-hlslens",
    config = setup,
  })
end

return M
