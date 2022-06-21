local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = " > ",
    color_devicons = true,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = require("telescope.actions").send_to_qflist,
      },
    },
  },
})

vim.keymap.set("n", "<leader>ps", "", {
  callback = builtin.live_grep,
  desc = "Find string",
})

vim.keymap.set("n", "<leader>pf", "", {
  callback = builtin.find_files,
  desc = "Find file",
})

vim.keymap.set("n", "<leader>pw", "", {
  callback = function()
    builtin.grep_string({ search = vim.fn.expand("<cword>") })
  end,
  desc = "Find current word",
})

vim.keymap.set("n", "<leader>pb", "", {
  callback = builtin.buffers,
  desc = "Find buffer",
})

vim.keymap.set("n", "<leader>vh", "", {
  callback = builtin.help_tags,
  desc = "Find help tag",
})

vim.keymap.set("n", "<leader>gb", "", {
  callback = builtin.git_branches,
  desc = "Git branches",
})

vim.keymap.set("n", "<leader>gc", "", {
  callback = builtin.git_commits,
  desc = "Git commits",
})

vim.keymap.set("n", "<leader>gw", "", {
  callback = telescope.extensions.git_worktree.git_worktrees,
  desc = "Git worktrees",
})

vim.keymap.set("n", "<leader>gm", "", {
  callback = telescope.extensions.git_worktree.create_git_worktree,
  desc = "Create git worktree",
})
