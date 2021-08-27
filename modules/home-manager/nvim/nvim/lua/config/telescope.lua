-- local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup({
  extensions = { fzy_native = { override_generic_sorter = false, override_file_sorter = true } },
  defaults = {
    mappings = { i = { ["<c-t>"] = trouble.open_with_trouble } },
    prompt_prefix = " ",
    selection_caret = " ",
    winblend = 10,
    layout_config = {
      width = 0.7,
    },
  },
})

telescope.load_extension("fzy_native")
telescope.load_extension("z")
telescope.load_extension("zoxide")
telescope.load_extension("cmake")

local M = {}

M.project_files = function(opts)
  opts = opts or {}

  if vim.v.shell_error ~= 0 then
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
    return
  end

  require("telescope.builtin").git_files(opts)
end

local util = require("util")

util.nnoremap("<Leader><Space>", M.project_files)
util.nnoremap("<Leader>fd", function()
  require("telescope.builtin").git_files({ cwd = "~/dotfiles" })
end)

util.nnoremap("<leader>fz", function()
  require("telescope").extensions.z.list({ cmd = { vim.o.shell, "-c", "zoxide query -ls" } })
end)

util.nnoremap("<leader>pp", ":lua require'telescope'.extensions.project.project{}<CR>")

return M
