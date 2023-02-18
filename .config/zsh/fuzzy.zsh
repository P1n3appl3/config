export FZF_DEFAULT_OPTS="--reverse --bind=ctrl-z:ignore
 --preview-window=down --height=60% --inline-info
 --bind 'ctrl-p:change-preview-window(hidden|down)'
 --bind ctrl-r:first --bind alt-up:first --bind alt-down:last
 --bind shift-up:preview-page-up --bind shift-down:preview-page-down
 --bind ctrl-d:half-page-down --bind ctrl-u:half-page-up"
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir j ji tree"
# TODO: bind ctrl-backspace (instead of alt) to delete last word
# https://github.com/junegunn/fzf/issues/2057

# TODO: https://github.com/junegunn/fzf/issues/3159#issuecomment-1424575660
# something like --bind 'backward-eof:reload(__fzf "$(pwd)/.." $2)'
__fzf() {
    setopt localoptions pipefail
    local item
    fd -H --mount --color=always --type $1 |
        fzf --multi --height=80% --ansi \
            --preview "$HOME/.config/scripts/preview.sh {}" \
            --bind "ctrl-/:reload(fd . / --mount -t$1)" \
            --bind "ctrl-h:reload(fd . ~ --mount -t$1)" \
            --bind "ctrl-w:reload(fd --mount -t$1)" |
        while read item; do
            echo -n "${(q)item} " # https://github.com/mvdan/sh/issues/960
        done
    local ret=$? && echo && return $ret
}
fzf-file-widget() {
    LBUFFER="${LBUFFER}$(__fzf f)"
    local ret=$? && zle reset-prompt && return $ret
}
fzf-dir-widget() {
    LBUFFER="${LBUFFER}$(__fzf d)"
    local ret=$? && zle reset-prompt && return $ret
}
zle -N fzf-file-widget && bindkey '^F' fzf-file-widget
zle -N fzf-dir-widget && bindkey '^G' fzf-dir-widget

_fzf_compgen_path() { fd -H --mount . "$1"; }
_fzf_compgen_dir() { fd -H --mount -td . "$1"; }
_fzf_comprun() {
    local command=$1 && shift
    case "$command" in
    j) fzf --preview "exa --icons {}" "$@" ;;
    export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
    ssh) fzf --preview 'give-me-a-ping-vasily {}; dog --color=always {}' "$@" ;;
    *) fzf "$@" ;;
    esac
}

_fzf_complete_paru() { _fzf_complete -m -n1 -- "$@" < <(paru -Pc); }
_fzf_complete_paru_post() { awk '{print $1}'; }
