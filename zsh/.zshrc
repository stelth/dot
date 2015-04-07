#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [ ! -f /tmp/tabbed.xid ]; then
	tabbed -d > /tmp/tabbed.xid
fi

# Customize to your needs...
alias c='clear'
alias su='su -'
alias em="/usr/bin/emacs -nw"
