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

alias lightmode="echo 'light' > ~/.mode ; export MODE=light ; tmux setenv MODE light ; tmux source-file ~/.tmux.conf"
alias darkmode="echo 'dark' > ~/.mode ; export MODE=dark ; tmux setenv MODE dark; tmux source-file ~/.tmux.conf"

alias li=lightmode
alias da=darkmode
