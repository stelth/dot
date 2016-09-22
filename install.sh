#!/bin/zsh

check_environment() {
	echo "Checking environment"

	required_exes=(git make stow)

	for e in ${required_exes[@]}; do
		hash $e || {
			echo "!! Missing: $e"
			exit 1
		}
	done
}
check_environment

install_antigen() {
	echo "Installing antigeh"
	git clone https://github.com/zsh-users/antigen.git
}
install_antigen

symlink_dotfiles() {
	for dst in `cat packages`; do
		nm=${dst##*/}
		echo "Symlinking module: ${nm}"
		stow $nm > /dev/null 2>&1
	done
}
symlink_dotfiles

install_vim() {
	if [ -L ~/.vim ]; then
		echo "Installing Vim Plugins"
		vim -u vim/.vim/plugins.vim +PlugInstall +qall > /dev/null 2>&1
	fi
}
install_vim
