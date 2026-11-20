#!/bin/bash
# Menu de bluetooth con fuzzel: conectar/desconectar dispositivos emparejados.
estado=$(bluetoothctl show | awk '/Powered:/{print $2}')
if [ "$estado" != yes ]; then
  sel=$(printf '󰂯  Encender bluetooth\n' | fuzzel --dmenu --prompt "󰂯 " --lines 1) || exit 0
  bluetoothctl power on >/dev/null; exit 0
fi
mapfile -t devs < <(bluetoothctl devices Paired | sed 's/^Device //')
lista=""
for d in "${devs[@]}"; do
  mac=${d%% *}; nom=${d#* }
  if bluetoothctl info "$mac" | grep -q "Connected: yes"; then ic="󰂱 "; else ic="󰂲 "; fi
  lista+="$ic $nom  [$mac]"$'\n'
done
lista+="󰐕  Buscar y emparejar dispositivo nuevo"$'\n'
lista+="󰂲  Apagar bluetooth"
sel=$(printf '%s' "$lista" | fuzzel --dmenu --prompt "󰂯 " --lines 8) || exit 0
case "$sel" in
  *"Apagar bluetooth") bluetoothctl power off >/dev/null ;;
  *"emparejar dispositivo nuevo")
     notify-send "Bluetooth" "Buscando dispositivos (10 s). Ponlo en modo emparejamiento."
     bluetoothctl --timeout 10 scan on >/dev/null 2>&1
     mapfile -t nuevos < <(bluetoothctl devices | sed 's/^Device //' | while read -r m n; do bluetoothctl info "$m" | grep -q "Paired: yes" || echo "$m $n"; done)
     [ ${#nuevos[@]} -eq 0 ] && { notify-send "Bluetooth" "No se encontro nada nuevo"; exit 0; }
     sel2=$(printf '%s\n' "${nuevos[@]}" | sed 's/^\([0-9A-F:]*\) \(.*\)$/󰂯  \2  [\1]/' | fuzzel --dmenu --prompt "󰐕 " --lines 8) || exit 0
     mac=$(grep -o '\[[0-9A-F:]*\]' <<<"$sel2" | tr -d '[]')
     if bluetoothctl pair "$mac" && bluetoothctl trust "$mac" && bluetoothctl connect "$mac"; then
       notify-send "Bluetooth" "Emparejado y conectado"
     else notify-send -u critical "Bluetooth" "No se pudo emparejar"; fi ;;
  *) mac=$(grep -o '\[[0-9A-F:]*\]' <<<"$sel" | tr -d '[]')
     if bluetoothctl info "$mac" | grep -q "Connected: yes"; then bluetoothctl disconnect "$mac"; else bluetoothctl connect "$mac"; fi
     notify-send "Bluetooth" "$(bluetoothctl info "$mac" | awk -F': ' '/Name/{n=$2} /Connected/{c=$2} END{print n": conectado="c}')" ;;
esac
