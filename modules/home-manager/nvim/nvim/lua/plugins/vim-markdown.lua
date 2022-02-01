local M = {}

local setup = function()
  -- Use proper syntax highlighting in code blocks
  local fences = {
    "lua",
    -- "vim",
    "json",
    "typescript",
    "javascript",
    "js=javascript",
    "ts=typescript",
    "shell=sh",
    "python",
    "sh",
    "console=sh",
  }
  vim.g.markdown_fenced_languages = fences

  -- plasticboy/vim-markdown
  vim.g.vim_markdown_folding_level = 10
  vim.g.vim_markdown_fenced_languages = fences
  vim.g.vim_markdown_folding_style_pythonic = 1
  vim.g.vim_markdown_conceal_code_blocks = 0
  vim.g.vim_markdown_frontmatter = 1
  vim.g.vim_markdown_strikethrough = 1

  require("util.au").group("md", function(grp)
    grp.FileType = {
      "markdown",
      function()
        vim.keymap.set("n", "gO", "<cmd>Toc<CR>", { desc = "Generate ToC" })
        vim.o.spell = true
      end,
    }
  end)
end

M.use = function(use)
  use({
    "plasticboy/vim-markdown",
    requires = "godlygeek/tabular",
    config = setup,
  })
end

return M
