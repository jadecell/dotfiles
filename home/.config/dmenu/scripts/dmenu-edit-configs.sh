#!/usr/bin/env bash

# Source all the settings
. $HOME/.config/dmenu/settings

declare options=("alacritty
bash
bspwm
doom.d/config.org
doom.d/init.el
dunst
dwm
fish
neovim
newsboat
picom
polybar
qtile
qutebrowser
ranger
spectrwm
st
starship
sxhkd
xmobar0
xmobar1
xmobar2
xmonad
xresources
zathura
zsh
quit")

choice=$(echo -e "${options[@]}" | dmenu $DMENU_ARGUMENTS -p 'Edit config file: ')

case "$choice" in
	quit)
		echo "Program terminated." && exit 1
	;;
	alacritty)
		choice="$HOME/.config/alacritty/alacritty.yml"
	;;
	bash)
		choice="$HOME/.bashrc"
	;;
	bspwm)
		choice="$HOME/.config/bspwm/bspwmrc"
	;;
    doom.d/config.org)
		choice="$HOME/.doom.d/config.org"
	;;
    doom.d/init.el)
		choice="$HOME/.doom.d/init.el"
	;;
	dunst)
		choice="$HOME/.config/dunst/dunstrc"
	;;
	dwm)
		choice="$HOME/.local/repos/dwm/config.h"
	;;
    fish)
		choice="$HOME/.config/fish/config.fish"
	;;
	neovim)
		choice="$HOME/.config/nvim/init.vim"
	;;
    newsboat)
		choice="$HOME/.config/newsboat/config"
	;;

	picom)
		choice="$HOME/.config/picom/picom.conf"
	;;
    polybar)
		choice="$HOME/.config/polybar/config"
	;;
	qtile)
		choice="$HOME/.config/qtile/config.py"
	;;
    qutebrowser)
		choice="$HOME/.config/qutebrowser/config.py"
	;;
    ranger)
		choice="$HOME/.config/ranger/rc.conf"
	;;
	spectrwm)
		choice="$HOME/.spectrwm.conf"
	;;
	st)
		choice="$HOME/.local/repos/st/config.h"
	;;
	starship)
		choice="$HOME/.config/starship.toml"
	;;
	sxhkd)
		choice="$HOME/.config/sxhkd/sxhkdrc"
	;;
	xmobar0)
		choice="$HOME/.config/xmobar/xmobarrc0"
	;;
    xmobar1)
		choice="$HOME/.config/xmobar/xmobarrc1"
	;;
    xmobar2)
		choice="$HOME/.config/xmobar/xmobarrc2"
	;;
	xmonad)
		choice="$HOME/.xmonad/xmonad.hs"
	;;
	xresources)
		choice="$HOME/.Xresources"
	;;
	zathura)
		choice="$HOME/.config/zathura/zathurarc"
	;;
	zsh)
		choice="$HOME/.zshrc"
	;;
	*)
		exit 1
	;;
esac
$TERMINAL -e $EDITOR "$choice"
