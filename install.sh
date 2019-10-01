curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update

sudo apt install git vim curl neovim powerline fonts-powerline tmux universal-ctags vim-gnome xclip cmus terminator zsh git-flow shellcheck exiftool yarn python-neovim python3-neovim python-pip python3-pip python3-dev python3-setuptools ruby ruby-dev

sudo gem install neovim

sudo easy_install3 pip

if ! [ -d "$HOME/.vim" ]; then
    echo "----------------------"
    echo "Creando carpeta .vim"
    mkdir ~/.vim 2>/dev/null
    sudo mkdir /root/.vim 2>/dev/null
    echo "----------------------"
fi

if ! [ -d "$HOME/.config/nvim" ]; then
    echo "Creando carpeta .config/nvim"
    mkdir -p ~/.config/nvim 2>/dev/null
    sudo mkdir -p /root/.config/nvim 2>/dev/null
    echo "----------------------"
fi

echo "----------------------"
echo "Copiando configuracion VIM"
cp ./vimrc "$HOME"/.vim/.
sudo cp ./vimrc /root/.vim/.
echo "----------------------"

echo "Copiando configuracion NeoVim"
cp ./init.vim "$HOME"/.config/nvim/.
sudo cp ./init.vim /root/.config/nvim/.
echo "----------------------"

echo "Copiando configuracion Tmux"
cp ./.tmux.conf "$HOME"/.
sudo cp ./.tmux.conf /root/.
echo "----------------------"

echo "----------------------"
echo "Instalando Universal-Ctags"
git clone https://github.com/universal-ctags/ctags.git
cd ctags || exit
./autogen.sh 
./configure
make
sudo make install
cd ..
sudo rm -r ctags
echo "----------------------"

echo "----------------------"
echo "Instalando Powerline Fonts"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts || exit
./install.sh
cd ..
rm -rf fonts
echo "----------------------"

echo "----------------------"
echo "Configurando herramientas de GIT con Vim"
git config --global core.editor nvim
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff
echo "----------------------"

echo "----------------------"
echo "Configurando ZSH"
chsh -s /bin/zsh
sudo chsh -s /bin/zsh
echo "----------------------"

echo "----------------------"
echo "Configurando Oh My ZSH!"
curl -L http://install.ohmyz.sh | sh
wget --no-check-certificate http://install.ohmyz.sh -O - | sh
echo "----------------------"


echo "----------------------"
echo "Configurando Plug Vim"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "----------------------"

vim +PlugInstall +qa
vim +PlugUpdate +qa
vim +UpdateRemotePlugins +qa
vim +GoInstallBinaries +qa
vim +GoUpdateBinaries +qa
vim +CocInstall coc-tsserver coc-eslint coc-json coc-prettier coc-css coc-emmet coc-highlight coc-html coc-tag coc-omni coc-syntax coc-gocode +qa

