{...}: ''
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      prompt_prefix = " > ",
      color_devicons = true,

      file_previewer = require("telescope.previewers").vim_buffer_cat_new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep_new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist_new,

      layout_strategy = "vertical",
      layout_config = {
        vertical = {
          width = 0.9,
          height = 0.9,
          preview_height = 0.6,
          preview_cutoff = 0,
        },
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("undo")
''
