# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="avit"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Load alias
[ -f ~/.alias ] && source ~/.alias

# Load mode
[ -f ~/.mode ] && export MODE=$(cat ~/.mode)

# Load FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias lightmode="echo 'light' > ~/.mode ; export MODE=light"
alias darkmode="echo 'dark' > ~/.mode ; export MODE=dark"

alias li=lightmode
alias da=darkmode
