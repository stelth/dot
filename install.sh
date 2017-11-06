#!/bin/zsh

check_environment() {
	echo "Checking environment"

	required_exes=(git make stow cmake curl go python)

	for e in ${required_exes[@]}; do
		hash $e || {
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

install_fzf() {
	echo "Installing fzf"
	git clone --depth 1 https://github.com/junegunn/fzf.git
	yes | fzf/install
}
install_fzf

install_vim() {
	if [ -L ~/.vim ]; then
		echo "Installing Vim Plugins"
		vim -u vim/.vim/plugins.vim +PlugInstall +qall
	fi
}
install_vim
