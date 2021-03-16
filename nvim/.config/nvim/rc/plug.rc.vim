" vim-plug setup
let vimplug_path=expand('~/.config/nvim/autoload/plug.vim')
let curl_path=expand('curl')

if !filereadable(vimplug_path)
  if !executable(curl_path)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug"
  echo ""
  silent exec "!"curl_path" -fLo " . shellescape(vimplug_path) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

let g:inline_vimrcs = ['options.rc.vim', 'mappings.rc.vim']
if has('nvim')
	call add(g:inline_vimrcs, 'neovim.rc.vim')
elseif has('guirunning')
	call add(g:inline_vimrcs, 'gui.rc.vim')
endif
if IsWindows()
	call add(g:inline_vimrcs, 'windows.rc.vim')
else
	call add(g:inline_vimrcs, 'unix.rc.vim')
endif
call map(g:inline_vimrcs, "resolve(expand('~/.config/nvim/rc/' . v:val))")

for rc in g:inline_vimrcs
	execute 'source' rc
endfor

call plug#begin('~/.config/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'thinca/vim-ft-diff_fold'
Plug 'kana/vim-operator-user'
Plug 'chrisbra/vim-zsh'
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/vinarise.vim'

Plug 'rhysd/vim-operator-surround'
Plug 'mattn/vim-maketable'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'

Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'

call plug#end()

for f in split(glob('~/.config/nvim/rc/plugins/*.rc.vim'), '\n')
	execute 'source' f
endfor
