#!/bin/zsh

source functions.sh

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
	ebegin "Checking environment"

	required_exes=(git make stow)

	for e in ${required_exes[@]}; do
		hash $e || {
			echo "!! Missing: $e"
			eend 1
			exit 1
		}
	done
	eend 0
}
check_environment

install_zgen() {
	ebegin "Installing zgen"
	(
	output_on_error git clone https://github.com/tarjoilija/zgen.git zgen
	eend $?
	) || exit 1
}
install_zgen

symlink_dotfiles() {
	for dst in `cat packages`; do
		nm=${dst##*/}
		ebegin "Symlinking module: ${nm}"
		output_on_error stow $nm
		eend $?
	done
}
symlink_dotfiles

install_vim() {
	if [ -L ~/.vim ]; then
		ebegin "Installing Vim Plugins"
		output_on_error vim -u vim/.vim/plugins.vim +PlugInstall +qall
		eend $?
	fi
}
install_vim
