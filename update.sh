#!/bin/zsh

source ~/dotfiles/antigen/antigen.zsh

update_local() {
	echo "Updating local config"
	git pull --rebase > /dev/null
}
update_local

update_vimplug() {
	echo "Updating vim plugins"
	vim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'PlugClean!' -c 'qall'
}
update_vimplug

update_zsh() {
	echo "Updating antigen"
	antigen selfupdate > /dev/null

	echo "Updating antigen plugins"
	antigen update > /dev/null
}
update_zsh

update_brew() {
	hash brew > /dev/null 2>&1 && {
		echo "Updating Home Brew packages"
		brew update
		brew upgrade
		brew cleanup
	}
}
update_brew

update_apt() {
	hash apt > /dev/null 2>&1 && [[ "`echo $UID`" == "0" ]] && {
		echo "Updating apt packages"
		apt-get update
		apt-get upgrade
	}
}
update_apt
