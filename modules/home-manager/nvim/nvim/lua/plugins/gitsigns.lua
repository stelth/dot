local M = {}

M.setup = function()
  require("gitsigns").setup({
    signs = {
      add = { hl = "GitSignsAdd", text = "▍", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = {
        hl = "GitSignsChange",
        text = "▍",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = "▸",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = "▾",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = "▍",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
  })

  vim.keymap.set("n", "]c", "", {
    callback = function()
      if not vim.api.nvim_win_get_option(0, "diff") then
        require("gitsigns").next_hunk()
      end
    end,
    desc = "Next change",
  })
  vim.keymap.set("n", "]c", "", {
    callback = function()
      if not vim.api.nvim_win_get_option(0, "diff") then
        require("gitsigns").next_hunk()
      end
    end,
    desc = "Next change",
  })
  vim.keymap.set("n", "<leader>ghs", "", {
    callback = require("gitsigns").stage_hunk,
    desc = "Stage hunk",
  })
  vim.keymap.set("n", "<ledaer>ghs", "", {
    callback = require("gitsigns").undo_stage_hunk,
    desc = "Unstage hunk",
  })
  vim.keymap.set("n", "<leader>ghr", "", {
    callback = require("gitsigns").reset_hunk,
    desc = "Reset hunk",
  })
  vim.keymap.set("n", "<leader>ghR", "", {
    callback = require("gitsigns").reset_buffer,
    desc = "Reset buffer",
  })
  vim.keymap.set("n", "<leader>ghp", "", {
    callback = require("gitsigns").preview_hunk,
    desc = "Preview hunk",
  })
  vim.keymap.set("n", "<leader>ghb", "", {
    callback = require("gitsigns").blame_line,
    desc = "Blame line",
  })
  vim.keymap.set("o", "ih", "", {
    callback = require("gitsigns").select_hunk,
    desc = "Select hunk",
  })
  vim.keymap.set("x", "ih", "", {
    callback = require("gitsigns").select_hunk,
    desc = "Select hunk",
  })
end

return M
