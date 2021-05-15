# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME="avit"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Load alias
[ -f ~/.alias ] && source ~/.alias

# Load FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
