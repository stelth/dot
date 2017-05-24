source ~/dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle docker
antigen bundle extract
antigen bundle git
antigen bundle gitfast
antigen bundle git-flow
antigen bundle history
antigen bundle python
antigen bundle tmux
antigen bundle tmuxinator
antigen bundle vi-mode

antigen bundle jreese/zsh-titles
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle sharat87/zsh-vim-mode
antigen bundle psprint/zsh-navigation-tools

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen theme nanotech

antigen apply

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

if test "${TERM#screen}" != "$TERM"; then
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down
fi

alias su='su -'

export EDITOR=`which vim`
export SHELL=`which zsh`

export PATH=$PATH:~/bin

export HOMEBREW_GITHUB_API_TOKEN='e196b520c49ca1cd8b74c96840b83418e999b25f'
