#!/bin/zsh

update_local() {
	(( $+commands[git] )) && {
		echo "Updating local config"
		git pull 2>&1 | grep -E "up-to-date|up to date" || ./update.sh
		git push
	}
}
update_local || true

update_vimplug() {
	(( $+commands[vim] )) && {
		echo "Updating vim plugins"
		vim -c 'PlugInstall' -c 'PlugUpgrade' -c 'PlugUpdate' -c 'PlugClean!' -c 'qall'
	}
}
update_vimplug || true

update_zsh() {
	source ~/dotfiles/antigen/antigen.zsh

	echo "Updating antigen"
	antigen selfupdate

	echo "Updating antigen plugins"
	antigen update

	antigen reset
}
update_zsh || true

update_brew() {
	(( $+commands[brew] )) && {
		echo "Updating Home Brew packages"
		brew update
		brew upgrade
		brew cleanup
	}
}
update_brew || true

update_apt() {
	[[ "`echo $UID`" == "0" ]] && {
		(( $+commands[apt] )) && {
			(( $+commands[apt-get] )) && {
				echo "Updating apt packages"
				apt-get update -y
				apt-get upgrade -y
				apt-get dist-upgrade -y
				apt autoremove -y
			}
		}
	}
}
update_apt || true
