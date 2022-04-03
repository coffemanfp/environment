#!/bin/bash
mkdir logs &>/dev/null
now=$(date +"%F+%T")
log_file="$PWD/logs/install-$now.log"
rm -rf logs/install-* &>/dev/null
install_all=0

if [ ! -x "$0" ]; then
	echo "[Installer Error] : Execute permissions are required (+x)" | tee -a "$log_file"
	echo "exit 1" | tee -a "$log_file"
	exit 1
fi

main() {
	# check install all
	if [ "$install_all" == 1 ]; then
		install_editor=1
		install_console=1
	fi

	if [ "$install_editor" != 1 ] && [ "$install_console" != 1 ]; then
		echo "[Installer Error] : List of installations:" | tee -a "$log_file"
		echo -e "\tall" | tee -a "$log_file"
		echo -e "\teditor" | tee -a "$log_file"
		echo -e "\tconsole" | tee -a "$log_file"

		exit 1
	fi

	requiredCommands git
	# check requireds
	if [ "$install_editor" == 1 ]; then
		if [ "$no_providers" == 1 ]; then
			requiredCommands go node npm
		else
			requiredCommands go node npm python3 cargo
			requiredSudoCommands npm snap
		fi

		requiredSudoCommands apt npm apt-key tee add-apt-repository

		#--- check node version
		nodeVersion="$(node --version | cut -d'.' -f1)"
		nodeVersion="${nodeVersion#'v'}"
		if [ "$nodeVersion" -lt 11 ]; then
			echo "[Editor Installer Error] : NodeJs version must be higher than v11.0.0 ( >= v12.0.0 )" | tee -a "$log_file"
			echo "exit 1" | tee -a "$log_file"
			exit 1
		fi
		goVersion="$(go version | cut -d' ' -f3 | cut -d'.' -f1)"
		goVersion="${goVersion#'go'}"
		goVersion2="$(go version | cut -d' ' -f3 | cut -d'.' -f2)"

		if [ "$goVersion" -lt 1 ] || [ "$goVersion2" -lt 15 ]; then
			echo "[Editor Installer Error] : Go version must be higher than v1.14.0 ( >= v1.15.0 )" | tee -a "$log_file"
			echo "exit 1" | tee -a "$log_file"
			exit 1
		fi

		#--- check go env
		if [ -z "$(go env GOROOT)" ]; then
			echo "[Editor Installer Error] : The GOROOT environment variable is not set" | tee -a "$log_file"
			echo "exit 1" | tee -a "$log_file"
			exit 1
		fi
		if [ -z "$(go env GOPATH)" ]; then
			echo "[Editor Installer Error] : The GOPATH environment variable is not set" | tee -a "$log_file"
			echo "exit 1" | tee -a "$log_file"
			exit 1
		fi
	fi
	if [ "$install_console" == 1 ]; then
		requiredCommands curl wget git cargo
		requiredSudoCommands snap apt
	fi

	git pull origin master | tee -a "$log_file"

	echo ""
	echo "[Fonts Installer] : Installing fonts..." | tee -a "$log_file"
	sudo mkdir -p /usr/local/share/fonts/arthurnavah-fonts | tee -a "$log_file"
	sudo cp ./fonts/* /usr/local/share/fonts/arthurnavah-fonts/. | tee -a "$log_file"
	sudo fc-cache -f -v &>/dev/null | tee -a "$log_file"
	echo "[Fonts Installer] : ----------------------" | tee -a "$log_file"

	# installs
	if [ "$install_console" == 1 ]; then
		echo "[Console Installer] : Install Console and Tools..." | tee -a "$log_file"

		installConsole
	fi

	if [ "$install_editor" == 1 ]; then
		if [ "$no_providers" == 1 ]; then
			echo "[Editor Installer] : Install Editor without Providers..." | tee -a "$log_file"
		else
			echo "[Editor Installer] : Install Editor..." | tee -a "$log_file"
		fi

		installEditor
	fi

}

# get options
optstring=":n"
while getopts ${optstring} arg; do
	case ${arg} in
	n)
		no_providers=1
		;;
	?)
		echo "[Installer Error] : Invalid option:" | tee -a "$log_file"
		echo -e "\t$OPTARG" | tee -a "$log_file"
		echo "exit 1" | tee -a "$log_file"
		exit 1
		;;
	esac
done
# excluding opts from the arguments
for a; do
	shift
	case $a in
	-*) opts+=("$a") ;;
	*) set -- "$@" "$a" ;;
	esac
done
# set vars with arguments
for p in "$@"; do
	eval install_"$p"=1
done
if [ "$#" == 0 ]; then
	install_editor=1
fi

# requiredCommands terminates the execution if there are no commands
requiredCommands() {
	concatMissingCommand=""
	for p in "$@"; do
		if ! p_tmp="$(type -p "$p")" || [[ -z $p_tmp ]]; then
			concatMissingCommand+="\t$p\n"
		fi
	done

	if [[ -n $concatMissingCommand ]]; then
		echo "[Installer Error] : Commands are required:" | tee -a "$log_file"
		echo -e "$concatMissingCommand" | tee -a "$log_file"
		echo "exit 1" | tee -a "$log_file"
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
	done

	if [[ -n $concatMissingCommand ]]; then
		echo "[Installer Error] : Commands with SUDO are required:" | tee -a "$log_file"
		echo -e "$concatMissingCommand" | tee -a "$log_file"
		echo "exit 1" | tee -a "$log_file"
		exit 1
	fi
}

# installEditor install editor
installEditor() {
	echo "dark" >~/.mode | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Editor Installer] : Adding yarn key, Updating yarn..." | tee -a "$log_file"
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>/dev/null

	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

	curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

	sudo apt install -y fonts-powerline curl git xclip silversearcher-ag yarn | tee -a "$log_file"
	sudo apt install -y ripgrep | tee -a "$log_file"
	sudo apt install -y fd-find | tee -a "$log_file"
	sudo ln -s "$(command -v fdfind)" /usr/bin/fd

	if [ "$no_providers" != 1 ]; then
		echo "[Editor Installer] : ----------------------" | tee -a "$log_file"
		sudo apt update 1>/dev/null | tee -a "$log_file"
		sudo apt install -y python-setuptools python3-neovim python3-pip python3-dev python3.8-venv python3-setuptools | tee -a "$log_file"
		echo "[Editor Installer] : ----------------------" | tee -a "$log_file"

		requiredCommands pip3 cargo
		requiredSudoCommands node npm
	fi

	requiredCommands curl git
	requiredSudoCommands apt

	echo "" | tee -a "$log_file"
	echo "[Editor Installer] : Removing current version of Vim, Neovim and LunarVim..." | tee -a "$log_file"
	rm -rf ~/.config/lvim
	sudo apt remove -y --purge vim 2>/dev/null | tee -a "$log_file"
	sudo apt remove -y --purge vim-editor 2>/dev/null | tee -a "$log_file"
	sudo apt remove -y --purge neovim 2>/dev/null | tee -a "$log_file"
	sudo apt remove -y --purge nvim 2>/dev/null | tee -a "$log_file"
	sudo snap remove --purge vim-editor 2>/dev/null | tee -a "$log_file"
	sudo snap remove --purge vim 2>/dev/null | tee -a "$log_file"
	sudo snap remove --purge nvim 2>/dev/null | tee -a "$log_file"
	sudo snap remove --purge neovim 2>/dev/null | tee -a "$log_file"
	sudo rm "$(command -v nvim)" | tee -a "$log_file"
	sudo rm "$(command -v vim)" | tee -a "$log_file"
	bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/uninstall.sh) | tee -a "$log_file"
	rm -rf ~/.local/share/lunarvim | tee -a "$log_file"
	rm -rf ~/.config/lvim | tee -a "$log_file"
	echo "[Editor Installer] : ----------------------" | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Editor Installer] : Installing Vim and NeoVim..." | tee -a "$log_file"
	echo "[Editor Installer] : - Adding vim repository (ppa:jonathonf/vim)..." | tee -a "$log_file"
	sudo add-apt-repository -y ppa:jonathonf/vim
	sudo apt update
	sudo apt install -y vim

	rm -rf downloads/ 2>/dev/null | tee -a "$log_file"
	mkdir downloads/ | tee -a "$log_file"
	cd downloads/ || exit
	bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
	cd ..
	echo "[Editor Installer] : ----------------------" | tee -a "$log_file"

	requiredCommands nvim

	if [ "$no_providers" != 1 ]; then
		echo "" | tee -a "$log_file"
		echo "[Editor Installer] : Installing Providers for NeoVim..." | tee -a "$log_file"
		sudo npm install -g neovim | tee -a "$log_file"
		sudo npm install -g tree-sitter-cli | tee -a "$log_file"
		sudo npm install -g eslint | tee -a "$log_file"
		sudo npm install -g prettier | tee -a "$log_file"
		sudo npm install -g emmet-ls | tee -a "$log_file"
		sudo npm install -g bash-language-server | tee -a "$log_file"
		pip install black | tee -a "$log_file"
		pip3 install -U pynvim | tee -a "$log_file"
		python3 -m pip install --user --upgrade pynvim | tee -a "$log_file"
		pip3 install -U msgpack-python | tee -a "$log_file"
		python3 -mpip install --user -U msgpack | tee -a "$log_file"
		yarn install --froken-lockfile | tee -a "$log_file"
		echo "[Editor Installer] : ----------------------" | tee -a "$log_file"
	fi

	echo "" | tee -a "$log_file"

	echo "[Editor Installer] : Configuring tools GIT with Vim..." | tee -a "$log_file"
	git config --global core.editor lvim | tee -a "$log_file"
	git config --global diff.tool vimdiff | tee -a "$log_file"
	git config --global merge.tool vimdiff | tee -a "$log_file"
	echo "[Editor Installer] : ----------------------" | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Editor Installer] : Install LunarVim..." | tee -a "$log_file"
	LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh) --yes --install-dependencies

	echo "[Editor Installer] : - Copying configuration LunarVim..." | tee -a "$log_file"
	cp ./config/config.lua ~/.config/lvim/. | tee -a "$log_file"
	mkdir -p ~/.config/lvim/lsp-settings/ | tee -a "$log_file"
	cp ./config/gopls.json ~/.config/lvim/lsp-settings/. | tee -a "$log_file"
	cp ./config/.golangci.yml ~/. | tee -a "$log_file"
	sudo cp ./config/lvim.desktop /usr/local/share/applications/lvim.desktop | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Editor Installer] : ----------------------" | tee -a "$log_file"

	echo "[Editor Installer] : + Install plugins editor..." | tee -a "$log_file"

	# echo "[Editor Installer] : - ... PackerSync" | tee -a "$log_file"
	# lvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync" &>/dev/null

	echo "[Editor Installer] : - ... LvimUpdate" | tee -a "$log_file"
	lvim --headless -c "LvimUpdate" -c "qall" &>/dev/null

	echo "[Editor Installer] : - ... GoInstallBinaries" | tee -a "$log_file"
	lvim --headless -c "GoInstallBinaries" -c "qall" &>/dev/null

	echo "[Editor Installer] : - ... UpdateRemotePlugins" | tee -a "$log_file"
	lvim --headless -c "UpdateRemotePlugins" -c "qall" &>/dev/null

	echo "[Editor Installer] : - ... LuaCacheClear" | tee -a "$log_file"
	lvim --headless -c "LuaCacheClear" -c "qall" &>/dev/null

	go install github.com/klauspost/asmfmt/cmd/asmfmt@latest
	go install github.com/mrtazz/checkmake/cmd/checkmake@latest
	go install github.com/klauspost/asmfmt/cmd/asmfmt@latest
	go install github.com/bufbuild/buf/cmd/buf@latest
	go install mvdan.cc/sh/v3/cmd/shfmt@latest
	go install mvdan.cc/gofumpt@latest
	go install golang.org/x/tools/gopls@latest
	go install github.com/mgechev/revive@latest
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b "$(go env GOPATH)"/bin

	echo "[Editor Installer] : + Installation Editor successful! +" | tee -a "$log_file"
	echo "[Editor Installer] : (Read ~/.config/lvim/config.lua to run the necessary commands in the editor)" | tee -a "$log_file"
	echo "[Editor Installer] : (Run :PackerSync in lvim)" | tee -a "$log_file"

	echo "" | tee -a "$log_file"
}

# installConsole install console and tools
installConsole() {
	echo "dark" >~/.mode | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Console Installer] : Installing tools..." | tee -a "$log_file"

	sudo apt install -y zsh

	echo "" | tee -a "$log_file"
	echo "[Console Installer] : Configuring Zsh... enter your sudo or root password" | tee -a "$log_file"
	[[ "$SHELL" != *"zsh" ]] && chsh -s "$(command -v zsh)" | tee -a "$log_file"

	sudo apt remove -y --purge alacritty 2>/dev/null | tee -a "$log_file"
	sudo apt remove -y --purge tmux 2>/dev/null | tee -a "$log_file"
	sudo snap remove --purge alacritty 2>/dev/null | tee -a "$log_file"
	sudo snap remove --purge tmux 2>/dev/null | tee -a "$log_file"
	sudo rm "$(command -v alacritty)" | tee -a "$log_file"
	sudo rm "$(command -v tmux)" | tee -a "$log_file"

	sudo apt install -y fonts-powerline curl git cmus tmux git-flow shellcheck exiftool rar fzf byacc autoconf automake pkg-config libevent-dev libncurses5-dev libncursesw5-dev libncurses5 | tee -a "$log_file"
	sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 | tee -a "$log_file"

	sudo snap install alacritty --classic | tee -a "$log_file"
	sudo update-desktop-database
	echo "[Console Installer] : ----------------------" | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Console Installer] : Adding yarn key, Updating yarn" | tee -a "$log_file"
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - &>/dev/null

	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

	curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

	sudo apt update 1>/dev/null | tee -a "$log_file"
	sudo apt install -y yarn 1>/dev/null | tee -a "$log_file"
	echo "[Console Installer] : ----------------------" | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Console Installer] : Downloading Tmux Plugin Manager..." | tee -a "$log_file"
	sudo rm -rf ~/.tmux/plugins | tee -a "$log_file"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 1>/dev/null | tee -a "$log_file"

	echo "[Console Installer] : - Copying configuration Alacritty..." | tee -a "$log_file"
	mkdir -p ~/.config/alacritty 2>/dev/null | tee -a "$log_file"
	cp ./config/alacritty.yml ~/.config/alacritty/. | tee -a "$log_file"

	echo "[Console Installer] : - Copying configuration Tmux..." | tee -a "$log_file"
	cp ./config/.tmux.conf ~/. | tee -a "$log_file"
	echo "[Console Installer] : ----------------------" | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Console Installer] : Installing Tmux Plugins..." | tee -a "$log_file"
	bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh | tee -a "$log_file"
	echo "[Console Installer] : ----------------------" | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Console Installer] : Installing Oh My ZSH!..." | tee -a "$log_file"
	curl -L http://install.ohmyz.sh 2>/dev/null | sh | tee -a "$log_file"
	wget --no-check-certificate http://install.ohmyz.sh -O - | sh | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Console Installer] : ----------------------" | tee -a "$log_file"
	echo "[Console Installer] : Configuring Zsh Plugins..." | tee -a "$log_file"
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting | tee -a "$log_file"
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions | tee -a "$log_file"
	echo "[Console Installer] : ----------------------" | tee -a "$log_file"

	echo "[Console Installer] : - Copying configuration Zsh..." | tee -a "$log_file"
	cp ./config/.zshrc.arthurnavah ~/.zshrc.arthurnavah | tee -a "$log_file"
	touch ~/.zshrc
	# if they are different, add 'source' command to the end of the file
	[ ! -f ~/.zshrc ] && touch ~/.zshrc
	if [ -n "$(diff ~/.zshrc ~/.zshrc.arthurnavah 2>/dev/null)" ]; then
		exist_source=$(awk '$0 ~ "source ~/.zshrc.arthurnavah" { print }' ~/.zshrc 2>/dev/null)

		if [ -z "$exist_source" ]; then
			echo "source ~/.zshrc.arthurnavah" >>~/.zshrc
		fi
	fi

	echo "[Console Installer] : - Install fzf..." | tee -a "$log_file"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --all
	echo "[Console Installer] : ----------------------" | tee -a "$log_file"

	echo "" | tee -a "$log_file"
	echo "[Console Installer] : + Installation Console successful! (Restarting the computer to use Zsh for the first time) +" | tee -a "$log_file"
}

main "$@"

unset now
unset log_file
unset concatMissingCommand
unset no_providers
unset install_all
unset install_editor
unset install_console
