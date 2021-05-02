#!/usr/bin/env sh

# Source all the settings
. $HOME/.config/dmenu/settings

Menu='power off
reboot'

Chosen=$(printf "$Menu" | dmenu $DMENU_ARGUMENTS -p 'Power')

if [ "$Chosen" = 'power off' ]; then
    ~/.config/dmenu/scripts/dmenu-prompt.sh "Confirm $Chosen?" 'sudo -A shutdown now'
elif [ "$Chosen" = 'reboot' ]; then
    ~/.config/dmenu/scripts/dmenu-prompt.sh "Confirm $Chosen?" 'sudo -A shutdown -r now'
else
    exit 1
fi
