#!/bin/bash

if [ ! -x ./update.sh ]; then
    echo "Execute permissions are required (+x)"
    exit 1
fi

main() {
    # check install all
    if [ "$UPDATE_ALL" == 1 ]; then
        UPDATE_EDITOR=1
        UPDATE_CONSOLE=1
    fi

    if [ "$UPDATE_EDITOR" != 1 ] && [ "$UPDATE_CONSOLE" != 1 ]; then
        echo "List of update:"
        echo -e "\t all"
        echo -e "\t editor"
        echo -e "\t console"
        exit 1
    fi

    # check requireds
    if [ "$UPDATE_EDITOR" == 1 ]; then
        requiredCommands nvim
    fi

    echo ""
    echo "[Fonts Updater] : Updating fonts..."
    sudo mkdir -p /usr/local/share/fonts/arthurFonts
    sudo cp ./fonts/* /usr/local/share/fonts/arthurFonts/.
    sudo fc-cache -f -v
    echo "[Fonts Updater] : ----------------------"

    # installs
    if [ "$UPDATE_EDITOR" == 1 ]; then
        echo "[Editor Updater] : Update Editor..."

        updateEditor
    fi

    if [ "$UPDATE_CONSOLE" == 1 ]; then
        echo "[Console Updater] : Update Console..."

        updateConsole
    fi
}

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
        UPDATE_CONSOLE=1
    fi
    if [ "$p" == "console" ]; then
        UPDATE_CONSOLE=1
    fi
    if [ "$p" == "all" ]; then
        UPDATE_ALL=1
    fi
done;
if [ "$#" == 0 ]; then
    UPDATE_ALL=1
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

# updateEditor update editor
updateEditor() {
    # copy configurations
    cp config/vimrc ~/.vim/.
    cp config/init.vim ~/.config/nvim/.
    cp config/coc-settings.json ~/.config/nvim/.

    # install updates
    nvim --headless +"call dein#install()" +qall
    nvim --headless +"call dein#update()" +qall
    nvim --headless +"call dein#remote_plugins()" +qall
    nvim --headless +UpdateRemotePlugins +qall
    nvim --headless +GoInstallBinaries +qall
    nvim --headless +GoUpdateBinaries +qall
    nvim --headless +CocUpdate +qall

    echo "[Editor Updater] : + Update editor successful! +"
}

# updateConsole update console
updateConsole() {
    # copy configurations
    cp config/alacritty.yml ~/.config/alacritty/.
    cp config/.zshrc ~/.
    cp config/.tmux.conf ~/.

    bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh

    echo "[Console Updater] : + Update console successful! +"
}

main "$@"
