#!/usr/bin/env bash

# Source all the settings
. $HOME/.config/dmenu/settings

declare -a options=("bashtop
glances
gtop
htop
nmon
s-tui
quit")

choice=$(echo -e "${options[@]}" | dmenu -h $DMENU_CUSTOM_HEIGHT -l 20 -p 'System monitors: ' -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -n)

case $choice in
	quit)
		echo "Program terminated." && exit 1
	;;
	bashtop| \
	glances| \
	gtop| \
	htop| \
	nmon| \
	s-tui)
        exec $TERMINAL -e $choice
	;;
	*)
		exit 1
	;;
esac
