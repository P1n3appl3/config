export ZSH=/home/joseph/.oh-my-zsh

POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs newline)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator command_execution_time)
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=()
# ZLE_RPROMPT_INDENT=0

alias ls=colorls
alias zshconfig="vi $HOME/.zshrc"
alias vimconfig="vi $HOME/.config/nvim/config/* -p"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias cat=bat
alias o=xdg-open
cs() { cd "$@" && clear && ls; }

source $ZSH/oh-my-zsh.sh
source /etc/zsh_command_not_found
neofetch

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
