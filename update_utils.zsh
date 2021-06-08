#!/bin/zsh

update_brew() {
    if [[ `whoami` = root ]]; then
        exit 0
    fi

    if (( $+commands[brew] )); then
        brew update
        brew upgrade
        brew cleanup
        brew cleanup -s
        brew doctor
        brew missing
    fi
}

update_apt() {
    if [[ "`echo $UID`" == "0" ]]; then
        if (( $+commands[apt] )); then
            if (( $+commands[apt-get] )); then
                apt-get update -y --allow-unauthenticated
                apt-get upgrade -y -f --allow-unauthenticated
                apt-get dist-upgrade -y -f --allow-unauthenticated
                apt autoremove -y -f
            fi
        fi
    fi
}

update_nvim() {
    if [[ ! -d 'nvim_bin' ]]; then
        mkdir nvim_bin
    fi

    if [[ `uname` = Linux ]]; then
        wget "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage" -O nvim_bin/nvim.appimage
        chmod u+x nvim_bin/nvim.appimage
    fi

    if [[ `uname` = Darwin ]]; then
        wget "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz"
        tar xvf nvim-macos.tar.gz -C nvim_bin
        rm -rf nvim-macos.tar.gz
    fi
}
