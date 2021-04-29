#!/usr/bin/env bash

# Source all the settings
. $HOME/.config/dmenu/settings

declare options=("mccrory.xyz
jacksonmccrory.com")

choice=$(echo -e "${options[@]}" | dmenu $DMENU_ARGUMENTS -p 'SSH to: ')

case "$choice" in
    quit)
        echo "Program terminated." && exit 1
    ;;
    "jacksonmccrory.com")
        choice="jacksonmccrory.com"
    ;;
    "mccrory.xyz")
        choice="mccrory.xyz"
    ;;
esac

st -e ssh $(whoami)@$choice
