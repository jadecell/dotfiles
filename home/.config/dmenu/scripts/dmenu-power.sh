#!/usr/bin/env sh

# Source all the settings
. $HOME/.config/dmenu/settings

Menu='power off
reboot'

Chosen=$(printf "$Menu" | dmenu -h $DMENU_CUSTOM_HEIGHT -p 'Power' -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s)

if [ "$Chosen" = 'power off' ]; then
    ~/.config/dmenu/scripts/dmenu-prompt.sh "Confirm $Chosen?" 'loginctl poweroff'
elif [ "$Chosen" = 'reboot' ]; then
    ~/.config/dmenu/scripts/dmenu-prompt.sh "Confirm $Chosen?" 'loginctl reboot'
else
    exit 1
fi
