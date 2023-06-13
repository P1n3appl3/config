give-me-a-ping-vasily() { # One Ping Only...
    echo -n "Ping: "
    ping -qc1 -W1 $1 2>&1 | awk -F'/' 'END{ print (/^rtt/? "OK "$5" ms":"FAIL") }'
}

source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

export {EDITOR,VISUAL}=nvim

path_add() { remove=($1); path=($1 ${path:|remove}); }
path_add_once() { if ! (($path[(Ie)$1])); then path_add $1; fi; }

path_add_once $HOME/.nix-profile/bin
path_add $HOME/.cargo/bin
path_add $HOME/.local/bin
