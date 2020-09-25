#!/bin/bash

if [ -x ./install.sh ]; then

    sudo apt update && sudo apt upgrade && sudo apt install curl git vim neovim powerline fonts-powerline tmux universal-ctags xclip cmus terminator zsh git-flow shellcheck exiftool yarn python python3 python3-neovim python-pip python3-pip python3-dev python-setuptools python3-setuptools ruby ruby-dev rar automake autoconf autotools-dev build-essential

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
    if ! command -v vim &> /dev/null; then
        echo "The 'vim' command is needed to continue"
        exit 1
    fi
    if ! command -v nvim &> /dev/null; then
        echo "The 'nvim' command is needed to continue"
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

    #--- Add yarn key, Update yarn

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    sudo apt update && sudo apt upgrade && sudo apt dist-upgrade && sudo apt autoremove && sudo apt autoclean

    sudo apt install yarn

    #---

    sudo gem install neovim

    pip install -U pynvim
    pip3 install -U pynvim
    cpanm Neovim::Ext
    pip install -U msgpack-python
    pip3 install -U msgpack-python
    python3 -mpip install --user -U msgpack
    yarn install --froken-lockfile

    #---

    echo "----------------------"
    echo "Creando carpeta .vim"
    mkdir ~/.vim 2>/dev/null
    sudo mkdir /root/.vim 2>/dev/null
    echo "----------------------"

    echo "Creando carpeta .config/nvim"
    mkdir -p ~/.config/nvim 2>/dev/null
    sudo mkdir -p /root/.config/nvim 2>/dev/null
    echo "----------------------"

    echo "----------------------"
    echo "Copiando configuracion VIM"
    cp ./vimrc "$HOME"/.vim/.
    sudo cp ./vimrc /root/.vim/.
    echo "----------------------"

    echo "Copiando configuracion NeoVim"
    cp ./init.vim "$HOME"/.config/nvim/.
    sudo cp ./init.vim /root/.config/nvim/.
    echo "----------------------"

    echo "Copiando configuracion coc.nvim"
    cp ./coc-settings.json "$HOME"/.config/nvim/.
    sudo cp ./coc-settings.json /root/.config/nvim/.
    echo "----------------------"

    echo "Copiando configuracion Tmux"
    cp ./.tmux.conf "$HOME"/.
    sudo cp ./.tmux.conf /root/.
    echo "----------------------"

    echo "----------------------"
    echo "Instalando Universal-Ctags"
    git clone https://github.com/universal-ctags/ctags.git
    cd ctags || exit
    ./autogen.sh 
    ./configure
    make
    sudo make install
    cd ..
    sudo rm -r ctags
    echo "----------------------"

    echo "----------------------"
    echo "Instalando Powerline Fonts"
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts || exit
    ./install.sh
    cd ..
    rm -rf fonts
    echo "----------------------"

    echo "----------------------"
    echo "Configurando herramientas de GIT con Vim"
    git config --global core.editor nvim
    git config --global diff.tool vimdiff
    git config --global merge.tool vimdiff
    echo "----------------------"

    echo "----------------------"
    echo "Configurando ZSH"
    chsh -s /bin/zsh
    sudo chsh -s /bin/zsh
    echo "----------------------"

    echo "----------------------"
    echo "Configurando Oh My ZSH!"
    curl -L http://install.ohmyz.sh | sh
    wget --no-check-certificate http://install.ohmyz.sh -O - | sh
    echo "----------------------"

    echo "----------------------"
    echo "Configurando Plug Vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                echo "----------------------"

    #--- Check Go Env

    if [ -z $(go env GOROOT) ]; then
        echo "The GOROOT environment variable is not set"
        exit 1
    fi
    if [ -z $(go env GOPATH) ]; then
        echo "The GOPATH environment variable is not set"
        exit 1
    fi

    #---

    vim +PlugInstall +qa
    vim +PlugUpdate +qa
    vim +UpdateRemotePlugins +qa
    vim +GoInstallBinaries +qa
    vim +GoUpdateBinaries +qa
    vim +CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css coc-emmet coc-highlight coc-html coc-tag coc-omni coc-syntax coc-gocode +qa

else
    echo "Execute permissions are required (+x)"
    exit 1
fi
