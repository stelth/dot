source ~/.dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle colored-man-pages
antigen bundle extract
antigen bundle git
antigen bundle gitfast
antigen bundle git-flow
antigen bundle history
antigen bundle systemd
antigen bundle vi-mode

antigen bundle jreese/zsh-titles
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle sharat87/zsh-vim-mode
antigen bundle psprint/zsh-navigation-tools

antigen theme https://gitlab.com/stelth/lambda-mod-zsh-theme lambda-mod

antigen apply

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

if test "${TERM#screen}" != "$TERM"; then
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down
fi

alias su='su -'

export PATH=$PATH:~/bin
