export ZSH=/home/joseph/.oh-my-zsh

POWERLEVEL9K_MODE="nerdfont-complete"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator command_execution_time)

ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(
  gitfast
  python
)

ZLE_RPROMPT_INDENT=0

alias ls=colorls
alias zshconfig="vi ~/.zshrc"
alias vimconfig="vi ~/.config/nvim/init.vim"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

source $ZSH/oh-my-zsh.sh
source /etc/zsh_command_not_found
source /opt/ros/kinetic/setup.zsh

