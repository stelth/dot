source ~/.dotfiles/antigen/antigen.zsh

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
	zsh-users/zsh-syntax-highlighting
	history-substring-search
	zsh-users/zsh-completions
	Tarrasch/zsh-autoenv
	miekg/lean
EOBUNDLES
