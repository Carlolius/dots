#!/bin/bash
# Enciende/apaga el Wi-Fi o la conexion por cable con un click. Uso: toggle-red.sh wifi|cable
case "$1" in
  wifi)
    if [ "$(nmcli radio wifi)" = enabled ]; then nmcli radio wifi off; notify-send "Wi-Fi" "Apagado"
    else nmcli radio wifi on; notify-send "Wi-Fi" "Encendido"; fi ;;
  cable)
    dev=$(nmcli -t -f DEVICE,TYPE,STATE dev | awk -F: '$2=="ethernet" && $3!="unavailable"{print $1; exit}')
    [ -z "$dev" ] && { notify-send "Cable" "No hay cable conectado"; exit 0; }
    if nmcli -t -f DEVICE,STATE dev | grep -q "^$dev:connected"; then nmcli dev disconnect "$dev"; notify-send "Cable" "Desconectado"
    else nmcli dev connect "$dev"; notify-send "Cable" "Conectando"; fi ;;
esac
