#!/bin/bash

git pull --rebase
vim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'PlugClean' -c 'qall'
cd ~/.dotfiles/zsh/.zprezto
git pull && git submodule update --init --recursive
