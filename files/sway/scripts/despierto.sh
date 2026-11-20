#!/bin/bash
# Mantener la pantalla despierta. Uso: despierto.sh toggle | status (JSON para waybar)
F=${XDG_RUNTIME_DIR:-/tmp}/sway-despierto
case "$1" in
  toggle)
    if [ -e "$F" ]; then rm -f "$F"; setsid ~/.config/sway/scripts/swayidle.sh >/dev/null 2>&1 &
      notify-send -a Energía "Suspensión automática activada" "La pantalla se bloqueará y apagará por inactividad"
    else touch "$F"; setsid ~/.config/sway/scripts/swayidle.sh despierto >/dev/null 2>&1 &
      notify-send -a Energía "Pantalla despierta" "No se bloqueará ni apagará hasta que lo desactives"
    fi
    pkill -RTMIN+8 waybar ;;
  *)
    if [ -e "$F" ]; then echo '{"text":"󰈈","tooltip":"Pantalla despierta (click: desactivar)","class":"activo"}'
    else echo '{"text":"󰈉","tooltip":"Suspensión automática (click: mantener despierta)","class":"normal"}'; fi ;;
esac
