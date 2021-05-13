#!/bin/bash

if [ -x ./install-tools.sh ]; then

    sudo apt update && sudo apt upgrade && sudo apt install curl git tmux cmus zsh git-flow shellcheck exiftool rar

    #--- Add yarn key, Update yarn

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt autoremove && sudo apt autoclean

    sudo apt install yarn

    echo "----------------------"
    echo "Configuring ZSH"
    chsh -s /bin/zsh
    sudo chsh -s /bin/zsh
    echo "----------------------"

    echo "----------------------"
    echo "Configuring Oh My ZSH!"
    curl -L http://install.ohmyz.sh | sh
    wget --no-check-certificate http://install.ohmyz.sh -O - | sh
    echo "----------------------"

    echo "Download Tmux Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    sudo git clone https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm
    echo "----------------------"

    echo "Copying configuration Tmux"
    cp ./config/.tmux.conf ~/.
    sudo cp ./config/.tmux.conf /root/.
    echo "----------------------"

    echo "Install Tmux Plugins"
    bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    echo "----------------------"

    echo "+ Installation successful! +"

else
    echo "Execute permissions are required (+x)"
    exit 1
fi
