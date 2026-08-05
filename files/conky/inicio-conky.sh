#!/bin/bash

sleep 9

if ! pgrep -x "conky"; then
	conky -c ~/.config/conky/conkyrc
	sleep 1 && conky -c ~/.config/conky/conkyrc2
fi
