local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

local plug_map = {
    -- person keymap
    ["n|gb"] = map_cr("BufferLinePick"):with_noremap():with_silent(),
    -- Packer
    ["n|<leader>pu"] = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait(),
    ["n|<leader>pi"] = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait(),
    ["n|<leader>pc"] = map_cr("PackerCompile"):with_silent():with_noremap():with_nowait(),
    -- Lsp mapp work when insertenter and lsp start
    ["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>ll"] = map_cr("LspLog"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>lr"] = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
    ["n|<Leader>cw"] = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
    ["n|<Leader>ct"] = map_args("Template"),
    ["n|<Leader>tf"] = map_cu('DashboardNewFile'):with_noremap():with_silent(),
    -- Plugin nvim-tree
    ["n|<Leader>e"] = map_cr('NvimTreeToggle'):with_noremap():with_silent(),
    ["n|<Leader>F"] = map_cr('NvimTreeFindFile'):with_noremap():with_silent(),
    -- Far.vim
    ["n|<Leader>fz"] = map_cr('Farf'):with_noremap():with_silent(),
    ["v|<Leader>fz"] = map_cr('Farf'):with_noremap():with_silent(),
    -- Plugin Telescope
    ["n|<Leader>bb"] = map_cu('Telescope buffers'):with_noremap():with_silent(),
    ["n|<Leader>fa"] = map_cu('DashboardFindWord'):with_noremap():with_silent(),
    ["n|<Leader>fb"] = map_cu('Telescope file_browser'):with_noremap():with_silent(),
    ["n|<Leader>ff"] = map_cu('DashboardFindFile'):with_noremap():with_silent(),
    ["n|<Leader>fg"] = map_cu('Telescope git_files'):with_noremap():with_silent(),
    ["n|<Leader>fw"] = map_cu('Telescope grep_string'):with_noremap():with_silent(),
    ["n|<Leader>fh"] = map_cu('DashboardFindHistory'):with_noremap():with_silent(),
    ["n|<Leader>fl"] = map_cu('Telescope loclist'):with_noremap():with_silent(),
    ["n|<Leader>fc"] = map_cu('Telescope git_commits'):with_noremap():with_silent(),
    ["n|<Leader>ft"] = map_cu('Telescope help_tags'):with_noremap():with_silent(),
    ["n|<Leader>fd"] = map_cu('Telescope dotfiles path=' .. os.getenv("HOME") ..  '/.dotfiles'):with_noremap():with_silent(),
    -- Plugin acceleratedjk
    ["n|j"] = map_cmd('v:lua.enhance_jk_move("j")'):with_silent():with_expr(),
    ["n|k"] = map_cmd('v:lua.enhance_jk_move("k")'):with_silent():with_expr(),
    -- Plugin QuickRun
    ["n|<Leader>r"] = map_cr("<cmd> lua require'internal.quickrun'.run_command()"):with_noremap():with_silent(),
    -- Plugin vim-operator-surround
    ["n|sa"] = map_cmd("<Plug>(operator-surround-append)"):with_silent(),
    ["n|sd"] = map_cmd("<Plug>(operator-surround-delete)"):with_silent(),
    ["n|sr"] = map_cmd("<Plug>(operator-surround-replace)"):with_silent(),
    -- Plugin hrsh7th/vim-eft
    ["n|;"] = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
    ["x|;"] = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
    ["n|f"] = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["x|f"] = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["o|f"] = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["n|F"] = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    ["x|F"] = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    ["o|F"] = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    -- Plugin vim_niceblock
    ["x|I"] = map_cmd("v:lua.enhance_nice_block('I')"):with_expr(),
    ["x|gI"] = map_cmd("v:lua.enhance_nice_block('gI')"):with_expr(),
    ["x|A"] = map_cmd("v:lua.enhance_nice_block('A')"):with_expr(),
    ["n|<Leader>v"] = map_cu('Vista'):with_noremap():with_silent(),
    -- Plugin nvim-terminal
    ["n|<Leader>tt"] = map_cmd("<cmd>lua require('nvim-terminal').DefaultTerminal:toggle()<CR>"):with_noremap():with_silent(),
    -- Plugin neogit
    ["n|<Leader>ng"] = map_cmd("<cmd>lua require('neogit').open({kind = 'split'})<CR>"):with_noremap():with_silent()
};

bind.nvim_load_mapping(plug_map)
