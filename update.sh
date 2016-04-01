#!/bin/zsh

source "${HOME}/.dotfiles/zgen/zgen.zsh"
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
	ebegin "Updating zgen"
	zgen selfupdate > /dev/null 2>&1
	eend $?

	ebegin "Updating zgen plugins"
	zgen update > /dev/null 2>&1
	eend $?
}
update_zsh
