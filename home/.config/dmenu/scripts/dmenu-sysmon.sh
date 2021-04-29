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

choice=$(echo -e "${options[@]}" | dmenu $DMENU_ARGUMENTS -l 20 -p 'System monitors: ')

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
