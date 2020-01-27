#!/usr/bin/env fish

function update_local
    if type -q git
        echo Updating local config
        git pull 2>&1 | grep -E "up-to-date|up to date" || { ./update.sh; exit $?}
        git push
        git submodule init
        git submodule update --remote --merge
    end
end
update_local

function update_brew
    if type -q brew
        echo "Updating Home Brew packages"
        brew update
        brew upgrade
        brew cleanup
        brew cleanup -s
        brew doctor
        brew missing
    end
end
update_brew

function update_apt
    if "$UID" = "0"
        if type -q apt
            if type -q apt-get
                echo "Updating apt packages"
                apt-get update -y --allow-unauthenticated
                apt-get upgrade -y -f --allow-unauthenticated
                apt-get dist-upgrade -y -f --allow-unauthenticated
                apt autoremove -y -f
            end
        end
    end
end
update_apt

function update_pip3_packages
    if type -q pip3
        echo "Updating pip3 packages"
        pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U --user
    end
end
update_pip3_packages
