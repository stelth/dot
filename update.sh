#!/bin/zsh

update_local() {
	(( $+commands[git] )) && {
		echo "Updating local config"
		git pull 2>&1 | grep -E "up-to-date|up to date" || { ./update.sh; exit $?}
		git push
	}
}
update_local || true

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
		brew cleanup -s
		brew doctor
		brew missing
	}
}
update_brew || true

update_apt() {
	[[ "`echo $UID`" == "0" ]] && {
		(( $+commands[apt] )) && {
			(( $+commands[apt-get] )) && {
				echo "Updating apt packages"
				apt-get update -y --allow-unauthenticated
				apt-get upgrade -y -f --allow-unauthenticated
				apt-get dist-upgrade -y -f --allow-unauthenticated
				apt autoremove -y -f
			}
		}
	}
}
update_apt || true

update_pip3_packages() {
	(( $+commands[pip3] )) && {
		echo "Updating pip3 packages"
		pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U --user
	}
}
update_pip3_packages || true

update_nvim() {
	echo "Update neovim plugins"
	nvim -c'call dein#update()' -c 'call dein#install()' -c'qall'
}
update_nvim || true
