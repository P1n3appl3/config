# Initialize oh-my-zsh and my powerline theme
export ZSH="/home/joseph/.oh-my-zsh"
export ZSH_THEME="powerlevel9k/powerlevel9k"
DISABLE_UPDATE_PROMPT=true
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir_writable dir vcs newline)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs)
plugins=(
colored-man-pages
command-not-found
z
fzf
fzf-z
zsh-completions
zsh-autosuggestions
zsh-syntax-highlighting
)
autoload -U compinit && compinit
source $ZSH/oh-my-zsh.sh

# Add language stuff to path
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"

# Shortcuts for tweaking dotfiles
alias i3config="vi $HOME/.config/i3/*"
alias vimconfig="vi $HOME/.config/nvim/*"
alias zshconfig="vi $HOME/.zshrc"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# I <3 Rust
alias grep=rg
alias cat=bat
alias find=fd
alias ls=exa
export TERMINAL=alacritty

# Disable plugins when pasting (don't try to syntax highlight till its done)
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# Misc.
alias o=xdg-open
alias so=source
alias cs=colorls
alias pac="pakku -Syu"
alias paclist="pacman -Qqs"
alias sc=systemctl
export EDITOR=nvim
export VISUAL=nvim

# FZF
source /usr/share/fzf/key-bindings.zsh
export FZF_DEFAULT_COMMAND="fd . ~ --hidden --exclude '{.git,.cache}'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type f"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

neofetch
