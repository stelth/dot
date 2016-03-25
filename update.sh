#!/bin/zsh

source "${HOME}/.dotfiles/zgen/zgen.zsh"
source functions.sh

update_local() {
	ebegin "Updating local config"
	git pull --rebase
	eend $?
}
update_local

update_vimplug() {
	ebegin "Updating vim plugins"
	vim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'PlugClean!' -c 'qall'
	eend $?
}
update_vimplug

update_zsh() {
	ebegin "Updating zgen"
	zgen selfupdate
	eend $?

	ebegin "Updating zgen plugins"
	zgen update
	eend $?
}
update_zsh
