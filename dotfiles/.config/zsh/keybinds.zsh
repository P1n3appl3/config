# good resource for when you forget how all this works again:
# https://sgeb.io/posts/zsh-zle-custom-widgets

bindkey -e
_zle_load() { autoload -U $1 && zle -N $1; }
_zle_load up-line-or-beginning-search
_zle_load down-line-or-beginning-search
bindkey ${terminfo[kcuu1]} up-line-or-beginning-search   # up
bindkey ${terminfo[kcud1]} down-line-or-beginning-search # down
bindkey '^J' up-line-or-beginning-search
bindkey '^K' up-line-or-beginning-search
bindkey '^L' emacs-forward-word
_zle_load edit-command-line
bindkey '^E' edit-command-line
bindkey '^Z' end-of-line
bindkey '\e[3~' delete-char                  # del
bindkey '\e[3;5~' kill-word                  # ctrl+del
bindkey '^H' backward-kill-word              # ctrl+backspace
bindkey '\e[1;5D' backward-word              # ctrl+left
bindkey '\e[1;5C' emacs-forward-word         # ctrl+right
bindkey ${terminfo[khome]} beginning-of-line # home
bindkey ${terminfo[kend]} end-of-line        # end
bindkey '\e[Z' reverse-menu-complete         # shift+tab
_zle_load copy-earlier-word
bindkey '^[.' copy-earlier-word

SHIFT_WORDCHARS=WORDCHARS # *?_-.[]~=/&;!#$%^(){}<>
WORDCHARS='_.$<>'
backward-kill-blank-word() WORDCHARS='' zle .backward-kill-word
forward-small-word() WORDCHARS=$SHIFT_WORDCHARS zle .forward-word
backward-small-word() WORDCHARS=$SHIFT_WORDCHARS zle .backward-word

_zle_bind() { bindkey $1 $2 && zle -N $2; }
_zle_bind '\e^?' backward-kill-blank-word # alt+esc
bindkey '\e[1;3D' vi-backward-blank-word  # alt+left
bindkey '\e[1;3C' vi-forward-blank-word   # alt+right
_zle_bind '\e[1;2D' backward-small-word   # shift+left
_zle_bind '\e[1;2C' forward-small-word    # shift+right
