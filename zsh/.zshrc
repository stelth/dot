source ~/dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh

# oh-my-zsh bundles
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

# third-party bundles
antigen bundle jreese/zsh-titles
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zdharma/history-search-multi-word
antigen bundle sharat87/zsh-vim-mode
antigen bundle psprint/zsh-navigation-tools
antigen bundle willghatch/zsh-saneopt
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zuxfoucault/colored-man-pages_mod
antigen bundle mafredri/zsh-async

antigen theme refined

antigen apply

alias su='su -'

export EDITOR=`which vim`
export SHELL=`which zsh`

export PATH=$PATH:/usr/local/sbin:~/bin

export HOMEBREW_GITHUB_API_TOKEN='e196b520c49ca1cd8b74c96840b83418e999b25f'
