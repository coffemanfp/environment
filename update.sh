#!/bin/bash
mkdir logs &>/dev/null
now=$(date +"%F+%T")
log_file="$PWD/logs/update-$now.log"
rm -rf logs/update-* &>/dev/null
update_all=0

if [ ! -x "$0" ]; then
	echo "[Updater Error] : Execute permissions are required (+x)" | tee -a "$log_file"
	echo "exit 1" | tee -a "$log_file"
	exit 1
fi

main() {
	# check install all
	if [ "$update_all" == 1 ]; then
		update_editor=1
		update_console=1
	fi

	if [ "$update_editor" != 1 ] && [ "$update_console" != 1 ]; then
		echo "[Updater Error] : List of update:"
		echo -e "\tall" | tee -a "$log_file"
		echo -e "\teditor" | tee -a "$log_file"
		echo -e "\tconsole" | tee -a "$log_file"
		echo "exit 1" | tee -a "$log_file"
		exit 1
	fi

	requiredCommands git
	git pull origin master | tee -a "$log_file"

	# check requireds
	if [ "$update_editor" == 1 ]; then
		requiredSudoCommands snap
		requiredCommands nvim node npm

		#--- check node version
		nodeVersion="$(node --version | cut -d'.' -f1)"
		nodeVersion="${nodeVersion#'v'}"
		if [ "$nodeVersion" -lt 11 ]; then
			echo "[Editor Updater Error] : NodeJs version must be higher than v11.0.0 ( >= v12.0.0 )" | tee -a "$log_file"
			echo "exit 1" | tee -a "$log_file"
			exit 1
		fi

		#--- check go env
		if [ -z "$(go env GOROOT)" ]; then
			echo "[Editor Updater Error] : The GOROOT environment variable is not set" | tee -a "$log_file"
			echo "exit 1" | tee -a "$log_file"
			exit 1
		fi
		if [ -z "$(go env GOPATH)" ]; then
			echo "[Editor Updater Error] : The GOPATH environment variable is not set" | tee -a "$log_file"
			echo "exit 1" | tee -a "$log_file"
			exit 1
		fi
	fi
	if [ "$update_console" == 1 ]; then
		requiredSudoCommands snap apt
	fi

	echo "" | tee -a "$log_file"
	echo "[Fonts Updater] : Updating fonts..." | tee -a "$log_file"
	sudo mkdir -p /usr/local/share/fonts/arthurnavah-fonts | tee -a "$log_file"
	sudo cp ./fonts/* /usr/local/share/fonts/arthurnavah-fonts/. | tee -a "$log_file"
	sudo fc-cache -f -v &>/dev/null | tee -a "$log_file"
	echo "[Fonts Updater] : ----------------------" | tee -a "$log_file"

	# installs
	if [ "$update_console" == 1 ]; then
		echo "[Console Updater] : Update Console..." | tee -a "$log_file"

		updateConsole
	fi

	if [ "$update_editor" == 1 ]; then
		echo "[Editor Updater] : Update Editor..." | tee -a "$log_file"

		updateEditor
	fi
}

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
	eval update_"$p"=1
done
if [ "$#" == 0 ]; then
	update_editor=1
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
		echo "[Updater Error] : Commands are required:" | tee -a "$log_file"
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
		echo "[Updater Error] : Commands with SUDO are required:" | tee -a "$log_file"
		echo -e "$concatMissingCommand" | tee -a "$log_file"
		echo "exit 1" | tee -a "$log_file"
		exit 1
	fi
}

# updateEditor update editor
updateEditor() {
	sudo add-apt-repository -y ppa:jonathonf/vim
	sudo apt update
	sudo apt install -y --only-upgrade vim | tee -a "$log_file"

	rm -rf downloads/ 2>/dev/null | tee -a "$log_file"
	mkdir downloads/ | tee -a "$log_file"
	cd downloads/ || exit
	# curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage | tee -a "$log_file"
	# chmod u+x nvim.appimage | tee -a "$log_file"
	# ./nvim.appimage --appimage-extract | tee -a "$log_file"
	# ./squashfs-root/AppRun --version | tee -a "$log_file"
	# sudo rm -rf /nvim-arthurnavah/ | tee -a "$log_file"
	# sudo rm /usr/bin/nvim | tee -a "$log_file"
	# sudo mv squashfs-root /nvim-arthurnavah && sudo ln -s /nvim-arthurnavah/AppRun /usr/bin/nvim | tee -a "$log_file"
	bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
	cd ..

	# copy configurations
	cp ./config/config.lua ~/.config/lvim/. | tee -a "$log_file"
	mkdir -p ~/.config/lvim/lsp-settings/ | tee -a "$log_file"
	cp ./config/gopls.json ~/.config/lvim/lsp-settings/. | tee -a "$log_file"
	cp ./config/.golangci.yml ~/. | tee -a "$log_file"
	# cp ./config/revive.toml ~/. | tee -a "$log_file"
	sudo cp ./config/lvim.desktop /usr/local/share/applications/lvim.desktop | tee -a "$log_file"

	echo "[Editor Updater] : - Install plugins..." | tee -a "$log_file"
	# lvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync" &>/dev/null
	lvim --headless -c "LvimUpdate" -c "qall" &>/dev/null
	lvim --headless -c "GoInstallBinaries" -c "qall" &>/dev/null
	lvim --headless -c "UpdateRemotePlugins" -c "qall" &>/dev/null
	lvim --headless -c "LuaCacheClear" -c "qall" &>/dev/null
	lvim --headless -c "TSUpdateSync" -c "qall" &>/dev/null
	lvim --headless -c "GoUpdateBinaries" -c "qall" &>/dev/null
	lvim --headless -c "LuaCacheClear" -c "qall" &>/dev/null

	echo "" | tee -a "$log_file"
	echo "[Editor Updater] : + Update editor successful! +" | tee -a "$log_file"
	echo "[Editor Updater] : (Read ~/.config/lvim/config.lua to run the necessary commands in the editor)" | tee -a "$log_file"
	echo "[Editor Updater] : (Run :PackerSync in lvim)" | tee -a "$log_file"

	echo "" | tee -a "$log_file"
}

# updateConsole update console
updateConsole() {
	sudo apt install -y --only-upgrade zsh tmux | tee -a "$log_file"
	sudo snap refresh alacritty | tee -a "$log_file"

	# copy configurations
	cp config/alacritty.yml ~/.config/alacritty/. | tee -a "$log_file"

	cp ./config/.zshrc.arthurnavah ~/.zshrc.arthurnavah | tee -a "$log_file"
	# if they are different, add 'source' command to the end of the file
	[ ! -f ~/.zshrc ] && touch ~/.zshrc
	if [ -n "$(diff ~/.zshrc ~/.zshrc.arthurnavah 2>/dev/null)" ]; then
		exist_source=$(awk '$0 ~ "source ~/.zshrc.arthurnavah" { print }' ~/.zshrc 2>/dev/null)

		if [ -z "$exist_source" ]; then
			echo "source ~/.zshrc.arthurnavah" >>~/.zshrc
		fi
	fi

	cp config/.tmux.conf ~/. | tee -a "$log_file"

	bash ~/.tmux/plugins/tpm/scripts/update_plugins.sh | tee -a "$log_file"

	echo "[Console Updater] : + Update console successful! +" | tee -a "$log_file"
}

main "$@"

unset now
unset log_file
unset concatMissingCommand
unset update_all
unset update_editor
unset update_console
