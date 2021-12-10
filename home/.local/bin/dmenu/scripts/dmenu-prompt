#!/usr/bin/env sh

# Source all the settings
. $HOME/.config/dmenu/settings

# Dmenu binary prompt.
# Gives a dmenu prompt labled with $1 to perform command $2.
# Example: dprompt "Suspend?" "sudo systemctl suspend"

[ "$(printf 'no\nyes' | dmenu $DMENU_ARGUMENTS -p "$1")" = 'yes' ] && $2
