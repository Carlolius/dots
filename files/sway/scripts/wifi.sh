#!/bin/bash
# Menu de red con fuzzel: encender/apagar Wi-Fi, conectar a una red, o abrir nmtui.
radio=$(nmcli radio wifi)
if [ "$radio" != enabled ]; then
  sel=$(printf '%s\n' "󰖩  Encender Wi-Fi" "󰒓  Configuración avanzada (nmtui)" | fuzzel --dmenu --prompt "󰖩 " --lines 2) || exit 0
  case "$sel" in *Encender*) nmcli radio wifi on ;; *nmtui*) exec foot --app-id float nmtui ;; esac
  exit 0
fi
nmcli dev wifi rescan >/dev/null 2>&1
act=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2; exit}')
redes=$(nmcli -t -f SSID,SIGNAL,SECURITY dev wifi list | awk -F: '$1!="" && !v[$1]++ {
  ic=($3=="")?"󰖩":"󰤪"; printf "%s  %s  (%s%%)\n", ic, $1, $2 }')
sel=$(printf '%s\n%s\n%s\n%s' "$redes" "󰖪  Apagar Wi-Fi" "󰒓  Configuración avanzada (nmtui)" \
  "$( [ -n "$act" ] && echo "󰖪  Desconectar de $act")" | sed '/^$/d' | fuzzel --dmenu --prompt "󰖩 " --lines 12) || exit 0
case "$sel" in
  *"Apagar Wi-Fi") nmcli radio wifi off ;;
  *nmtui*) exec foot --app-id float nmtui ;;
  *"Desconectar de"*) nmcli dev disconnect "$(nmcli -t -f DEVICE,TYPE dev | awk -F: '$2=="wifi"{print $1; exit}')" ;;
  *) ssid=$(sed -E 's/^[^ ]+  (.*)  \([0-9]+%\)$/\1/' <<<"$sel")
     if nmcli -t -f NAME con show | grep -qxF "$ssid"; then
       nmcli con up id "$ssid" && notify-send "Wi-Fi" "Conectado a $ssid" || notify-send -u critical "Wi-Fi" "No se pudo conectar a $ssid"
     else
       pass=$(fuzzel --dmenu --password --prompt "Contraseña de $ssid: " --lines 0) || exit 0
       nmcli dev wifi connect "$ssid" password "$pass" && notify-send "Wi-Fi" "Conectado a $ssid" || notify-send -u critical "Wi-Fi" "No se pudo conectar a $ssid"
     fi ;;
esac
