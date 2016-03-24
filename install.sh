#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

shopt -s nocasematch nullglob

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

check_environment() {
	echo "** Checking environment"

	required_exes=(git make stow)

	for e in ${required_exes[@]}; do
		hash $e || {
			echo "!! Missing: $e"
			exit 1
		}
	done
}
check_environment

install_zgen() {
	echo -n "** Installing zgen"
	(
	output_on_error git clone https://github.com/tarjoilija/zgen.git zgen
	) || exit 1
	echo " ... Done"
}
install_zgen

symlink_dotfiles() {
	for dst in `cat packages`; do
		nm=${dst##*/}
		echo -n "** Symlinking module: ${nm}"
		output_on_error stow $nm
		echo " ... Done"
	done
}
symlink_dotfiles

install_vim() {
	if [ -L ~/.vim ]; then
		echo "** Installing Vim Plugins"
		output_on_error vim -u vim/.vim/plugins.vim +PlugInstall +qall
		echo " ... Done"
	fi
}
install_vim
