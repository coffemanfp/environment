# copy configurations
cp config/.zshrc ~/.
cp config/.tmux.conf ~/.

cp config/vimrc ~/.vim/.
cp config/init.vim ~/.config/nvim/.
cp config/coc-settings.json ~/.config/nvim/.

# install updates
nvim --headless +PlugInstall +qall
nvim --headless +PlugUpdate +qall
nvim --headless +PlugUpgrade +qall
nvim --headless +UpdateRemotePlugins +qall
nvim --headless +GoInstallBinaries +qall
nvim --headless +GoUpdateBinaries +qall
nvim --headless +CocUpdate +qall
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh
