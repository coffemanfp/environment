#!/bin/bash
sudo apt remove -y --purge zsh tmux alacritty vim vim-editor neovim nvim
sudo snap remove --purge zsh tmux alacritty vim vim-editor neovim nvim

rm -rf ~/.config/lvim
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/share/lunarvim
rm -rf ~/.local/bin/lvim
rm -rf ~/.cache/nvim
rm -rf ~/.config/alacritty

bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh)
