# copy configurations
cp config/.zshrc ~/.
cp config/.tmux.conf ~/.

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
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh
