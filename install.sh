#!/bin/bash

NEOBUNDLE_PATH="vim/.vim/bundle/neobundle.vim"
OHMYZSH_PATH="zsh/.oh-my-zsh"
SYNTAX_HIGHLIGHTING_PATH="zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
BASE16_PATH="zsh/base16-shell"
AUTOSUGGEST_PATH="zsh/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

if [ ! -d "$NEOBUNDLE_PATH" ]; then
	git clone git://github.com/Shougo/neobundle.vim vim/.vim/bundle/neobundle.vim
fi

if [ ! -d "$OHMYZSH_PATH" ]; then
	git clone git://github.com/robbyrussell/oh-my-zsh.git zsh/.oh-my-zsh
fi

if [ ! -d "$SYNTAX_HIGHLIGHTING_PATH" ]; then
	git clone git://github.com/zsh-users/zsh-syntax-highlighting.git zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ ! -d "$BASE16_PATH" ]; then
	git clone git://github.com/chriskempson/base16-shell zsh/base16-shell
fi

if [ ! -d "$AUTOSUGGEST_PATH" ]; then
	git clone git://github.com/tarruda/zsh-autosuggestions zsh/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
