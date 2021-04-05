#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITOR=DP-1 polybar -r main-bar &
MONITOR=DP-3 polybar -r alt-bar &
MONITOR=DVI-D-1 polybar -r alt-bar &
echo "Bars launched..."
