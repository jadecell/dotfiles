#!/usr/bin/env sh

# Source all the settings
. $HOME/.config/dmenu/settings

chosen=$(cut -d ';' -f1 ~/.local/share/emoji | dmenu -h $DMENU_CUSTOM_HEIGHT -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -n -l 10 | sed "s/ .*//")

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically insert the
# character. Otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
  xdotool type "$chosen"
else
  echo "$chosen" | tr -d '\n' | xclip -selection clipboard
  notify-send "'$chosen' copied to clipboard." &
fi
