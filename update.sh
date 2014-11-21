#!/bin/bash

git pull --rebase
vim +PlugUpgrade +qall
vim +PlugUpdate +qall
vim +PlugClean! +qall
cd ~/.dotfiles/zsh/.zprezto
git pull && git submodule update --init --recursive
