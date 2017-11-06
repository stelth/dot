#!/bin/zsh

uninstall_antigen() {
	echo "Uninstalling antigen"
	[ -d ~/.antigen ] && rm -rf ~/.antigen
}
uninstall_antigen

uninstall_fzf() {
	echo "Uninstalling fzf"
	[ -f ~/.fzf/uninstall ] && ~/.fzf/uninstall
	[ -d ~/.fzf ] && rm -rf ~/.fzf
}
uninstall_fzf

unsymlink_dotfiles() {
	for dst in `cat packages`; do
		nm=${dst##*/}
		echo "Unlinking module: ${nm}"
		stow -D $nm
	done
}
unsymlink_dotfiles

uninstall_dotfiles_dir() {
	echo "Uninstall dotfiles directory"
	cd ~/
	rm -rf ~/dotfiles
}
uninstall_dotfiles_dir
