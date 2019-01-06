#!/bin/sh

# Funciones
installDeps() {
    # Instalacion
    sudo "$1" install git vim curl neovim powerline fonts-powerline tmux universal-ctags vim-gnome xclip cmus terminator zsh git-flow
}

makeDirs(){
    # Carpeta
    if ! [ -d "$HOME/.vim" ]; then
        echo "----------------------"
        echo "Creando carpeta .vim"
        mkdir ~/.vim 2>/dev/null
        sudo mkdir /root/.vim 2>/dev/null
        echo "----------------------"
    fi

    if ! [ -d "$HOME/.config" ]; then
        echo "Creando carpeta .config"
        mkdir ~/.config 2>/dev/null
        sudo mkdir /root/.config 2>/dev/null
        echo "----------------------"
    fi

    if ! [ -d "$HOME/.config/nvim" ]; then
        echo "Creando carpeta .config/nvim"
        mkdir ~/.config/nvim 2>/dev/null
        sudo mkdir /root/.config/nvim 2>/dev/null
        echo "----------------------"
    fi
}

vimConfig(){
    # Vim
    echo "----------------------"
    echo "Copiando configuracion VIM"
    cp ./vimrc "$HOME"/.vim/.
    sudo cp ./vimrc /root/.vim/.
    echo "----------------------"

    # NeoVim
    echo "Copiando configuracion NeoVim"
    cp ./init.vim "$HOME"/.config/nvim/.
    sudo cp ./init.vim /root/.config/nvim/.
    echo "----------------------"
}

tmuxConfig() {
    # Tmux
    echo "Copiando configuracion Tmux"
    cp ./.tmux.conf "$HOME"/.
    sudo cp ./.tmux.conf /root/.
    echo "----------------------"
}


installCtags(){
    # Universal-Ctags
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
}

installPowerlineFonts(){
    # Powerline Fonts
    echo "----------------------"
    echo "Instalando Powerline Fonts"
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts || exit
    ./install.sh
    cd ..
    rm -rf fonts
    echo "----------------------"
}

installVundle() {
    # Vundle
    echo "----------------------"
    echo "Instalando Vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME"/.vim/bundle/Vundle.vim
    echo "----------------------"

    echo "Instalando Plugins de Vim"
    vim +PluginInstall +qa
    echo "----------------------"
}

gitConfig() {
    # GIT
    echo "----------------------"
    echo "Configurando herramientas de GIT con Vim"
    git config --global core.editor nvim
    git config --global diff.tool vimdiff
    git config --global merge.tool vimdiff
    echo "----------------------"
}

zshConfig() {
    # ZSH
    echo "----------------------"
    echo "Configurando ZSH"
    chsh -s /bin/zsh
    sudo chsh -s /bin/zsh
    echo "----------------------"
}

installOhMyZSH() {
    # Oh My Zsh
    echo "----------------------"
    echo "Configurando Oh My ZSH!"
    curl -L http://install.ohmyz.sh | sh
    wget --no-check-certificate http://install.ohmyz.sh -O - | sh
    echo "----------------------"
}
# ----------

# Variables
sudo 1>/dev/null 2>/dev/null
existSudo=$?

packageManager=""
# ----------

if [ "$existSudo" -ne "1" ]; then
    echo "Se necesita el comando 'sudo' para ejecutar la instalacion"

else
    system=$(sudo cat /etc/issue | grep Debian | cut -d " " -f 1)

    case $system in
        'Fedora')
            packageManager="dnf"
            ;;

        *)
            packageManager="apt"
            ;;

    esac

    installDeps $packageManager
    makeDirs
    vimConfig
    tmuxConfig
    installCtags
    installPowerlineFonts
    installVundle
    gitConfig
    zshConfig
    installOhMyZSH
fi

