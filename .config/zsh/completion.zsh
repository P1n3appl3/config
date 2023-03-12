zmodload zsh/complist # only necessary on "systems with dynamic loading"?
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $HOME/.cache/zsh
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|=*' 'l:|=* r:|=*'
autoload -U bashcompinit && bashcompinit
autoload -U compinit && compinit
