eval "$(atuin init zsh --disable-up-arrow)" # History
eval "$(zoxide init zsh --cmd j)"           # Dir jumper
eval "$(starship init zsh)"                 # Prompt

source $HOME/.nix-profile/share/fzf/completion.zsh
for f in zsh-syntax-highlighting zsh-autosuggestions; do
    source $HOME/.nix-profile/share/$f/$f.zsh
done

copy_function() {
    test -n "$(declare -f "$1")" || return
    eval "${_/$1/$2}"
}
copy_function _direnv_hook _direnv_hook__old
_direnv_hook() {
    _direnv_hook__old "$@" 2> >(awk '{if (length >= 10) \
        { sub("^direnv: export.*", "direnv: export "NF" environment variables")}}1')
    wait
}

eval "$(direnv hook zsh)"
