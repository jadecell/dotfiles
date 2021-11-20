#!/usr/bin/env sh

# Source all the settings
. $HOME/.config/dmenu/settings

Menu='power off
firmware
reboot'

Chosen=$(printf "$Menu" | dmenu $DMENU_ARGUMENTS -p 'Power')

if [ "$Chosen" = 'power off' ]; then
    ~/.config/dmenu/scripts/dmenu-prompt.sh "Confirm $Chosen?" 'systemctl poweroff'
elif [ "$Chosen" = 'reboot' ]; then
    ~/.config/dmenu/scripts/dmenu-prompt.sh "Confirm $Chosen?" 'systemctl reboot'
elif [ "$Chosen" = 'firmware' ]; then
  ~/.config/dmenu/scripts/dmenu-prompt.sh "Confirm $Chosen?" 'systemctl reboot --firmware-setup'
else
    exit 1
fi
