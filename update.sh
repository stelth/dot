#!/bin/zsh

source ~/dotfiles/antigen/antigen.zsh

update_local() {
	echo "Updating local config"
	git pull 2>&1 | grep -E "up-to-date|up to date" || ./update.sh
	git push
}
update_local || true

update_vimplug() {
	echo "Updating vim plugins"
	vim -c 'PlugInstall' -c 'PlugUpgrade' -c 'PlugUpdate' -c 'PlugClean!' -c 'qall'
}
update_vimplug || true

update_zsh() {
	echo "Updating antigen"
	antigen selfupdate

	echo "Updating antigen plugins"
	antigen update

	antigen reset
}
update_zsh || true

update_brew() {
	hash brew 2>&1 && {
		echo "Updating Home Brew packages"
		brew update
		brew upgrade
		brew cleanup
	}
}
update_brew || true

update_apt() {
	hash apt 2>&1 && [[ "`echo $UID`" == "0" ]] && {
		echo "Updating apt packages"
		apt-get update -y
		apt-get upgrade -y
		apt-get dist-upgrade -y
		apt autoremove -y
	}
}
update_apt || true
