local global = require("global")

local config = {
	compile_path = global.data_dir .. "/plugin/packer_compiled.vim",
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
	profile = {
		enable = true,
		threshold = 1,
	},
}

return require("packer").startup({
	function(use)
		-- Packer can manage itself as an optional plugin
		use({ "wbthomason/packer.nvim", opt = true })

		-- LSP
		use({
			"neovim/nvim-lspconfig",
			opt = true,
			event = "BufReadPre",
			wants = { "null-ls.nvim", "lsp_signature.nvim" },
			config = function()
				require("config.lsp")
			end,
			requires = {
				"jose-elias-alvarez/null-ls.nvim",
				"ray-x/lsp_signature.nvim",
			},
		})

		-- DAP
		use({
			"mfussenegger/nvim-dap",
			opt = true,
			event = "BufReadPre",
			wants = { "nvim-dap-python" },
			config = function()
				require("config.dap")
			end,
			requires = {
				"mfussenegger/nvim-dap-python",
				"theHamsta/nvim-dap-virtual-text",
			},
		})

		use({
			"hrsh7th/nvim-compe",
			event = "InsertEnter",
			opt = true,
			config = function()
				require("config.compe")
			end,
			wants = { "vim-vsnip", "vim-vsnip-integ", "friendly-snippets" },
			requires = {
				{
					"hrsh7th/vim-vsnip",
					config = function()
						require("config.snippets")
					end,
				},
				"hrsh7th/vim-vsnip-integ",
				"rafamadriz/friendly-snippets",
				{
					"windwp/nvim-autopairs",
					config = function()
						require("config.autopairs")
					end,
				},
			},
		})

		use({
			"simrat39/symbols-outline.nvim",
			cmd = { "SymbolsOutline" },
		})

		use({
			"b3nj5m1n/kommentary",
			opt = true,
			wants = "nvim-ts-context-commentstring",
			keys = { "gc", "gcc" },
			config = function()
				require("config.comments")
			end,
			requires = "JoosepAlviste/nvim-ts-context-commentstring",
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			requires = { "nvim-treesitter/playground", "nvim-treesitter/nvim-treesitter-textobjects" },
			config = function()
				require("config.treesitter")
			end,
		})

		-- Theme: Color schemes
		use({
			"shaunsingh/nord.nvim",
			"shaunsingh/moonlight.nvim",
			"joshdick/onedark.vim",
			"marko-cerovac/material.nvim",
			"sainnhe/sonokai",
			"morhetz/gruvbox",
			"folke/tokyonight.nvim",
		})

		-- Theme: icons
		use({
			"kyazdani42/nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({ default = true })
			end,
		})

		-- Dashboard
		use({
			"glepnir/dashboard-nvim",
			config = function()
				require("config.dashboard")
			end,
		})

		use({
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
		})

		use({
			"kyazdani42/nvim-tree.lua",
			cmd = { "NvimTreeToggle", "NvimTreeOpen" },
			config = function()
				require("config.tree")
			end,
		})

		use({
			"nvim-telescope/telescope.nvim",
			opt = true,
			config = function()
				require("config.telescope")
			end,
			cmd = { "Telescope" },
			keys = { "<leader><space>", "<leader>fz", "<leader>pp" },
			wants = {
				"plenary.nvim",
				"popup.nvim",
				"telescope-z.nvim",
				"telescope-fzy-native.nvim",
				"telescope-project.nvim",
				"trouble.nvim",
				"telescope-symbols.nvim",
				"telescope-dap.nvim",
				"telescope-zoxide",
			},
			requires = {
				"nvim-telescope/telescope-z.nvim",
				"nvim-telescope/telescope-project.nvim",
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-symbols.nvim",
				"nvim-telescope/telescope-fzy-native.nvim",
				"nvim-telescope/telescope-dap.nvim",
				"jvgrootveld/telescope-zoxide",
			},
		})

		use({
			"Shatur/neovim-cmake",
			opt = true,
			cmd = { "CMake" },
			wants = { "telescope.nvim", "asyncrun.vim", "nvim-dap" },
			requires = {
				"skywind3000/asyncrun.vim",
			},
			config = function()
				require("config.neovim-cmake")
			end,
		})

		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			branch = "lua",
			config = function()
				require("config.blankline")
			end,
		})

		-- Tabs
		use({
			"akinsho/nvim-bufferline.lua",
			event = "BufReadPre",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("config.bufferline")
			end,
		})

		-- Terminal
		use({
			"akinsho/nvim-toggleterm.lua",
			keys = "<M-`>",
			config = function()
				require("config.terminal")
			end,
		})

		-- Smooth scrolling
		use({
			"karb94/neoscroll.nvim",
			config = function()
				require("config.scroll")
			end,
		})

		use({
			"edluffy/specs.nvim",
			config = function()
				require("config.specs")
			end,
		})

		-- Git gutter
		use({
			"lewis6991/gitsigns.nvim",
			event = "BufReadPre",
			wants = "plenary.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("config.gitsigns")
			end,
		})

		-- Status line
		use({
			"hoob3rt/lualine.nvim",
			event = "VimEnter",
			config = function()
				require("config.lualine")
			end,
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		use({
			"npxbr/glow.nvim",
			cmd = "Glow",
		})

		use({
			"plasticboy/vim-markdown",
			opt = true,
			requires = "godlygeek/tabular",
			ft = "markdown",
			config = function()
				require("config.markdown")
			end,
		})

		use({
			"ggandor/lightspeed.nvim",
			keys = { "s", "S", "f", "F", "t", "T" },
			config = function()
				require("config.lightspeed")
			end,
		})

		use({
			"folke/trouble.nvim",
			event = "BufReadPre",
			requires = "kyazdani42/nvim-web-devicons",
			cmd = { "TroubleToggle", "Trouble" },
			config = function()
				require("trouble").setup({ auto_open = false })
			end,
		})

		use({
			"tpope/vim-obsession",
			setup = function()
				require("config.session")
			end,
		})

		use({
			"tweekmonster/startuptime.vim",
			cmd = "StartupTime",
		})

		use({
			"mbbill/undotree",
			cmd = "UndotreeToggle",
		})

		use({
			"kevinhwang91/nvim-hlslens",
		})

		use({
			"folke/lsp-colors.nvim",
		})

		use({
			"folke/zen-mode.nvim",
			cmd = "ZenMode",
			config = function()
				require("zen-mode").setup({
					plugins = { gitsigns = true, tmux = true, kitty = { enabled = false, font = "+2" } },
				})
			end,
		})

		use({
			"folke/lua-dev.nvim",
		})

		use({
			"folke/todo-comments.nvim",
			config = function()
				require("config.todo")
			end,
		})

		use({
			"folke/which-key.nvim",
			config = function()
				require("config.keys")
			end,
		})

		use({
			"sindrets/diffview.nvim",
			cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
			config = function()
				require("config.diffview")
			end,
		})

		use({
			"RRethy/vim-illuminate",
			event = "BufReadPre",
			config = function()
				vim.g.illuminate_delay = 1000
			end,
		})

		use({
			"aserowy/tmux.nvim",
			config = function()
				require("config.tmux")
			end,
		})

		use({
			"wellle/targets.vim",
		})

		use({
			"DanilaMihailov/vim-tips-wiki",
		})

		use({
			"tpope/vim-unimpaired",
		})
	end,
	config = config,
})
