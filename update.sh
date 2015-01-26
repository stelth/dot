#!/bin/bash

dotfiles=${0%/*}
dotfiles_abs=$(cd $dotfiles && pwd -L)

output_on_error() {
	log=$(mktemp ${0##*/}_log.XXXXXXXX) || exit 1
	trap 'rm "$log"' EXIT INT QUIT TERM

	$* >$log 2>$log || {
		echo -n "ERROR:"
		[[ -f $log ]] && cat $log
	}
}

update_local() {
	echo -n "** Updating local config"
	(
	output_on_error git pull --rebase
	) || exit 1
	echo " ... Done"
}
update_local

update_vimplug() {
	echo -n "** Updating vim plugins"
	(
	output_on_error vim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'PlugClean' -c 'qall'
	) || exit 1
	echo " ... Done"
}
update_vimplug

update_zprezto() {
	echo -n "** Updating Zprezto"
	(
	cd ~/.dotfiles/zsh/.zprezto
	output_on_error git pull && git submodule update --init --recursive
	) || exit 1
	echo " ... Done":
}
update_zprezto
