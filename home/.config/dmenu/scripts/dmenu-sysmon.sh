#!/usr/bin/env bash

# Source all the settings
. $HOME/.config/dmenu/settings

declare -a options=("bottom
bpytop
glances
gotop
htop
nmon
kmon
s-tui
quit")

choice=$(echo -e "${options[@]}" | dmenu $DMENU_ARGUMENTS -l 20 -p 'System monitors: ')

case $choice in
	quit)
		echo "Program terminated." && exit 1
	;;
	btm| \
	bpytop| \
	glances| \
	gotop| \
	htop| \
	nmon| \
	s-tui)
        exec $TERMINAL -e $choice
	;;
	bottom)
		exec $TERMINAL -e btm
		;;
	kmon)
	exec $TERMINAL -e sudo -A $choice
	;;
	*)
		exit 1
	;;
esac
