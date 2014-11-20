#!/bin/zsh

NEOBUNDLE_PATH="vim/.vim/bundle/neobundle.vim"
ZPREZTO_PATH="zsh/.zprezto"

if [ ! -d "$NEOBUNDLE_PATH" ]; then
	git clone git://github.com/Shougo/neobundle.vim vim/.vim/bundle/neobundle.vim
fi

if [ ! -d "$ZPREZTO_PATH" ]; then
	git clone --recursive https://github.com/sorin-ionescu/prezto.git zsh/.zprezto

	setopt EXTENDED_GLOB
	for rcfile in ./zsh/.zprezto/runcoms/^README.md(.N); do
		cp "$rcfile" "zsh/.${rcfile:t}"
	done
fi
