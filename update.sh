#!/bin/zsh

source ~/.dotfiles/antigen/antigen.zsh
source functions.sh

update_local() {
	ebegin "Updating local config"
	git pull --rebase > /dev/null 2>&1
	eend $?
}
update_local

update_vimplug() {
	ebegin "Updating vim plugins"
	vim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'PlugClean!' -c 'qall' > /dev/null 2>&1
	eend $?
}
update_vimplug

update_zsh() {
	ebegin "Updating antigen"
	antigen selfupdate > /dev/null 2>&1
	eend $?

	ebegin "Updating antigen plugins"
	antigen update > /dev/null 2>&1
	eend $?
}
update_zsh
