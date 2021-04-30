#!/bin/zsh

update_brew() {
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
    if [[ `uname` = Linux ]]; then
        wget "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage" -O bin/nvim
        chmod u+x bin/nvim
    fi
    if [[ `uname` = Darwin ]]; then
        wget "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz"
        tar xvf nvim-macos.tar.gz -C bin nvim-osx64/bin/nvim
        mv bin/nvim-osx64/bin/nvim bin/nvim
        rm -rf nvim-macos.tar.gz bin/nvim-osx64
    fi
}

update_ghq() {
    if [[ `uname` = Linux ]]; then
        wget https://github.com/x-motemen/ghq/releases/latest/download/ghq_linux_amd64.zip
        unzip -o -j "ghq_linux_amd64.zip" "ghq_linux_amd64/ghq" -d "bin"
        rm ghq_linux_amd64.zip
    fi

    if [[ `uname` = Darwin ]]; then
        wget https://github.com/x-motemen/ghq/releases/latest/download/ghq_darwin_amd64.zip
        unzip -o -j "ghq_darwin_amd64.zip" "ghq_darwin_amd64/ghq" -d "bin"
        rm ghq_darwin_amd64.zip
    fi
}

update_pip3_packages() {
   if (( $+commands[pip3] )); then
       echo "Updating pip3 packages"
       pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U --user
   fi
}

update_npm_packages() {
    if [[ ( `uname` = Linux && `whoami` = root ) || `uname` = Darwin ]]; then
        if (( $+commands[npm] )); then
            cat npm-packages.txt | xargs npm install -g
            npm update -g
        fi
    fi
}
