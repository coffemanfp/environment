# Instalacion
sudo apt install git vim curl neovim powerline fonts-powerline tmux universal-ctags vim-gnome xclip cmus terminator zsh

# Carpeta
mkdir ~/.vim
mkdir ~/.config
mkdir ~/.config/nvim

# Vim
cp ./vimrc ~/.vim/.
sudo cp ./vimrc /root/.vim/.

# NeoVim
cp ./init.vim ~/.config/nvim/.
sudo cp ./init.vim ~/.config/nvim/.

# Tmux
cp ./.tmux.conf ~/.
sudo cp ./.tmux.conf ~/.

# Universal-Ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh 
./configure
make
sudo make install

# Powerline Fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qa

# GIT
git config --global core.editor nvim
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff

# ZSH
chsh -s /bin/zsh
sudo chsh -s /bin/zsh

# Oh My Zsh
curl -L http://install.ohmyz.sh | sh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh
