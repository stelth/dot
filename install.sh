#!/bin/zsh

check_environment() {
	echo "Checking environment"

	required_exes=(git make stow cmake curl go python3 npm pip3)

	for e in ${required_exes[@]}; do
		(( $+commands[$e] )) || {
			echo "!! Missing: $e"
			exit 1
		}
	done
}
check_environment

install_antigen() {
	echo "Installing antigen"
	git clone https://github.com/zsh-users/antigen.git
}
install_antigen

symlink_dotfiles() {
	for dst in `cat packages`; do
		nm=${dst##*/}
		echo "Symlinking module: ${nm}"
		stow $nm
	done
}
symlink_dotfiles

install pip() {
	echo "Installing pip packages"
	pip3 install --user -r pip-packages.txt
}

install_vim() {
	if [ -L ~/.vim ]; then
		echo "Installing Vim Plugins"
		vim -u vim/.vim/plugins.vim +PlugInstall +qall
	fi
}
install_vim
