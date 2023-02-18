bindkey -e
_zle_load() { autoload -U $1 && zle -N $1; }
zle-line-init() { echoti smkx; } && zle -N zle-line-init
zle-line-finish() { echoti rmkx; } && zle -N zle-line-finish
_zle_load up-line-or-beginning-search
_zle_load down-line-or-beginning-search
bindkey ${terminfo[kcuu1]} up-line-or-beginning-search   # up
bindkey ${terminfo[kcud1]} down-line-or-beginning-search # down
_zle_load edit-command-line
bindkey '^[[101;6u' edit-command-line        # ctrl+shift+e
bindkey '^[[3~' delete-char                  # del
bindkey '^[[3;5~' kill-word                  # ctrl+del
bindkey '^H' backward-kill-word              # ctrl+backspace
bindkey '^[[1;5D' backward-word              # ctrl+left
bindkey '^[[1;5C' emacs-forward-word         # ctrl+right
bindkey ${terminfo[khome]} beginning-of-line # home
bindkey ${terminfo[kend]} end-of-line        # end
bindkey '^[[Z' reverse-menu-complete         # shift+tab
bindkey '^R' _atuin_search_widget
bindkey -r '^J'

# backwards-word should go to the end of the last word
zle -N backward-word backward-word-end
backward-word-end() {
    zle .backward-word && ((CURSOR)) || return
    zle .backward-word && zle emacs-forward-word
}
