if [ -x ./install-basic-ide.sh ]; then
    sudo apt remove --purge vim
    sudo apt remove --purge vim-editor
    sudo apt remove --purge neovim
    sudo snap remove vim-editor
    sudo snap remove vim
    sudo snap remove nvim

    sudo snap install vim-editor --beta
    sudo snap install nvim --classic

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
    echo "Install Vim Plugin Manager"
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.vim/bundles/installer.sh
    sh ~/.vim/bundles/installer.sh ~/.vim/bundles
    echo "----------------------"
    
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
