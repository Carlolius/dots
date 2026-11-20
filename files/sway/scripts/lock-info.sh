#!/bin/bash
# Textos de la pantalla de bloqueo (hyprlock). Siempre imprime algo (un espacio si no hay nada):
# si el comando saliera vacio, hyprlock enseña "Sample Text".
case "$1" in
  saludo)  n=$(getent passwd "$USER" | cut -d: -f5 | cut -d, -f1); echo "Hola, ${n:-$USER}" ;;
  bateria) read -r c < /sys/class/power_supply/BAT0/capacity 2>/dev/null; echo "󰁹  ${c:-?}%" ;;
  musica)  m=$(playerctl metadata --format '󰎆  {{artist}} — {{title}}' 2>/dev/null | cut -c1-70); echo "${m:- }" ;;
  puntos)  [ $(( 10#$(date +%S) % 2 )) -eq 0 ] && echo ":" || echo " " ;;
  *)       echo " " ;;
esac
