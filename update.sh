#!/bin/zsh

update_local() {
	(( $+commands[git] )) && {
		echo "Updating local config"
		git pull 2>&1 | grep -E "up-to-date|up to date" || { ./update.sh; exit $?}
		git push
                git submodule init
                git submodule update --remote --merge
	}
}
update_local || true

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

update_nvim() {
    wget "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage" -O bin/bin/nvim.appimage
    chmod u+x bin/bin/nvim.appimage
    wget "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz" -O bin/bin/nvim-macos.tar.gz
    tar xzvf bin/bin/nvim-macos.tar.gz
}
update_nvim || true

update_pip3_packages() {
	(( $+commands[pip3] )) && {
		echo "Updating pip3 packages"
		pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U --user
	}
}
update_pip3_packages || true
