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
		y	(( $+commands[apt-get] )) && {
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
    wget "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage" -O nvim/nvim.appimage
    chmod u+x nvim/nvim.appimage
    wget "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz" -O nvim/nvim-macos.tar.gz
    tar xvf nvim/nvim-macos.tar.gz --strip-components=2 -C nvim nvim-osx64/bin/nvim
    rm nvim/nvim-macos.tar.gz
}
update_nvim || true

update_ghq() {
    wget https://github.com/x-motemen/ghq/releases/latest/download/ghq_linux_amd64.zip
    unzip -j "ghq_linux_amd64.zip" "ghq_linux_amd64/ghq" -d "bin/linux"
    rm ghq_linux_amd64.zip
    wget https://github.com/x-motemen/ghq/releases/latest/download/ghq_darwin_amd64.zip
    unzip -j "ghq_darwin_amd64.zip" "ghq_darwin_amd64/ghq" -d "bin/darwin"
    rm ghq_darwin_amd64.zip
}

update_pip3_packages() {
	(( $+commands[pip3] )) && {
		echo "Updating pip3 packages"
		pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U --user
	}
}
update_pip3_packages || true
