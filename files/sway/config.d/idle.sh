exec swayidle -w \
	timeout 240 '~/.config/sway/lock.sh --grace 7 --fade-in 3' \
	timeout 360 'swaymsg "output * dpms off"' \
	resume 'swaymsg "output * dpms on"' \
	timeout 7 'pgrep swaylock && swaymsg "output * dpms off"' \
 	resume 'pgrep swaylock && swaymsg "output * dpms on"' \
	before-sleep 'swaylock -c 111111' \
	after-resume 'swaymsg "output * dpms on"' &
