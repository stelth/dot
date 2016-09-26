#!/bin/zsh

source ~/dotfiles/antigen/antigen.zsh

update_local() {
	echo "Updating local config"
	git pull --rebase > /dev/null 2>&1
}
update_local

update_vimplug() {
	echo "Updating vim plugins"
	vim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'PlugClean!' -c 'qall' > /dev/null 2>&1
}
update_vimplug

update_zsh() {
	echo "Updating antigen"
	antigen selfupdate > /dev/null 2>&1

	echo "Updating antigen plugins"
	antigen update > /dev/null 2>&1
}
update_zsh

update_brew() {
	echo "Updating Home Brew packages"
	brew update
	brew upgrade
}
update_brew
