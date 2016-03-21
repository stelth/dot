source "$HOME/.dotfiles/antigen/antigen.zsh"

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
	vi-mode
	safe-paste
	git
	tmux
	cp
	extract
	history
	systemd
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

alias su='su -'
