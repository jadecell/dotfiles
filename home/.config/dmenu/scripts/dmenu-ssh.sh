#!/usr/bin/env bash

# Source all the settings
. $HOME/.config/dmenu/settings

declare options=("mccrory.xyz
jacksonmccrory.com")

choice=$(echo -e "${options[@]}" | dmenu -h $DMENU_CUSTOM_HEIGHT -p 'SSH to: ' -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -n)

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
