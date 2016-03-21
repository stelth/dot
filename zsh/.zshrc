source "$HOME/.dotfiles/antigen/antigen.zsh"

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
	cp
	extract
	git
	history
	safe-paste
	systemd
	tmux
	vi-mode
	zsh-users/zsh-completions
	Tarrasch/zsh-autoenv
	miekg/lean
	zsh-users/zsh-syntax-highlighting
	zsh-users/zsh-history-substring-search
EOBUNDLES

antigen apply

zmodload zsh/terminfo

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

if test "${TERM#screen}" != "$TERM"; then
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down
fi

alias su='su -'
