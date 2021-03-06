#!/usr/bin/env sh

# Source all the settings
. $HOME/.config/dmenu/settings

# Dmenu for starting a timer.
# Takes one optional argument for a WAV file sound alert.
# Requires a monospace font for dmenu to display the TIME'S UP text correctly.

Duration=$(printf '' | dmenu $DMENU_ARGUMENTS -p "Current time: $(date +"%H:%M - %A %Y/%m/%d") | Timer duration:")
[ -z "$Duration" ] && exit 1

Name=$(printf '' | dmenu $DMENU_ARGUMENTS -p 'Name your timer:')

TimesUpMessage="Name: $Name Duration: $Duration
                                                                                       ''''''
TTTTTTTTTTTTTTTTTTTTTTTIIIIIIIIIIMMMMMMMM               MMMMMMMMEEEEEEEEEEEEEEEEEEEEEE '::::'   SSSSSSSSSSSSSSS      UUUUUUUU     UUUUUUUUPPPPPPPPPPPPPPPPP
T:::::::::::::::::::::TI::::::::IM:::::::M             M:::::::ME::::::::::::::::::::E '::::' SS:::::::::::::::S     U::::::U     U::::::UP::::::::::::::::P
T:::::::::::::::::::::TI::::::::IM::::::::M           M::::::::ME::::::::::::::::::::E ':::''S:::::SSSSSS::::::S     U::::::U     U::::::UP::::::PPPPPP:::::P
T:::::TT:::::::TT:::::TII::::::IIM:::::::::M         M:::::::::MEE::::::EEEEEEEEE::::E':::'  S:::::S     SSSSSSS     UU:::::U     U:::::UUPP:::::P     P:::::P
TTTTTT  T:::::T  TTTTTT  I::::I  M::::::::::M       M::::::::::M  E:::::E       EEEEEE''''   S:::::S                  U:::::U     U:::::U   P::::P     P:::::P
        T:::::T          I::::I  M:::::::::::M     M:::::::::::M  E:::::E                    S:::::S                  U:::::D     D:::::U   P::::P     P:::::P
        T:::::T          I::::I  M:::::::M::::M   M::::M:::::::M  E::::::EEEEEEEEEE           S::::SSSS               U:::::D     D:::::U   P::::PPPPPP:::::P
        T:::::T          I::::I  M::::::M M::::M M::::M M::::::M  E:::::::::::::::E            SS::::::SSSSS          U:::::D     D:::::U   P:::::::::::::PP
        T:::::T          I::::I  M::::::M  M::::M::::M  M::::::M  E:::::::::::::::E              SSS::::::::SS        U:::::D     D:::::U   P::::PPPPPPPPP
        T:::::T          I::::I  M::::::M   M:::::::M   M::::::M  E::::::EEEEEEEEEE                 SSSSSS::::S       U:::::D     D:::::U   P::::P
        T:::::T          I::::I  M::::::M    M:::::M    M::::::M  E:::::E                                S:::::S      U:::::D     D:::::U   P::::P
        T:::::T          I::::I  M::::::M     MMMMM     M::::::M  E:::::E       EEEEEE                   S:::::S      U::::::U   U::::::U   P::::P
      TT:::::::TT      II::::::IIM::::::M               M::::::MEE::::::EEEEEEEE:::::E       SSSSSSS     S:::::S      U:::::::UUU:::::::U PP::::::PP
      T:::::::::T      I::::::::IM::::::M               M::::::ME::::::::::::::::::::E       S::::::SSSSSS:::::S       UU:::::::::::::UU  P::::::::P
      T:::::::::T      I::::::::IM::::::M               M::::::ME::::::::::::::::::::E       S:::::::::::::::SS          UU:::::::::UU    P::::::::P
      TTTTTTTTTTT      IIIIIIIIIIMMMMMMMM               MMMMMMMMEEEEEEEEEEEEEEEEEEEEEE        SSSSSSSSSSSSSSS              UUUUUUUUU      PPPPPPPPPP
"

if Error=$(sleep $Duration 2>&1); then
    [ "${1##*.}" = 'wav' ] && aplay "$1" &
    printf '%s' "$TimesUpMessage" | dmenu $DMENU_ARGUMENTS -l 30 -fn "$DMENU_CUSTOM_FONT_MONO"
else
    printf '%s' "$Error" | dmenu $DMENU_ARGUMENTS -l 30 -p 'ERROR:'
fi
