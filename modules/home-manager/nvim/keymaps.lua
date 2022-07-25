local warn = function(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

local info = function(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

local toggle = function(option, silent)
  local option_info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[option_info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

-- ----------------------------------
-- Key maps
-- ----------------------------------

vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", '"_dp')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y"')
vim.keymap.set("n", "<leader>Y", '"+Y"')

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d"')

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u", {})
vim.keymap.set("i", ".", ".<c-g>u", {})
vim.keymap.set("i", ";", ";<c-g>u", {})

-- better indenting
vim.keymap.set("v", "<", "<gv", {})
vim.keymap.set("v", ">", ">gv", {})

-- Toggle
vim.keymap.set("n", "<leader>ts", "", {
  callback = function()
    toggle("spell")
  end,
  desc = "Toggle Spell",
})
vim.keymap.set("n", "<leader>tw", "", {
  callback = function()
    toggle("wrap")
  end,
  desc = "Toggle Wrap",
})
vim.keymap.set("n", "<leader>tn", "", {
  callback = function()
    toggle("relativenumber", true)
    toggle("number")
  end,
  desc = "Toggle Line Numbers",
})

vim.keymap.set("n", "<C-f>", ":silent !tmux neww tmux-sessionizer<CR>", {
  silent = true,
  desc = "New tmux-sessionizer window",
})

vim.keymap.set("n", "<C-k>", "", {
  callback = vim.cmd.cnext,
})
vim.keymap.set("n", "<C-j>", "", {
  callback = vim.cmd.cprev,
})
vim.keymap.set("n", "<leader>k", "", {
  callback = vim.cmd.lnext,
})
vim.keymap.set("n", "<leader>j", "", {
  callback = vim.cmd.lprev,
})
