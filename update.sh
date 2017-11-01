#!/bin/zsh

source ~/dotfiles/antigen/antigen.zsh

update_local() {
	echo "Updating local config"
	git pull
}
update_local

update_vimplug() {
	echo "Updating vim plugins"
	vim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'PlugClean!' -c 'qall'
}
update_vimplug

update_zsh() {
	echo "Updating antigen"
	antigen selfupdate

	echo "Updating antigen plugins"
	antigen update

	antigen reset
}
update_zsh

update_brew() {
	hash brew 2>&1 && {
		echo "Updating Home Brew packages"
		brew update
		brew upgrade
		brew cleanup
	}
}
update_brew

update_apt() {
	hash apt 2>&1 && [[ "`echo $UID`" == "0" ]] && {
		echo "Updating apt packages"
		apt-get update -y
		apt-get upgrade -y
		apt-get dist-upgrade -y
		apt autoremove
	}
}
update_apt
