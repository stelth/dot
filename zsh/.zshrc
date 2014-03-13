export ZSH=$HOME/.oh-my-zsh
export DISABLE_AUTO_UPDATE=true
export ZSH_THEME="steeef"
export OH_MY_ZSH_DEBUG="true"

plugins=(history git svn tmux vi-mode zsh-syntax-highlighting history-substring-search extract)

source $ZSH/oh-my-zsh.sh

unset promptcr

alias c='clear'
alias su='su -'

export DISABLE_AUTO_TITLE="true"

export EDITOR='vim'
export GREP_OPTIONS='--color=auto'
export HISTSIZE=1000
export HISTFILESIZE=1000

zstyle ':completion::complete:*' cache-path ~/.oh-my-zsh.local/cache/

# Customize to your needs...
function dmalloc { eval `command dmalloc -b $*`; }

PATH=$PATH:/opt/cxoffice/bin:~/bin

BASE16_SCHEME="default"
BASE16_SHELL="$HOME/.dotfiles/zsh/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL
