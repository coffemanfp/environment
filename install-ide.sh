#!/bin/bash

if [ -x ./install-ide.sh ]; then

    sudo apt update && sudo apt upgrade && sudo apt install curl git powerline fonts-powerline xclip yarn python python3 python3-neovim python-pip python3-pip python3-dev python-setuptools python3-setuptools ruby ruby-dev automake autoconf autotools-dev build-essential perl cpanminus snap snapd

    #--- Check Commands

    if ! command -v curl &> /dev/null; then
        echo "The 'curl' command is needed to continue"
        exit 1
    fi
    if ! command -v gem &> /dev/null; then
        echo "The 'gem' command is needed to continue"
        exit 1
    fi
    if ! command -v python3 &> /dev/null; then
        echo "The 'yarn' command is needed to continue"
        exit 1
    fi
    if ! command -v pip &> /dev/null; then
        echo "The 'pip' command is needed to continue"
        exit 1
    fi
    if ! command -v pip3 &> /dev/null; then
        echo "The 'pip3' command is needed to continue"
        exit 1
    fi
    if ! command -v yarn &> /dev/null; then
        echo "The 'yarn' command is needed to continue"
        exit 1
    fi
    if ! command -v git &> /dev/null; then
        echo "The 'git' command is needed to continue"
        exit 1
    fi
    if ! command -v go &> /dev/null; then
        echo "The 'go' command is needed to continue"
        exit 1
    fi
    if ! command -v npm &> /dev/null; then
        echo "The 'npm' command is needed to continue"
        exit 1
    fi
    if ! command -v snap &> /dev/null; then
        echo "The 'snap' command is needed to continue"
        exit 1
    fi

    #--- Add yarn key, Update yarn

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt full-upgrade && sudo apt autoremove && sudo apt autoclean

    sudo apt install yarn

    #---

    sudo apt remove --purge vim 2>/dev/null
    sudo apt remove --purge vim-editor 2>/dev/null
    sudo apt remove --purge neovim 2>/dev/null
    sudo apt remove --purge nvim 2>/dev/null
    sudo snap remove --purge vim-editor 2>/dev/null
    sudo snap remove --purge vim 2>/dev/null
    sudo snap remove --purge nvim 2>/dev/null
    sudo snap remove --purge neovim 2>/dev/null

    sudo snap install vim-editor --beta
    sudo snap install nvim --classic

    #---

    sudo npm install -g neovim

    sudo gem install neovim

    pip install -U pynvim
    pip3 install -U pynvim
    cpanm Neovim::Ext
    sudo cpanm Neovim::Ext
    pip install -U msgpack-python
    pip3 install -U msgpack-python
    python3 -mpip install --user -U msgpack
    yarn install --froken-lockfile

    #---

    echo "----------------------"
    echo "Creating folder .vim"
    mkdir ~/.vim 2>/dev/null
    sudo mkdir /root/.vim 2>/dev/null
    echo "----------------------"

    echo "----------------------"
    echo "Creating folder .vim/tmp"
    mkdir ~/.vim/tmp 2>/dev/null
    sudo mkdir /root/.vim/tmp 2>/dev/null
    echo "----------------------"

    echo "----------------------"
    echo "Creating folder .vim/bundles"
    mkdir ~/.vim/bundles 2>/dev/null
    sudo mkdir /root/.vim/bundles 2>/dev/null
    echo "----------------------"

    echo "Creating folder .config/nvim"
    mkdir -p ~/.config/nvim 2>/dev/null
    sudo mkdir -p /root/.config/nvim 2>/dev/null
    echo "----------------------"

    echo "----------------------"
    echo "Copying configuration VIM"
    cp ./config/vimrc "$HOME"/.vim/.
    sudo cp ./config/vimrc /root/.vim/.
    echo "----------------------"

    echo "Copying configuration NeoVim"
    cp ./config/init.vim "$HOME"/.config/nvim/.
    sudo cp ./config/init.vim /root/.config/nvim/.
    echo "----------------------"

    echo "Copying configuration coc.nvim"
    cp ./config/coc-settings.json "$HOME"/.config/nvim/.
    sudo cp ./config/coc-settings.json /root/.config/nvim/.
    echo "----------------------"

    echo "----------------------"
    echo "Configuring tools GIT with Vim"
    git config --global core.editor nvim
    git config --global diff.tool vimdiff
    git config --global merge.tool vimdiff
    echo "----------------------"

    echo "----------------------"
    echo "Install Vim Plugin Manager"
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.vim/bundles/installer.sh
    sh ~/.vim/bundles/installer.sh ~/.vim/bundles

    # in root
    sudo curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.vim/bundles/installer.sh
    sudo sh ~/.vim/bundles/installer.sh ~/.vim/bundles
    echo "----------------------"

    #--- Check Go Env

    if [ -z "$(go env GOROOT)" ]; then
        echo "The GOROOT environment variable is not set"
        exit 1
    fi
    if [ -z "$(go env GOPATH)" ]; then
        echo "The GOPATH environment variable is not set"
        exit 1
    fi

    #---

    if ! command -v vim-editor &> /dev/null; then
        echo "The 'vim-editor' command is needed to continue"
        exit 1
    fi
    if ! command -v nvim &> /dev/null; then
        echo "The 'nvim' command is needed to continue"
        exit 1
    fi

    nvim --headless +"call dein#install()" +qall
    nvim --headless +"call dein#update()" +qall
    nvim --headless +"call dein#remote_plugins()" +qall
    nvim --headless +UpdateRemotePlugins +qall
    nvim --headless +GoInstallBinaries +qall
    nvim --headless +GoUpdateBinaries +qall
    nvim --headless +CocUpdate +qall

    echo "+ Installation successful! +"

else
    echo "Execute permissions are required (+x)"
    exit 1
fi
