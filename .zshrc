export ZSH=/home/joseph/.oh-my-zsh

POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs newline)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator command_execution_time)
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=()
# ZLE_RPROMPT_INDENT=0

# You better have python 3
alias python=python3
alias pip=pip3

# And rust
alias grep=rg
alias cat=bat
alias find=fd

alias zshconfig="vi $HOME/.zshrc"
alias vimconfig="vi $HOME/.config/nvim/init.vim"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias o=xdg-open
alias ls=colorls
cs() { cd "$@" && clear && ls; }

source $ZSH/oh-my-zsh.sh
source /etc/zsh_command_not_found
neofetch

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
