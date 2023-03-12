#!/usr/bin/env bash

# Yoinked from https://github.com/chebro/calendar-notification

send_notification() {
    BODY=$(cal "$1")
    HEAD=$(date '+%D')
    if [ "$1" = today ]; then
        TODAY=$(date '+%-d')
        BODY=$(echo "$BODY" | sed -z "s|$TODAY|<u><b>$TODAY</b></u>|1")
    fi
    dunstify -h string:x-canonical-private-synchronous:calendar \
        "Today: $HEAD" "\n$BODY" -u NORMAL
}

TMP=${XDG_RUNTIME_DIR:-/tmp}/"$UID"_calendar_notification_month
touch "$TMP"

DIFF=$(<"$TMP")

case $1 in
"curr") DIFF=0 ;;
"next") DIFF=$((DIFF + 1)) ;;
"prev") DIFF=$((DIFF - 1)) ;;
esac
echo "$DIFF" >"$TMP"

if [ "$DIFF" -gt 0 ]; then
    send_notification "+$DIFF months"
elif [ "$DIFF" -lt 0 ]; then
    send_notification "$((-DIFF)) months ago"
else
    send_notification today
fi
