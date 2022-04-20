#!/bin/bash

echo "- Uninstalling zsh, tmux, alacritty, vim, neovim and lunarvim..."
echo "- ... Phase 1/3"
sudo apt remove -y --purge zsh &>/dev/null
sudo apt remove -y --purge tmux &>/dev/null
sudo apt remove -y --purge alacritty &>/dev/null
sudo apt remove -y --purge vim &>/dev/null
sudo apt remove -y --purge vim-editor &>/dev/null
sudo apt remove -y --purge neovim &>/dev/null
sudo apt remove -y --purge nvim &>/dev/null

echo "- ... Phase 2/3"
sudo snap remove --purge zsh &>/dev/null
sudo snap remove --purge tmux &>/dev/null
sudo snap remove --purge alacritty &>/dev/null
sudo snap remove --purge vim &>/dev/null
sudo snap remove --purge vim-editor &>/dev/null
sudo snap remove --purge neovim &>/dev/null
sudo snap remove --purge nvim &>/dev/null

echo "- ... Phase 3/3"
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh) &>/dev/null
echo "- ... Ready!"

echo ""
echo "- Deleting configuration files and caches..."
echo "- ... Phase 1/1"
rm -rf ~/.config/lvim &>/dev/null
rm -rf ~/.config/nvim &>/dev/null
rm -rf ~/.local/share/nvim &>/dev/null
rm -rf ~/.local/share/lunarvim &>/dev/null
rm -rf ~/.local/share/lvim &>/dev/null
rm -rf ~/.local/bin/lvim &>/dev/null
rm -rf ~/.cache/nvim &>/dev/null
rm -rf ~/.cache/nvim.bak &>/dev/null
rm -rf ~/.config/alacritty &>/dev/null
rm -rf ~/snap/alacritty/common/.cache &>/dev/null
rm -rf ~/.tmux &>/dev/null
go clean &>/dev/null
go clean -cache &>/dev/null
go clean -testcache &>/dev/null
go clean -fuzzcache &>/dev/null
golangci-lint cache clear &>/dev/null
echo "- ... Ready!"

echo ""
echo "+ Uninstallation is complete"
