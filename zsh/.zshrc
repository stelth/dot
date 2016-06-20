source "${HOME}/.dotfiles/zgen/zgen.zsh"

zgen prezto '*:*' color 'yes'
zgen prezto editor dot-expansion 'yes'

zgen prezto
zgen prezto environment
zgen prezto helper
zgen prezto spectrum
zgen prezto git
zgen prezto utility
zgen prezto editor
zgen prezto history
zgen prezto directory
zgen prezto archive

zgen load jreese/zsh-titles
zgen load Tarrasch/zsh-autoenv
zgen load zsh-users/zsh-syntax-highlighting
zgen load zsh-users/zsh-history-substring-search
zgen load sharat87/zsh-vim-mode
zgen load psprint/zsh-navigation-tools
zgen load miekg/lean
zgen load tylerreckart/odin

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

if test "${TERM#screen}" != "$TERM"; then
	bindkey '^[[A' history-substring-search-up
	bindkey '^[[B' history-substring-search-down
fi

alias su='su -'

export PATH=$PATH:~/bin
