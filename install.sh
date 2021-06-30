#!/bin/bash

if [ ! -x ./install.sh ]; then
    echo "Execute permissions are required (+x)"
    exit 1
fi

main() {
    # check install all
    if [ "$INSTALL_ALL" == 1 ]; then
        INSTALL_EDITOR=1
        INSTALL_CONSOLE=1
    fi

    if [ "$INSTALL_EDITOR" != 1 ] && [ "$INSTALL_CONSOLE" != 1 ]; then
        echo "List of installations:"
        echo -e "\t all"
        echo -e "\t editor"
        echo -e "\t console"
        exit 1
    fi

    # check requireds
    if [ "$INSTALL_EDITOR" == 1 ]; then
        if [ "$NO_PROVIDERS" != 1 ]; then
            requiredCommands go node python python2 python3
        else
            requiredCommands go
        fi

        requiredSudoCommands apt npm apt-key tee

        #--- Check Go Env
        if [ -z "$(go env GOROOT)" ]; then
            echo "[Editor Installer] : The GOROOT environment variable is not set"
            exit 1
        fi
        if [ -z "$(go env GOPATH)" ]; then
            echo "[Editor Installer] : The GOPATH environment variable is not set"
            exit 1
        fi
    fi
    if [ "$INSTALL_CONSOLE" == 1 ]; then
        requiredCommands curl wget git
        requiredSudoCommands snap apt 
    fi

    echo ""
    echo "[Fonts Installer] : Installing fonts..."
    sudo mkdir -p /usr/local/share/fonts/arthurFonts
    sudo cp ./fonts/* /usr/local/share/fonts/arthurFonts/.
    sudo fc-cache -f -v
    echo "[Fonts Installer] : ----------------------"

    # installs
    if [ "$INSTALL_EDITOR" == 1 ]; then
        if [ "$NO_PROVIDERS" == 1 ]; then
            echo "[Editor Installer] : Install Editor without Providers..."
        else
            echo "[Editor Installer] : Install Editor..."
        fi

        installEditor
    fi

    if [ "$INSTALL_CONSOLE" == 1 ]; then
        echo "[Console Installer] : Install Console and Tools..."

        installConsole
    fi
}

# get options
optstring=":n"
while getopts ${optstring} arg; do
  case ${arg} in
    n) 
        NO_PROVIDERS=1
        ;;
    ?) 
        echo "Invalid option:" 
        echo -e "\t$OPTARG"
        exit 1
        ;;
  esac
done
# clean arguments
for a; do
   shift
   case $a in
   -*) opts+=("$a");;
   *) set -- "$@" "$a";;
   esac
done
# set vars with arguments
for p in "$@"; do
    if [ "$p" == "editor" ]; then
        INSTALL_EDITOR=1
    fi
    if [ "$p" == "console" ]; then
        INSTALL_CONSOLE=1
    fi
    if [ "$p" == "all" ]; then
        INSTALL_ALL=1
    fi
done;
if [ "$#" == 0 ]; then
    INSTALL_ALL=1
fi

# requiredCommands terminates the execution if there are no commands
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

# requiredSudoCommands terminates the execution if no 'sudo' commands exist
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

# installEditor install editor
installEditor() {
    echo "dark" > ~/.mode

    sudo apt install curl git xclip snap snapd

    if [ "$NO_PROVIDERS" != 1 ]; then
        echo ""
        echo "[Editor Installer] : Adding yarn key, Updating yarn..."
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>/dev/null

        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

        sudo apt update 1>/dev/null

        sudo apt install python3-neovim python3-pip python3-dev python-setuptools python3-setuptools ruby-dev automake autoconf autotools-dev build-essential perl cpanminus yarn
        echo "[Editor Installer] : ----------------------"

        requiredCommands pip pip3 gem
        requiredSudoCommands gem cpanm
    fi

    requiredCommands curl git
    requiredSudoCommands snap apt 

    echo ""
    echo "[Editor Installer] : Removing current version of Vim and NeoVim..."
    sudo apt remove --purge vim 2>/dev/null
    sudo apt remove --purge vim-editor 2>/dev/null
    sudo apt remove --purge neovim 2>/dev/null
    sudo apt remove --purge nvim 2>/dev/null
    sudo snap remove --purge vim-editor 2>/dev/null
    sudo snap remove --purge vim 2>/dev/null
    sudo snap remove --purge nvim 2>/dev/null
    sudo snap remove --purge neovim 2>/dev/null
    echo "[Editor Installer] : ----------------------"

    echo ""
    echo "[Editor Installer] : Installing Vim and NeoVim..."
    sudo snap install vim-editor --beta
    sudo snap install nvim --classic
    echo "[Editor Installer] : ----------------------"

    requiredCommands nvim

    if [ "$NO_PROVIDERS" != 1 ]; then
        echo ""
        echo "[Editor Installer] : Installing Providers for NeoVim..."
        sudo npm install -g neovim
        sudo gem install neovim
        pip install -U pynvim 
        python2 -m pip install --user --upgrade pynvim
        pip3 install -U pynvim
        python3 -m pip install --user --upgrade pynvim
        pip install -U msgpack-python
        pip3 install -U msgpack-python
        python3 -mpip install --user -U msgpack
        yarn install --froken-lockfile
        echo "[Editor Installer] : ----------------------"
    fi

    echo ""
    echo "[Editor Installer] : Creating folders..."
    mkdir ~/.vim 2>/dev/null
    mkdir -p ~/.vim/tmp 2>/dev/null
    sudo rm -r ~/.vim/bundles
    mkdir -p ~/.vim/bundles 2>/dev/null
    mkdir -p ~/.config/nvim 2>/dev/null

    echo "[Editor Installer] : - Copying configuration VIM..."
    cp ./config/vimrc ~/.vim/.

    echo "[Editor Installer] : - Copying configuration NeoVim..."
    cp ./config/init.vim ~/.config/nvim/.

    echo "[Editor Installer] : - Copying configuration coc.nvim..."
    cp ./config/coc-settings.json ~/.config/nvim/.

    echo "[Editor Installer] : ----------------------"

    echo ""
    echo "[Editor Installer] : Configuring tools GIT with Vim..."
    git config --global core.editor nvim
    git config --global diff.tool vimdiff
    git config --global merge.tool vimdiff
    echo "[Editor Installer] : ----------------------"

    echo ""
    echo "[Editor Installer] : Install Vim Plugin Manager..."
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh 2>/dev/null > ~/.vim/bundles/installer.sh
    sh ~/.vim/bundles/installer.sh ~/.vim/bundles
    echo "[Editor Installer] : ----------------------"

    nvim --headless +"call dein#install()" +qall
    nvim --headless +"call dein#update()" +qall
    nvim --headless +"call dein#remote_plugins()" +qall
    nvim --headless +UpdateRemotePlugins +qall
    nvim --headless +GoInstallBinaries +qall
    nvim --headless +GoUpdateBinaries +qall
    nvim --headless +CocUpdate +qall

    echo ""
    echo "[Editor Installer] : + Installation Editor successful! +"
}

# installConsole install console and tools
installConsole() {
    echo "dark" > ~/.mode

    sudo snap install alacritty --classic

    echo ""
    echo "[Console Installer] : Installing tools..."
    sudo apt install curl git tmux cmus zsh git-flow shellcheck exiftool rar fzf
    echo "[Console Installer] : ----------------------"

    echo ""
    echo "[Console Installer] : Adding yarn key, Updating yarn"
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>/dev/null

    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    sudo apt update 1>/dev/null
    sudo apt install yarn 1>/dev/null
    echo "[Console Installer] : ----------------------"

    echo ""
    echo "[Console Installer] : Downloading Tmux Plugin Manager..."
    sudo rm -r ~/.tmux/plugins 
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 1>/dev/null

    echo "[Console Installer] : - Copying configuration Alacritty..."
    mkdir -p ~/.config/alacritty 2>/dev/null
    cp ./config/alacritty.yml ~/.config/alacritty/.

    echo "[Console Installer] : - Copying configuration Tmux..."
    cp ./config/.tmux.conf ~/.
    echo "[Console Installer] : ----------------------"

    echo ""
    echo "[Console Installer] : Installing Tmux Plugins..."
    bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    echo "[Console Installer] : ----------------------"

    echo ""
    echo "[Console Installer] : Installing Oh My ZSH!..."
    curl -L http://install.ohmyz.sh 2>/dev/null | sh
    wget --no-check-certificate http://install.ohmyz.sh -O - | sh

    echo ""
    echo "[Console Installer] : ----------------------"
    echo "[Console Installer] : Configuring Zsh Plugins..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting 1>/dev/null
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions 1>/dev/null

    echo "[Console Installer] : - Copying configuration Zsh..."
    cp ./config/.zshrc ~/. 
    echo "[Console Installer] : ----------------------"

    echo ""
    echo "[Console Installer] : Configuring ZSH..."
    chsh -s "$(command -v zsh)"
    echo "[Console Installer] : ----------------------"

    echo ""
    echo "[Console Installer] : + Installation Console successful! (Restarting the computer to use Zsh for the first time) +"
}

main "$@"
