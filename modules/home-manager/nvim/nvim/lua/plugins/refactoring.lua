local M = {}

M.setup = function()
  require("refactoring").setup({
    prompt_func_return_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
    },
    prompt_func_param_type = {
      go = true,
      cpp = true,
      c = true,
      java = true,
    },
  })

  vim.keymap.set("v", "<leader>re", "", {
    desc = "Extract Function",
    callback = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "m", true)
      require("refactoring").refactor("Extract Function")
    end,
  })
  vim.keymap.set("v", "<leader>rf", "", {
    desc = "Extract Function to File",
    callback = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "m", true)
      require("refactoring").refactor("Extract Function To File")
    end,
  })
  vim.keymap.set("v", "<leader>rv", "", {
    desc = "Extract Variable",
    callback = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "m", true)
      require("refactoring").refactor("Extract Variable")
    end,
  })
  vim.keymap.set({ "v", "n" }, "<leader>ri", "", {
    desc = "Inline Variable",
    callback = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "m", true)
      require("refactoring").refactor("Inline Variable")
    end,
  })
  vim.keymap.set("n", "<leader>rdf", "", {
    desc = "(DEBUG) Print Function",
    callback = function()
      require("refactoring").debug.printf({ below = true })
    end,
  })
  vim.keymap.set("v", "<leader>rdv", "", {
    desc = "(DEBUG) Print Variable",
    callback = function()
      require("refactoring").debug.print_var({})
    end,
  })
  vim.keymap.set("n", "<leader>rdc", "", {
    desc = "(DEBUG) Cleanup",
    callback = function()
      require("refactoring").debug.cleanup({})
    end,
  })
end

return M
