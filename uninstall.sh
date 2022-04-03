#!/bin/bash
sudo apt remove -y --purge zsh
sudo apt remove -y --purge tmux
sudo apt remove -y --purge alacritty
sudo apt remove -y --purge vim
sudo apt remove -y --purge vim-editor
sudo apt remove -y --purge neovim
sudo apt remove -y --purge nvim

sudo snap remove --purge zsh 
sudo snap remove --purge tmux
sudo snap remove --purge alacritty
sudo snap remove --purge vim
sudo snap remove --purge vim-editor
sudo snap remove --purge neovim
sudo snap remove --purge nvim

rm -rf ~/.config/lvim
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/share/lunarvim
rm -rf ~/.local/bin/lvim
rm -rf ~/.cache/nvim
rm -rf ~/.config/alacritty

bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
