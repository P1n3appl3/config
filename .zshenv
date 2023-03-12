export give-me-a-ping-vasily() { # One Ping Only...
    echo -n "Ping: "
    ping -qc1 -W1 $1 2>&1 | awk -F'/' 'END{ print (/^rtt/? "OK "$5" ms":"FAIL") }'
}

export {EDITOR,VISUAL}=nvim
