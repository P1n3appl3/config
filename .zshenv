give-me-a-ping-vasily() { # One Ping Only...
    echo -n "Ping: "
    ping -qc1 -W1 $1 2>&1 | awk -F'/' 'END{ print (/^rtt/? "OK "$5" ms":"FAIL") }'
}

path_add() { ((!$path[(Ie)$1])) && path=($1 $path); }

path_add $HOME/.local/bin
path_add $HOME/.cargo/bin

unset __HM_SESS_VARS_SOURCED
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

export {EDITOR,VISUAL}=nvim
