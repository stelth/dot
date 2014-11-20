#!/bin/bash

git pull --rebase
vim +NeoBundleInstall! +qall
vim +NeoBundleClean! +qall
cd ~/.dotfiles/zsh/.zprezto
git pull && git submodule update --init --recursive
