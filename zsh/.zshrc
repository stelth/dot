source ~/dotfiles/antigen/antigen.zsh
antigen init ~/.antigenrc

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
