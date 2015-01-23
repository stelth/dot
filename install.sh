#!/bin/bash

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

symlink_dotfiles() {
	for dst in `cat packages`; do
		nm=${dst##*/}
		echo -n "** Symlinking module: ${nm}"
		output_on_error stow $nm
		echo " ... Done"
	done
}
symlink_dotfiles

clone_git_repo() {
	path=$1
	repo=$2

	if [[ ! -d "$path" ]]; then
		echo -n "** Clone git repo: $path"
		(
		dir="${path%/*}"
		mkdir -p dir
		cd $dir
		output_on_error git clone  --recursive ${repo} ${path##*/}
		)

		echo " ... Done"
	fi
}

clone_git_repo "zsh/.zprezto" "https://github.com/sorin-ionescu/prezto.git"
clone_git_repo "emacs/.emacs.d/extern/cask" "https://github.com/cask/cask"

install_vim() {
	echo "** Installing Vim Plugins"
	output_on_error vim +PlugInstall +qall
	echo " ... Done"
}
install_vim

build_lib() {
	echo -n "** Building: $1"

	(
	cd $1
	output_on_error make
	) || exit 1
	echo " ... Done"

}

build_lib "emacs/.emacs.d/extern/cedet"
build_lib "emacs/.emacs.d/extern/cedet/contrib"

run_cask() {
	echo -n "** Updating cask"
	(
	cd "emacs/.emacs.d"
	output_on_error extern/cask/bin/cask upgrade
	) || exit 1
	echo " ... Done"

	echo -n "** Installing cask packages"
	(
	cd "emacs/.emacs.d"
	output_on_error extern/cask/bin/cask install
	) || exit 1
	echo " ... Done"
}

run_cask
