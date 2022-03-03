local M = {}

M.setup = function()
  require("neogit").setup({
    kind = "split",
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = { diffview = true },
  })

  vim.keymap.set("n", "<leader>g", "", {
    callback = function()
      require("neogit").open({ kind = "split" })
    end,
    desc = "NeoGit",
  })
end

return M
