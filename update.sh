#!/bin/bash

git svn rebase
vim +NeoBundleInstall! +qall
cd zsh/.oh-my-zsh
git pull --rebase
cd custom/plugins/zsh-syntax-highlighting
git pull --rebase
