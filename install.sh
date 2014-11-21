#!/bin/zsh

ZPREZTO_PATH="zsh/.zprezto"

vim +PlugInstall +qall

if [ ! -d "$ZPREZTO_PATH" ]; then
	git clone --recursive https://github.com/sorin-ionescu/prezto.git zsh/.zprezto
fi
