#!/usr/bin/env sh

# Source all the settings
. $HOME/.config/dmenu/settings

answer=$(echo "$@" | bc -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')

action=$(printf "copy to clipboard\nclear\nclose" \
    | dmenu $DMENU_ARGUMENTS -p "= $answer")

case $action in
    "clear") $0 ;;
    "copy to clipboard") printf "%s" "$answer" | xclip -selection clipboard ;;
    "close") ;;
    "") ;;
    *) $0 "$answer $action" ;;
esac
