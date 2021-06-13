#!/bin/bash

if [ ! -x ./install.sh ]; then
    echo "Execute permissions are required (+x)"
    exit 1
fi

main() {
    if [ "$INSTALL_VIM" != 1 ] && [ "$INSTALL_TMUX" != 1 ]; then
        echo "List of installations:"
        echo -e "\t vim"
        echo -e "\t tmux"
        exit 1
    fi

    if [ "$INSTALL_VIM" == 1 ]; then
        if [ "$NO_PROVIDERS" == 1 ]; then
            echo "Install Vim without Providers..."
        else
            echo "Install Vim..."
        fi

        installVim
    fi

    if [ "$INSTALL_TMUX" == 1 ]; then
        echo "Install Tmux and Tools..."

        installTmux
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
    if [ "$p" == "vim" ]; then
        INSTALL_VIM=1
    fi
    if [ "$p" == "tmux" ]; then
        INSTALL_TMUX=1
    fi
done;

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

# installVim install vim
installVim() {
    if [ "$NO_PROVIDERS" != 1 ]; then
        requiredCommands go node python python2 python3
    else
        requiredCommands go
    fi

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

    echo "dark" > ~/.mode

    sudo apt install curl git xclip snap snapd
    if [ "$NO_PROVIDERS" != 1 ]; then
        echo "Add yarn key, Update yarn"
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>/dev/null

        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

        sudo apt update 1>/dev/null

        sudo apt install python3-neovim python3-pip python3-dev python-setuptools python3-setuptools ruby-dev automake autoconf autotools-dev build-essential perl cpanminus yarn
        echo "----------------------"

        requiredCommands pip pip3 gem
        requiredSudoCommands gem cpanm
    fi

    requiredCommands curl git
    requiredSudoCommands snap apt 

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

    if [ "$NO_PROVIDERS" != 1 ]; then
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
    fi

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
}

# installTmux install tmux and tools
installTmux() {
    echo "Install tools"
    sudo apt install curl git tmux cmus zsh git-flow shellcheck exiftool rar fzf
    echo "----------------------"

    echo "dark" > ~/.mode

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
}

main "$@"
