export ZSH=/home/joseph/.oh-my-zsh
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs newline)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator command_execution_time)
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=()
# ZLE_RPROMPT_INDENT=0

alias ls=colorls
alias zshconfig="vi ~/.zshrc"
alias vimconfig="vi ~/.config/nvim/init.vim"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
cs() { cd "$@" && clear && ls; }

source $ZSH/oh-my-zsh.sh
source /etc/zsh_command_not_found


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
