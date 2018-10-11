POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs newline)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator command_execution_time)
source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme

alias zshconfig="vi $HOME/.zshrc"
alias vimconfig="vi $HOME/.config/nvim/init.vim"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

/usr/share/fzf/key-bindings.zsh
/usr/share/fzf/completions.zsh

# Colorize man
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Fix keybinds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;2C" forward-word
bindkey "^[[1;2D" backward-word
bindkey "\e[3~" delete-char

# You better have nvim
export VISUAL=nvim
export EDITOR=nvim
alias vi=nvim
alias vim=nvim

# And rust
alias grep=rg
alias cat=bat
alias find=fd
alias ls=exa
export TERMINAL=alacritty

alias o=xdg-open
alias cs=colorls

neofetch
