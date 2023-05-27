bindkey -e

_zle_load() { autoload -U $1 && zle -N $1; }
_zle_load up-line-or-beginning-search
_zle_load down-line-or-beginning-search
bindkey ${terminfo[kcuu1]} up-line-or-beginning-search   # up
bindkey ${terminfo[kcud1]} down-line-or-beginning-search # down
_zle_load edit-command-line
bindkey '\e[101;6u' edit-command-line        # ctrl+shift+e
bindkey '\e[3~' delete-char                  # del
bindkey '\e[3;5~' kill-word                  # ctrl+del
bindkey '^H' backward-kill-word              # ctrl+backspace
bindkey '\e[1;5D' backward-word              # ctrl+left
bindkey '\e[1;5C' emacs-forward-word         # ctrl+right
# TODO: define alt+{del,backspace,left,right} with different WORDCHARS
bindkey ${terminfo[khome]} beginning-of-line # home
bindkey ${terminfo[kend]} end-of-line        # end
bindkey '\e[Z' reverse-menu-complete         # shift+tab
bindkey -r '^J' '^T'

# make "backwards-word" go to the end of the last word
zle -N backward-word backward-word-end
backward-word-end() {
    zle .backward-word && ((CURSOR)) || return
    zle .backward-word && zle emacs-forward-word
}
