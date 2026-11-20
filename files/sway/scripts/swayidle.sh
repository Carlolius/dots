#!/bin/bash
# Arranca swayidle con tiempos segun el perfil de energia (se reinicia al cambiar de perfil).
#   ahorro:      baja el brillo a 1 min, bloquea a 2 min, apaga pantallas a 3 min
#   equilibrado: salvapantallas a 3 min, bloquea a 4 min, apaga pantallas a 6 min
#   rendimiento: salvapantallas a 3 min, bloquea a 5 min, apaga pantallas a 10 min
# Con la pantalla bloqueada, se apaga tras esos segundos sin tocar nada (ahorro: 20 s; resto: 60 s).
# Modo despierto ("despierto" como argumento): sin nada por inactividad, solo bloquea al suspender.
R=${XDG_RUNTIME_DIR:-/tmp}; S=$HOME/.config/sway/scripts; L=$HOME/.config/sway/lock.sh
pkill -x swayidle
if [ "$1" = despierto ]; then
  exec swayidle -w before-sleep "$L -f" after-resume 'swaymsg "output * dpms on"'
fi
if [ -r "$R/perfil-energia" ]; then read -r p < "$R/perfil-energia"; else p=$(powerprofilesctl get 2>/dev/null); fi
case "$p" in
  power-saver)  dim=60; saver=0;   lock=120; off=180; lockoff=20 ;;
  performance)  dim=0;  saver=180; lock=300; off=600; lockoff=60 ;;
  *)            dim=0;  saver=180; lock=240; off=360; lockoff=60 ;;
esac
a=()
[ $dim -gt 0 ] && a+=(timeout $dim "brightnessctl -s set 15%" resume "brightnessctl -r")
[ $saver -gt 0 ] && command -v cbonsai >/dev/null && a+=(timeout $saver "$S/salvapantallas.sh start" resume "$S/salvapantallas.sh stop")
a+=(timeout $lock "$L --grace 7"
    timeout $off 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"'
    timeout $lockoff 'pgrep -x hyprlock >/dev/null || pgrep -x swaylock >/dev/null && swaymsg "output * dpms off"'
    resume 'pgrep -x hyprlock >/dev/null || pgrep -x swaylock >/dev/null && swaymsg "output * dpms on"'
    before-sleep "$L -f" after-resume 'swaymsg "output * dpms on"')
exec swayidle -w "${a[@]}"
