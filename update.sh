#!/bin/bash

git pull --rebase
vim +NeoBundleInstall! +qall
vim +NeoBundleClean! +qall
cd ~/.dotfiles/zsh/.oh-my-zsh
git pull --rebase
cd ~/.dotfiles/zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git pull --rebase
cd ~/.dotfiles/zsh/base16-shell
git pull --rebase
cd ~/.dotfiles/zsh/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git pull --rebase
