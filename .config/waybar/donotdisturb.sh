#!/bin/bash
notify-send "$(mpc current)"
echo "yo bois"
exit
if [ -e /tmp/donotdisturb ]
then
    #notify-send DUNST_COMMAND_PAUSE
    rm /tmp/donotdisturb
    echo " paused\n\n"
else
    #notify-send DUNST_COMMAND_RESUME
    touch /tmp/donotdisturb
    echo " unpaused\n\n"
fi
