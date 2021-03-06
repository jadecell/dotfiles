#!/usr/bin/env bash

# Source the settings
. $HOME/.config/dmenu/settings

declare bookmarks=("yt
nf
kpu
ke
gh
gl
kb
mw
mp
ne
wm
")

url=$(echo -e "${bookmarks[@]}" | dmenu $DMENU_ARGUMENTS -l 20 -p 'Select bookmark')

case $url in
	"yt")
		link="https://www.youtube.com" ;;
	"nf")
		link="https://www.netflix.com/browse" ;;
	"kpu")
		link="https://courses.kpu.ca" ;;
	"ke")
		link="https://one.kpu.ca/launch-task/all/student-email" ;;
	"gh")
		link="https://github.com/jadecell" ;;
	"gl")
		link="https://gitlab.com/jadecell" ;;
	"kb")
		link="https://www.keybr.com/" ;;
	"mw")
		link="https://wallet.mymonero.com/" ;;
	"mp")
		link="https://www.f2pool.com/xmr/47xzEa9zMKea5Ec4iFyJZbHMAwheh5RjHcaGvPd4TH2PT799qD1t7KZgKdKhSKZPmr6kuFRLNK3s1W6SuxA1oYYkNC2r678" ;;
    "ne")
        link="https://www.watchnebula.com" ;;
	"wm")
		link="https://mail.ionos.com/" ;;
esac

[ -n "$link" ] && $BROWSER $link
