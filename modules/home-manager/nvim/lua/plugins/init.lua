require("Comment").setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

local augend = require("dial.augend")

require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.bool,
    augend.semver.alias.semver,
  },
})

vim.keymap.set("n", "<C-i>", require("dial.map").inc_normal(), { noremap = true })
vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })

require("fidget").setup({
  text = {
    spinner = "dots",
  },
  window = {
    relative = "editor",
  },
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  command = "silent! FidgetClose",
})

vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file, { desc = "Add file to harpoon" })
vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon quick menu" })
vim.keymap.set("n", "<leader>tc", require("harpoon.cmd-ui").toggle_quick_menu, {
  desc = "Harpoon command quick menu",
})

local keyToFileId = {
  ["<C-h>"] = 1,
  ["<C-t>"] = 2,
  ["<C-n>"] = 3,
  ["<C-s>"] = 4,
}

for key, fileId in pairs(keyToFileId) do
  vim.keymap.set("n", key, function()
    require("harpoon.ui").nav_file(fileId)
  end, { desc = "Go to harpoon file " .. tostring(fileId) })
end

local keyToTmuxWindowByNumber = {
  ["<C-G>"] = 1,
  ["<C-C>"] = 2,
  ["<C-R>"] = 3,
  ["<C-L>"] = 4,
}

for key, windowNumber in pairs(keyToTmuxWindowByNumber) do
  vim.keymap.set("n", key, function()
    require("harpoon.tmux").gotoTerminal(windowNumber)
  end, { desc = "Go to tmux window " .. tostring(windowNumber) })
end

require("inlay-hints").setup({
  renderer = "inlay-hints/render/eol",
})

require("kanagawa").setup({
  dimInactive = true,
  globalStatus = true,
})

vim.cmd.colorscheme("kanagawa")

require("lualine").setup({})

require("luasnip").config.set_config({
  history = true,
  -- Update more often
  updateEvents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").lazy_load()

local tasks = require("tasks")
local dapui = require("dapui")

tasks.setup({
  dap_open_command = dapui.open,
})

local f_index = 1
for _, task_name in ipairs({ "debug", "run", "test", "build" }) do
  vim.keymap.set({ "", "i" }, string.format("<F%d>", f_index), function()
    tasks.start("auto", task_name)
  end, {})
  vim.keymap.set({ "", "i" }, string.format("<S-F%d>", f_index), function()
    tasks.set_task_param("auto", task_name, "args")
  end, {})
  vim.keymap.set({ "", "i" }, string.format("<A-F%d>", f_index), function()
    tasks.set_task_param("auto", task_name, "env")
  end, {})
  f_index = f_index + 1
end

vim.keymap.set({ "", "i" }, "<F5>", function()
  tasks.set_module_param("auto", "target")
end, {})

vim.keymap.set({ "", "i" }, "<F6>", function()
  tasks.set_module_param("auto", "build")
end, {})

vim.keymap.set({ "", "i" }, "<F7>", function()
  tasks.start("auto", "configure")
end, {})

vim.keymap.set({ "", "i" }, "<F8>", function()
  tasks.start("auto", "clean")
end, {})

vim.keymap.set({ "", "i" }, "<F9>", function()
  tasks.cancel()
  dapui.close()
end, {})

require("noice").setup({})

require("nvim-autopairs").setup({
  enable_check_bracket_line = false,
})

require("nvim-surround").setup({})

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = true },
})

vim.g.matchup_matchparen_offscreen = {
  method = "status_manual",
}

require("plugins.nvim-cmp")
require("plugins.nvim-dap")
require("plugins.nvim-lspconfig")
require("plugins.telescope-nvim")
