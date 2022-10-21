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

require("diffview").setup({})
vim.keymap.set("n", "<leader>gd", vim.cmd.DiffviewOpen)

vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file, { desc = "Add file to harpoon" })
vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon quick menu" })

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

require("indent_blankline").setup({
  viewport_buffer = 100,
  char = "▎",
  filetype_exclude = {
    "vimwiki",
    "man",
    "gitmessengerpopup",
    "diagnosticpopup",
    "lspinfo",
    "checkhealth",
    "TelescopePrompt",
    "TelescopeResults",
    "",
  },
  buftype_exclude = { "terminal" },
  space_char_blankline = " ",
  show_foldtext = false,
  strict_tabs = true,
  debug = true,
  disable_with_nolist = true,
  max_indent_increase = 1,
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter_scope = true,
})

require("inlay-hints").setup({
  renderer = "inlay-hints/render/eol",
})

require("nvim-navic").setup({
  icons = {
    File = " ",
    Module = " ",
    Namespace = " ",
    Package = " ",
    Class = " ",
    Method = " ",
    Property = " ",
    Field = " ",
    Constructor = " ",
    Enum = " ",
    Interface = " ",
    Function = " ",
    Variable = " ",
    Constant = " ",
    String = " ",
    Number = " ",
    Boolean = " ",
    Array = " ",
    Object = " ",
    Key = " ",
    Null = " ",
    EnumMember = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
  separator = " ",
  highlight = true,
  depth_limit = 5,
})

local tokyonight = require("tokyonight")
tokyonight.setup({
  style = "moon",
  -- transparent = true,
  -- hide_inactive_statusline = false,
  sidebars = {
    "qf",
    "vista_kind",
    "terminal",
    "packer",
    "spectre_panel",
    "NeogitStatus",
    "help",
    "startuptime",
    "Outline",
  },
  on_colors = function(_) end,
  on_highlights = function(hl, c)
    -- make the current line cursor orange
    hl.CursorLineNr = { fg = c.orange, bold = true }

    -- borderless telescope
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = c.fg_gutter,
      fg = c.orange,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
  end,
})
tokyonight.load()

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

require("noice").setup({
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
  routes = {
    {
      filter = {
        warning = true,
        find = "offset_encodings",
      },
      opts = {
        skip = true,
      },
    },
  },
  lsp_progress = {
    enabled = true,
  },
})

require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua = { "string", "comment" },
  },
})

require("nvim-surround").setup({})

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = true },
})

require("illuminate").configure({ delay = 200 })

vim.keymap.set("n", "]]", function()
  require("illuminate").goto_next_reference(false)
end)
vim.keymap.set("n", "[[", function()
  require("illuminate").goto_prev_reference(false)
end)

vim.g.matchup_matchparen_offscreen = {
  method = "status_manual",
}

require("yanky").setup({
  highlight = {
    timer = 150,
  },
  ring = {
    storage = "sqlite",
  },
})

vim.keymap.set("n", "<leader>P", function()
  require("telescope").extensions.yank_history.yank_history({})
end)

vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
vim.keymap.set("n", "]p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set("n", "[p", "<Plug>(YankyPutBeforeFilter)")

require("zen-mode").setup({
  plugins = {
    kitty = {
      enabled = false,
      font = "+2",
    },
  },
})

require("plugins.lualine")
require("plugins.nvim-cmp")
require("plugins.nvim-dap")
require("plugins.telescope-nvim")
