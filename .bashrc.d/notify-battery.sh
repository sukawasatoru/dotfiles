#!/usr/bin/env bash

set -eu

SCRIPTDIR=$(dirname $0)

source $SCRIPTDIR/.env

OUTPUT=$(pmset -g ps | grep discharging -)
BATTERY=$(sed -e "s/.*	\([0-9]*\)%;.*/\1/" <<<"$OUTPUT")
REMAINING=$(sed -e "s/.*; \([0-9:]* remaining present\).*/\1/" <<<"$OUTPUT")

PAYLOAD=$(cat <<EOM
payload={
    "icon_emoji": ":computer:",
    "username": "vieena-mac2",
    "text": "Battery: $BATTERY%, $REMAINING"
}
EOM
)

if [[ -n "$BATTERY" ]] && [[ $BATTERY -le 40 ]]; then
    [[ $(command -v terminal-notifier) ]] && terminal-notifier -message "Battery: $BATTERY"
    if ping -c2 -t10 hooks.slack.com > /dev/null; then
        curl -sd "$PAYLOAD" "$NOTIFY_BATTERY_URL" > /dev/null
    fi
fi
