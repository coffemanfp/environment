# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="avit"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

LS_COLORS="di=1;31"

# Load alias
[ -f ~/.alias ] && source ~/.alias

# Load mode
[ -f ~/.mode ] && export MODE=$(cat ~/.mode)

# Load FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias lightmode="echo 'light' > ~/.mode ; \
    export MODE=light; \
    tmux setenv MODE light &>/dev/null; \
    bash ~/.tmux/plugins/tmux-onedark-theme/tmux-onedark-theme.tmux &>/dev/null; \
    bash ~/.tmux/plugins/tmux-battery/battery.tmux &>/dev/null;"

alias darkmode="echo 'dark' > ~/.mode; \
    export MODE=dark; \
    tmux setenv MODE dark &>/dev/null; \
    bash ~/.tmux/plugins/tmux-onedark-theme/tmux-onedark-theme.tmux &>/dev/null; \
    bash ~/.tmux/plugins/tmux-battery/battery.tmux &>/dev/null;"

alias li=lightmode
alias da=darkmode
