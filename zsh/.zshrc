source ~/dotfiles/antigen/antigen.zsh

export PATH=/usr/local/bin:/usr/local/sbin:~/bin:~/node_modules/.bin:$PATH

antigen use oh-my-zsh

# oh-my-zsh bundles
antigen bundle docker
antigen bundle extract
antigen bundle fasd
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
antigen bundle sharat87/zsh-vim-mode
antigen bundle psprint/zsh-navigation-tools
antigen bundle willghatch/zsh-saneopt
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zuxfoucault/colored-man-pages_mod
antigen bundle mafredri/zsh-async
antigen bundle arzzen/calc.plugin.zsh

antigen theme steeef

antigen apply

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold'

alias su='su -'

export EDITOR=`which vim`
export SHELL=`which zsh`

if [ "$(uname 2> /dev/null)" == "Linux" ]; then
	export PATH=$PATH:/usr/lib/llvm-6.0/bin
fi

export HOMEBREW_GITHUB_API_TOKEN='e196b520c49ca1cd8b74c96840b83418e999b25f'

rfetch() {
	NSLASH="$(echo "${@: -1}" | perl -pe 's|.*://[^/]+(.*?)/?$|\1|' | grep -o / | wc -l)"
	NCUT=$((NSLASH > 0 ? NSLASH-1 : 0))

	wget -r -N -nH -l 10 --random-wait --user-agent=Mozilla/5.0 --cut-dirs=${NCUT} --no-parent "$@"
}

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
