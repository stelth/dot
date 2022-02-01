local M = {}

local setup = function()
  local gcc = vim.fn.getenv("NIX_GCC")

  if gcc and gcc ~= vim.NIL then
    require("nvim-treesitter.install").compilers = { gcc }
  end

  local ts_configs = require("nvim-treesitter.configs")

  ts_configs.setup({
    ensure_installed = "all",
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = false },
    context_commentstring = { enable = true, enable_autocmd = false },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-n>",
        node_incremental = "<C-n>",
        scope_incremental = "<C-s>",
        node_decremental = "<C-r>",
      },
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
        goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
        goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
        goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
      },
      lsp_interop = {
        enable = true,
        peek_definition_code = {
          ["gD"] = "@function.outer",
        },
      },
    },
  })

  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.jsonc.used_by = "json"

  vim.keymap.set("n", "<leader>hl", ":TSHighlightCapturesUnderCursor<CR>", { desc = "Show highlight" })
end

M.use = function(use)
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = setup,
  })
end

return M
