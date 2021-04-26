#!/usr/bin/env sh

# This script is the SUDO_ASKPASS variable, meaning that it will be used as a
# password prompt if needed.

dmenu -fn "JetBrains Mono Nerd Font:size=10" -P -p "Enter sudo password" <&- && echo
