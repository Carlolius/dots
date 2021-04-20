#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar
if [ "$(hostname)" = "bender" ]; then
	echo "---" | tee -a /tmp/benderbar.log
	polybar benderbar 2>&1 | tee -a /tmp/benderbar.log & disown
elif [ "$(hostname)" = "nibbler" ]; then
	echo "---" | tee -a /tmp/nibblerbar.log
	polybar nibblerbar 2>&1 | tee -a /tmp/nibblerbar.log & disown
fi

echo "Bars launched..."
