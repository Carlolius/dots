#!/usr/env/bin bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | grep primary | cut -f 1 -d ' ')"

# Run xidlehook
xidlehook \
	`# Don't lock when fullscreen` \
	--not-when-fullscreen \
	`# Dim the screen after X seconds, undim if user becomes active` \
	--timer normal \
	'180' \
	`#xrandr --output "$PRIMARY_DISPLAY" --brightness .1` \
	'sxiv -fb ~/dots/media/aperture_laboratories.jpg' \
	`#xrandr --output "$PRIMARY_DISPLAY" --brightness 1` \
	'killall sxiv' \
	`# Lock screen after another X seconds, full bright if user active` \
	--timer normal \
	'60' \
	'i3lock -c 000000' \
	'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
	`# Turn off screen after another X seconds, full bright if user active` \
	--timer normal \
	'10' \
	'xset dpms force off' \
	'xrandr --output "$PRIMARY_DISPLAY" --brightness 1'
