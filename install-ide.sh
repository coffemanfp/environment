#!/bin/bash

if [ ! -x ./install-ide.sh ]; then
    echo "Execute permissions are required (+x)"
    exit 1
fi

requiredCommands() {
    concatMissingCommand=""
    for p in "$@"; do
        if ! p_tmp="$(type -p "$p")" || [[ -z $p_tmp ]]; then
            concatMissingCommand+="\t$p\n"
        fi
    done;

    if [[ -n $concatMissingCommand ]]; then 
        echo "Commands are required:"
        echo -e "$concatMissingCommand"
        exit 1
    fi
}

requiredSudoCommands() {
    concatMissingCommand=""
    for p in "$@"; do
        if ! p_tmp="$(sudo which "$p")" || [[ -z $p_tmp ]]; then
            concatMissingCommand+="\tsudo $p\n"
        fi
    done;

    if [[ -n $concatMissingCommand ]]; then 
        echo "Commands with SUDO are required:"
        echo -e "$concatMissingCommand"
        exit 1
    fi
}

requiredCommands go node python python2 python3
requiredSudoCommands apt npm apt-key tee

#--- Check Go Env
if [ -z "$(go env GOROOT)" ]; then
    echo "The GOROOT environment variable is not set"
    exit 1
fi
if [ -z "$(go env GOPATH)" ]; then
    echo "The GOPATH environment variable is not set"
    exit 1
fi

echo "Add yarn key, Update yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>/dev/null

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update 1>/dev/null

sudo apt install curl git xclip python3-neovim python3-pip python3-dev python-setuptools python3-setuptools ruby-dev automake autoconf autotools-dev build-essential perl cpanminus snap snapd yarn
echo "----------------------"

requiredCommands curl git pip pip3 gem
requiredSudoCommands snap gem cpanm

echo "Removing current version of Vim and NeoVim"
sudo apt remove --purge vim &>/dev/null
sudo apt remove --purge vim-editor &>/dev/null
sudo apt remove --purge neovim &>/dev/null
sudo apt remove --purge nvim &>/dev/null
sudo snap remove --purge vim-editor &>/dev/null
sudo snap remove --purge vim &>/dev/null
sudo snap remove --purge nvim &>/dev/null
sudo snap remove --purge neovim &>/dev/null
echo "----------------------"

echo "Install Vim and NeoVim"
sudo snap install vim-editor --beta
sudo snap install nvim --classic
echo "----------------------"

requiredCommands nvim

echo "Install Providers for NeoVim"
sudo npm install -g neovim &>/dev/null
sudo gem install neovim &>/dev/null
pip install -U pynvim &>/dev/null
python2 -m pip install --user --upgrade pynvim &>/dev/null
pip3 install -U pynvim &>/dev/null &>/dev/null
python3 -m pip install --user --upgrade pynvim &>/dev/null
cpanm Neovim::Ext &>/dev/null &>/dev/null
pip install -U msgpack-python &>/dev/null
pip3 install -U msgpack-python &>/dev/null
python3 -mpip install --user -U msgpack &>/dev/null
yarn install --froken-lockfile &>/dev/null
echo "----------------------"

echo "----------------------"
echo "Creating folder .vim"
mkdir ~/.vim 2>/dev/null
echo "----------------------"

echo "----------------------"
echo "Creating folder .vim/tmp"
mkdir ~/.vim/tmp 2>/dev/null
echo "----------------------"

echo "----------------------"
echo "Creating folder .vim/bundles"
sudo rm -r ~/.vim/bundles
mkdir ~/.vim/bundles 2>/dev/null
echo "----------------------"

echo "Creating folder .config/nvim"
mkdir -p ~/.config/nvim 2>/dev/null
echo "----------------------"

echo "----------------------"
echo "Copying configuration VIM"
cp ./config/vimrc "$HOME"/.vim/.
echo "----------------------"

echo "Copying configuration NeoVim"
cp ./config/init.vim "$HOME"/.config/nvim/.
echo "----------------------"

echo "Copying configuration coc.nvim"
cp ./config/coc-settings.json "$HOME"/.config/nvim/.
echo "----------------------"

echo "----------------------"
echo "Configuring tools GIT with Vim"
git config --global core.editor nvim
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
echo "----------------------"

echo "----------------------"
echo "Install Vim Plugin Manager"
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh 2>/dev/null > ~/.vim/bundles/installer.sh
sh ~/.vim/bundles/installer.sh ~/.vim/bundles
echo "----------------------"

nvim --headless +"call dein#install()" +qall
nvim --headless +"call dein#update()" +qall
nvim --headless +"call dein#remote_plugins()" +qall
nvim --headless +UpdateRemotePlugins +qall
nvim --headless +GoInstallBinaries +qall
nvim --headless +GoUpdateBinaries +qall
nvim --headless +CocUpdate +qall

echo "+ Installation successful! +"
