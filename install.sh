#!/bin/zsh

source functions.sh

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

install_antigen() {
	ebegin "Installing antigeh"
	git clone https://github.com/zsh-users/antigen.git
	eend $?
}
install_antigen

symlink_dotfiles() {
	for dst in `cat packages`; do
		nm=${dst##*/}
		ebegin "Symlinking module: ${nm}"
		stow $nm > /dev/null 2>&1
		eend $?
	done
}
symlink_dotfiles

install_vim() {
	if [ -L ~/.vim ]; then
		ebegin "Installing Vim Plugins"
		vim -u vim/.vim/plugins.vim +PlugInstall +qall > /dev/null 2>&1
		eend $?
	fi
}
install_vim
