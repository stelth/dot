#!/bin/bash

cd zsh/.oh-my-zsh
git pull --rebase
cd custom/plugins/zsh-syntax-highlighting
git pull --rebase
vim +NeoBundleInstall! +qall
