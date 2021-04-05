#!/usr/bin/env sh

# Source all the settings
. $HOME/.config/dmenu/settings

# Dmenu binary prompt.
# Gives a dmenu prompt labled with $1 to perform command $2.
# Example: dprompt "Suspend?" "sudo systemctl suspend"

[ "$(printf 'no\nyes' \
    | dmenu -p "$1" \
    -n -s -h $DMENU_CUSTOM_HEIGHT -nb "$DMENU_CUSTOM_NB" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -nf "$DMENU_CUSTOM_NF")" = 'yes' ] && $2
