#!/bin/zsh

update_brew() {
    (( $+commands[brew] )) && {
        brew update
        brew upgrade
        brew cleanup
        brew cleanup -s
        brew doctor
        brew missing
    }
}

update_apt() {
    [[ "`echo $UID`" == "0" ]] && {
        (( $+commands[apt] )) && {
            (( $+commands[apt-get] )) && {
                apt-get update -y --allow-unauthenticated
                apt-get upgrade -y -f --allow-unauthenticated
                apt-get dist-upgrade -y -f --allow-unauthenticated
                apt autoremove -y -f
            }
        }
    }
}

update_nvim() {
    if [ `uname` = Linux ]; then
        wget "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage" -O bin/nvim
        chmod u+x bin/nvim
    fi
    if [ `uname` = Darwin ]; then
        wget "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz"
        tar xvf nvim-macos.tar.gz -C bin nvim-osx64/bin/nvim
        mv bin/nvim-osx64/bin/nvim bin/nvim
        rm -rf nvim-macos.tar.gz bin/nvim-osx64
    fi
}

update_ghq() {
    if [ `uname` = Linux ]; then
        wget https://github.com/x-motemen/ghq/releases/latest/download/ghq_linux_amd64.zip
        unzip -o -j "ghq_linux_amd64.zip" "ghq_linux_amd64/ghq" -d "bin"
        rm ghq_linux_amd64.zip
    fi

    if [ `uname` = Darwin ]; then
        wget https://github.com/x-motemen/ghq/releases/latest/download/ghq_darwin_amd64.zip
        unzip -o -j "ghq_darwin_amd64.zip" "ghq_darwin_amd64/ghq" -d "bin"
        rm ghq_darwin_amd64.zip
    fi
}
