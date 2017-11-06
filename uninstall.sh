#!/bin/zsh

uninstall_antigen() {
	echo "Uninstalling antigen"
	[ -f ~/.antigen ] && rm -rf ~/.antigen
}
uninstall_antigen

unsymlink_dotfiles() {
	for dst in `cat packages`; do
		nm=${dst##*/}
		echo "Unlinking module: ${nm}"
		stow -D $nm
	done
}
unsymlink_dotfiles

uninstall_fzf() {
	echo "Uninstalling fzf"
	[ -f ~/.fzf/uninstall ] && ~/.fzf/uninstall
}
uninstall_fzf

uninstall_dotfiles_dir() {
	echo "Uninstall dotfiles directory"
	cd ~/
	rm -rf ~/dotfiles
}
