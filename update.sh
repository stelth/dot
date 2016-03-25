#!/bin/zsh

source functions.sh
source "${HOME}/.dotfiles/zgen/zgen.zsh"

dotfiles=${0%/*}
dotfiles_abs=$(cd $dotfiles && pwd -L)

output_on_error() {
	log=$(mktemp ${0##*/}_log.XXXXXXXX) || exit 1
	trap 'rm "$log"' EXIT INT QUIT TERM

	$* >$log 2>$log || {
		[[ -f $log ]] && cat $log
	}
}

update_local() {
	ebegin "Updating local config"
	(
	output_on_error git pull --rebase
	eend $?
	) || exit 1
}
update_local

update_vimplug() {
	ebegin "Updating vim plugins"
	(
	output_on_error vim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'PlugClean!' -c 'qall'
	eend $?
	) || exit 1
}
update_vimplug

update_zsh() {
	(
	ebegin "Updating zgen"
	output_on_error zgen selfupdate
	eend $?

	ebegin "Updating zgen plugins"
	output_on_error zgen update
	eend $?
	) || exit 1
}
update_zsh
