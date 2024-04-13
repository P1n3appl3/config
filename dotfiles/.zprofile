if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec systemd-cat -t sway sway
fi
