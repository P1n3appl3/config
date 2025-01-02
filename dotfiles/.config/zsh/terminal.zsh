# This is mostly taken from kitty's shell integration docs. The subset of
# features used here should work with wezterm and ghostty as well:
# - OSC133 prompt awareness
# - changing window title to current dir/host/command
# - changing cursor shape to line in the line editor
# https://sw.kovidgoyal.net/kitty/shell-integration/#how-it-works
# https://wezfurlong.org/wezterm/shell-integration.html
# https://ghostty.org/docs/features/shell-integration

typeset -gi _tty_fd
{
    zmodload zsh/system && {
        { [[ -w $TTY     ]] && sysopen -o cloexec -wu _tty_fd -- $TTY     } ||
        { [[ -w /dev/tty ]] && sysopen -o cloexec -wu _tty_fd -- /dev/tty }
    }
} 2>/dev/null || (( _tty_fd = 1 ))

typeset -gi _prompt_state
_prompt_precmd() {
    local -i cmd_status=$?
    if ! zle; then
        if (( _prompt_state == 1 )); then
            print -nu $_tty_fd '\e]133;D;'$cmd_status'\a'
            (( _prompt_state = 2 ))
        elif (( _prompt_state == 2 )); then
            print -nu $_tty_fd '\e]133;D\a'
        fi
    fi

    local mark1=$'%{\e]133;A\a%}'
    if [[ -o prompt_percent ]]; then
        typeset -g precmd_functions
        if [[ ${precmd_functions[-1]} == _prompt_precmd ]]; then
            local mark2=$'%{\e]133;A;k=s\a%}'
            [[ $PS1 == *$mark1* ]] || PS1=${mark1}${PS1}
            [[ $PS2 == *$mark2* ]] || PS2=${mark2}${PS2}
            (( _prompt_state = 2 ))
        else
            precmd_functions=(${precmd_functions:#_prompt_precmd} _prompt_precmd)
            if ! zle; then
                print -rnu $_tty_fd -- $mark1[3,-3]
                (( _prompt_state = 2 ))
            fi
        fi
    elif ! zle; then
        print -rnu $_tty_fd -- $mark1[3,-3]
        (( _prompt_state = 2 ))
    fi
}

_prompt_preexec() {
    PS1=${PS1//$'%{\e]133;A\a%}'}
    PS2=${PS2//$'%{\e]133;A;k=s\a%}'}
    print -nu $_tty_fd '\e]133;C\a'
    (( _prompt_state = 1 ))

    print -nu $_tty_fd '\e[1 q' # block cursor
}

# use "application mode" inside the line editor so keybinds don't change
zle-line-init() {
    print -nu "$_tty_fd" '\e[5 q' # line cursor
    echoti smkx
}
zle-line-finish() { echoti rmkx; }
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    zle -N zle-line-init && zle -N zle-line-finish
fi

local is_ssh_session="n"
if [[ -n "$KITTY_PID" ]]; then
elif [[ -n "$SSH_TTY" ]]; then
    is_ssh_session="y"
elif [[ -n "$(command -v who)" ]]; then
    [[ "$(command who -m 2> /dev/null)" =~ "\([a-fA-F.:0-9]+\)$" ]] && is_ssh_session="y"
fi

if [[ "$is_ssh_session" == "y" ]]; then
    functions[_prompt_precmd]+="
        print -Prnu $_tty_fd \$'\\e]2;'\"%m: \${(%):-%(4~|…/%3~|%~)}\"\$'\\a'"
    functions[_prompt_preexec]+="
        print -Prnu $_tty_fd \$'\\e]2;'\"%m: \${(V)1}\"\$'\\a'"
else
    functions[_prompt_precmd]+="
        print -rnu $_tty_fd \$'\\e]2;'\"\${(%):-%(4~|…/%3~|%~)}\"\$'\\a'"
    functions[_prompt_preexec]+="
        print -rnu $_tty_fd \$'\\e]2;'\"\${(V)1}\"\$'\\a'"
fi

preexec_functions+=(_prompt_preexec)
precmd_functions+=(_prompt_precmd)
