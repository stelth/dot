require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.pairs").setup({})
require("mini.statusline").setup({})

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	matchup = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = false,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
			goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
			goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
			goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
		},
	},
	indent = { enable = true },
})

vim.g.matchup_matchparen_offscreen = {
	method = "status_manual",
}

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
