#!/bin/bash

sleep 9

if ! pgrep -x "conky"; then
	conky -c ~/.conkyrc
	sleep 1 && conky -c ~/.conkyrc2
fi
