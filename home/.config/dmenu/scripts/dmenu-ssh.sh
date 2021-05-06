#!/usr/bin/env bash

# Source all the settings
. $HOME/.config/dmenu/settings

declare options=("quit
mccrory.xyz
jacksonmccrory.com")

choice=$(echo -e "${options[@]}" | dmenu $DMENU_ARGUMENTS -p 'SSH to: ')

case "$choice" in
    quit)
        echo "Program terminated." && exit 1
    ;;
esac

[ -n "$choice" ] && st -e ssh "$(whoami)@$choice"
