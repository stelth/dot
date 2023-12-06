{...}: ''
  vim.o.timeoutlen = 300

  -- Make all keymaps silent by default
  local keymap_set = vim.keymap.set
  vim.keymap.set = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    return keymap_set(mode, lhs, rhs, opts)
  end

  vim.keymap.set("n", "Y", "yg$")
  vim.keymap.set("n", "<C-d>", "<C-d>zz")
  vim.keymap.set("n", "<C-u>", "<C-u>zz")
  vim.keymap.set("i", ",", ",<C-g>u")
  vim.keymap.set("i", ".", ".<C-g>u")
  vim.keymap.set("i", ";", ";<C-g>u")
  vim.keymap.set({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true })
  vim.keymap.set({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true })
  vim.keymap.set("n", "<C-k>", vim.cmd.cnext)
  vim.keymap.set("n", "<C-j>", vim.cmd.cprev)
  vim.keymap.set("n", "<BS>", vim.cmd.nohlsearch)
  vim.keymap.set("n", "<leader>xl", vim.cmd.lopen, { desc = "Open Location List" })
  vim.keymap.set("n", "<leader>xq", vim.cmd.copen, { desc = "Open Quickfix List" })
  vim.keymap.set("n", "<leader>k", vim.cmd.lnext)
  vim.keymap.set("n", "<leader>j", vim.cmd.lprev)

  vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
  vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

  vim.keymap.set("n", "<Right>", ":bnext<CR>")
  vim.keymap.set("n", "<Left>", ":bprev<CR>")

  local telescope_builtin = require("telescope.builtin")

  -- Git keymaps
  vim.keymap.set("n", "<leader>gc", telescope_builtin.git_commits, { desc = "Commits" })
  vim.keymap.set("n", "<leader>gb", telescope_builtin.git_branches, { desc = "Branches" })
  vim.keymap.set("n", "<leader>gs", telescope_builtin.git_status, { desc = "Status" })

  -- Help keymaps
  vim.keymap.set("n", "<leader>ht", telescope_builtin.builtin, { desc = "Telescope" })
  vim.keymap.set("n", "<leader>hc", telescope_builtin.commands, { desc = "Commands" })
  vim.keymap.set("n", "<leader>hm", telescope_builtin.help_tags, { desc = "Help Pages" })
  vim.keymap.set("n", "<leader>hm", telescope_builtin.man_pages, { desc = "Man Pages" })
  vim.keymap.set("n", "<leader>hk", telescope_builtin.keymaps, { desc = "Keymaps" })
  vim.keymap.set("n", "<leader>hs", telescope_builtin.highlights, { desc = "Search Highlight Groups" })
  vim.keymap.set("n", "<leader>hl", vim.show_pos, { desc = "Highlight Groups at Cursor" })
  vim.keymap.set("n", "<leader>hf", telescope_builtin.filetypes, { desc = "Filetypes" })
  vim.keymap.set("n", "<leader>ho", telescope_builtin.vim_options, { desc = "Options" })
  vim.keymap.set("n", "<leader>ha", telescope_builtin.autocommands, { desc = "Auto Commands" })

  -- Search keymaps
  vim.keymap.set("n", "<leader>sg", telescope_builtin.live_grep, { desc = "Grep" })
  vim.keymap.set("n", "<leader>sb", telescope_builtin.current_buffer_fuzzy_find, { desc = "Buffer" })
  vim.keymap.set("n", "<leader>sh", telescope_builtin.command_history, { desc = "Command History" })
  vim.keymap.set("n", "<leader>sm", telescope_builtin.marks, { desc = "Marks" })
  vim.keymap.set("n", "<leader>sw", function()
    telescope_builtin.grep_string({ search = vim.fn.expand("<cword>") })
  end, { desc = "Current Word" })
  vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find File" })
  vim.keymap.set("n", "<leader>fr", telescope_builtin.oldfiles, { desc = "Recent Files" })

  -- Switch buffer
  vim.keymap.set("n", "<leader>,", function()
    telescope_builtin.buffers({ show_all_buffers = true })
  end, { desc = "Switch Buffer" })

  -- Quick search
  vim.keymap.set("n", "<leader>/", telescope_builtin.live_grep, { desc = "Search" })
  vim.keymap.set("n", "<leader>:", telescope_builtin.command_history, { desc = "Command History" })

  -- Undo navigation
  vim.keymap.set("n", "<leader>u", require("telescope").extensions.undo.undo)
''
