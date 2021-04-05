#!/usr/bin/env bash

# Source all the settings
. $HOME/.config/dmenu/settings

IMG_PATH=/home/jackson/scrot/
UL=fb
EDIT=gimp
TIME=3000 #Miliseconds notification should remain visible

prog="
---Local screenshots (saved at IMG_PATH)---
1.quick_fullscreen
2.delayed_fullscreen
3.section
4.edit_fullscreen
---Upload to remote service (images will be deleted)---
a.upload_fullscreen
u.upload_delayed_fullscreen
e.edit_upload_fullscreen
s.upload_section
p.edit_upload_section
"

cmd=$(dmenu -l 20 -h $DMENU_CUSTOM_HEIGHT -fn "$DMENU_CUSTOM_FONT" -nb "$DMENU_CUSTOM_NB" -nf "$DMENU_CUSTOM_NF" -sb "$DMENU_CUSTOM_SB" -sf "$DMENU_CUSTOM_SF" -s -n -p 'Choose Screenshot Type'   <<< "$prog")

cd $IMG_PATH || exit 1
case ${cmd%% *} in

	1.quick_fullscreen)	scrot -d 1 '%Y-%m-%d-@%H-%M-%S-scrot.png'  && notify-send -u low -t $TIME 'Scrot' 'Fullscreen taken and saved'  ;;
	2.delayed_fullscreen)	scrot -d 4 '%Y-%m-%d-@%H-%M-%S-scrot.png'  && notify-send -u low -t $TIME 'Scrot' 'Fullscreen Screenshot saved'    ;;
	3.section)	scrot -s '%Y-%m-%d-@%H-%M-%S-scrot.png' && notify-send -u low -t $TIME 'Scrot' 'Screenshot of section saved'    ;;
	4.edit_fullscreen)	scrot -d 1 '%Y-%m-%d-@%H-%M-%S-scrot.png' -e "$EDIT \$f"  && notify-send -u low -t $TIME 'Scrot' 'Screenshot edited and saved' ;;

a.upload_fullscreen)	scrot -d 1 '%Y-%m-%d-@%H-%M-%S-scrot.png' -e "$UL \$f" && (xclip -o;echo) | xclip -selection clipboard  && notify-send -u low -t $TIME "Scrot" "Screenshot Uploaded (powered by fb) - $(xclip -o;echo)"  ;;
    u.upload_delayed_fullscreen)	scrot -d 4 '%Y-%m-%d-@%H-%M-%S-scrot.png' -e "$UL \$f"  && (xclip -o;echo) | xclip -selection clipboard  && notify-send -u low -t $TIME "Scrot" "Screenshot Uploaded (powered by fb) - $(xclip -o)"  ;;
	e.edit_upload_fullscreen)	scrot -d 4 '%Y-%m-%d-@%H-%M-%S-scrot.png' -e "$EDIT \$f && $UL \$f && rm -f \$f"  && notify-send -u low -t $TIME "Scrot" "Screenshot Uploaded (powered by fb) - $(xclip -o)"  ;;
s.upload_section)	scrot -s '%Y-%m-%d-@%H-%M-%S-scrot.png' -e "$UL \$f"  && (xclip -o;echo) | xclip -selection clipboard   &&  notify-send -u low -t $TIME "Scrot" "Screenshot Uploaded (powered by fb - $(xclip -o)";;
    p.edit_upload_section)  scrot -s '%Y-%m-%d-@%H-%M-%S-scrot.png' -e "$EDIT \$f && $UL \$f && rm -f \$f"  && (xclip -o;echo) | xclip -selection clipboard && notify-send -u low -t $TIME "Scrot" "Screenshot Uploaded (powered by FB) - $(xclip -o)"  ;;


  	*)		exec "'${cmd}'"  ;;
esac
