local telescope = require("telescope")
local trouble = require("trouble.providers.telescope")

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
        ["<C-t>"] = trouble.open_with_trouble,
        ["<C-x>"] = false,
        ["<C-q>"] = require("telescope.actions").send_to_qflist,
        ["<C-Down"] = require("telescope.actions").cycle_history_next,
        ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
      },
    },
  },
})

telescope.load_extension("file_browser")
