#!/usr/bin/env sh

# Gives a dmenu prompt to mount unmounted drives and Android phones. If
# they're in /etc/fstab, they'll be mounted automatically. Otherwise, you'll
# be prompted to give a mountpoint from already existsing directories. If you
# input a novel directory, it will prompt you to create that directory.

# Source all the settings
. $HOME/.config/dmenu/settings

getmount() { \
	[ -z "$chosen" ] && exit 1
        # shellcheck disable=SC2086
	mp="$(find $1 2>/dev/null | dmenu -h $DMENU_CUSTOM_HEIGHT -p "Type in mount point." -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -n)" || exit 1
	[ "$mp" = "" ] && exit 1
	if [ ! -d "$mp" ]; then
		mkdiryn=$(printf "No\\nYes" | dmenu -p "$mp does not exist. Create it?" -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -n) || exit 1
		[ "$mkdiryn" = "Yes" ] && (mkdir -p "$mp" || sudo -A mkdir -p "$mp")
	fi
	}

mountusb() { \
	chosen="$(echo "$usbdrives" | dmenu -h $DMENU_CUSTOM_HEIGHT -p "Mount which drive?" -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -n)" || exit 1
	chosen="$(echo "$chosen" | awk '{print $1}')"
	sudo -A mount "$chosen" 2>/dev/null && notify-send "💻 USB mounting" "$chosen mounted." && exit 0
	alreadymounted=$(lsblk -nrpo "name,type,mountpoint" | awk '$3!~/\/boot|\/home$|SWAP/&&length($3)>1{printf "-not ( -path *%s -prune ) ",$3}')
	getmount "/mnt /media /mount /home -maxdepth 5 -type d $alreadymounted"
	partitiontype="$(lsblk -no "fstype" "$chosen")"
	case "$partitiontype" in
		"vfat") sudo -A mount -t vfat "$chosen" "$mp" -o rw,umask=0000;;
		"exfat") sudo -A mount "$chosen" "$mp" -o uid="$(id -u)",gid="$(id -g)";;
		*) sudo -A mount "$chosen" "$mp"; user="$(whoami)"; ug="$(groups | awk '{print $1}')"; sudo -A chown "$user":"$ug" "$mp";;
	esac
	notify-send "💻 USB mounting" "$chosen mounted to $mp."
	}

mountandroid() { \
	chosen="$(echo "$anddrives" | dmenu -h $DMENU_CUSTOM_HEIGHT -p "Which Android device?" -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -n)" || exit 1
	chosen="$(echo "$chosen" | cut -d : -f 1)"
	getmount "$HOME -maxdepth 3 -type d"
        simple-mtpfs --device "$chosen" "$mp"
	echo "OK" | dmenu -p "Tap Allow on your phone if it asks for permission and then press enter" || exit 1
	simple-mtpfs --device "$chosen" "$mp"
	notify-send "🤖 Android Mounting" "Android device mounted to $mp."
	}

asktype() { \
	choice="$(printf "USB\\nAndroid" | dmenu -h $DMENU_CUSTOM_HEIGHT -p "Mount a USB drive or Android device?" -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -n)" || exit 1
	case $choice in
		USB) mountusb ;;
		Android) mountandroid ;;
	esac
	}

anddrives=$(simple-mtpfs -l 2>/dev/null)
usbdrives="$(lsblk -rpo "name,type,size,mountpoint" | grep 'part\|rom' | awk '$4==""{printf "%s (%s)\n",$1,$3}')"

if [ -z "$usbdrives" ]; then
	[ -z "$anddrives" ] && echo "No USB drive or Android device detected" && exit
	echo "Android device(s) detected."
	mountandroid
else
	if [ -z "$anddrives" ]; then
		echo "USB drive(s) detected."
		mountusb
	else
		echo "Mountable USB drive(s) and Android device(s) detected."
		asktype
	fi
fi