#!/bin/bash

if [ ! -x ./install-tools.sh ]; then
    echo "Execute permissions are required (+x)"
    exit 1
fi

echo "Install tools"
sudo apt install curl git tmux cmus zsh git-flow shellcheck exiftool rar fzf
echo "----------------------"

echo "Add yarn key, Update yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>/dev/null

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update 1>/dev/null

sudo apt install yarn 1>/dev/null
echo "----------------------"

echo "Download Tmux Plugin Manager"
sudo rm -r ~/.tmux/plugins 
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 1>/dev/null
echo "----------------------"

echo "Copying configuration Tmux"
cp ./config/.tmux.conf ~/. 1>/dev/null
echo "----------------------"

echo "Install Tmux Plugins"
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh
echo "----------------------"

echo "Install Oh My ZSH!"
curl -L http://install.ohmyz.sh 2>/dev/null | sh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh
echo "----------------------"

echo "Configuring Zsh Plugins"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting 1>/dev/null

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions 1>/dev/null
echo "----------------------"

echo "Copying configuration Zsh"
cp ./config/.zshrc ~/. 
echo "----------------------"

echo "----------------------"
echo "Configuring ZSH"
chsh -s "$(command -v zsh)"
echo "----------------------"

echo "+ Installation successful! +"
