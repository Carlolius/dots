#!/bin/bash
# Consumo para waybar (JSON) y perfil de energia. Sin subprocesos ni esperas: solo lecturas de sysfs.
# Uso: vatios.sh | vatios.sh perfil [power-saver|balanced|performance] (sin valor: rota ahorro -> equilibrado -> rendimiento)
R=${XDG_RUNTIME_DIR:-/tmp}
if [ "$1" = perfil ]; then
  if [ -r "$R/perfil-energia" ]; then read -r actual < "$R/perfil-energia"; else actual=$(powerprofilesctl get); fi
  case "$actual" in power-saver) n=balanced ;; balanced) n=performance ;; *) n=power-saver ;; esac
  [ -n "$2" ] && n=$2
  powerprofilesctl set "$n" 2>/dev/null || { notify-send -u critical "Energía" "No se pudo cambiar a $n"; exit 1; }
  echo "$n" > "$R/perfil-energia"; notify-send -a Energía "Perfil: $n"; pkill -RTMIN+9 waybar
  # los tiempos de inactividad dependen del perfil: reiniciar swayidle (salvo en modo despierto)
  [ -e "$R/sway-despierto" ] || setsid ~/.config/sway/scripts/swayidle.sh >/dev/null 2>&1 &
  exit 0
fi
bat=/sys/class/power_supply/BAT0
read -r estado < $bat/status
read -r pnow < $bat/power_now
if [ ! -r "$R/amdgpu-hwmon" ]; then
  for d in /sys/class/hwmon/hwmon*; do read -r nm < $d/name; [ "$nm" = amdgpu ] && echo $d > "$R/amdgpu-hwmon" && break; done
fi
read -r h < "$R/amdgpu-hwmon"; read -r ppt < $h/power1_input
# media movil (el sensor es instantaneo y da picos), sin dormir
if [ -r "$R/ppt-avg" ]; then read -r old < "$R/ppt-avg"; avg=$(( (old*3 + ppt)/4 )); else avg=$ppt; fi
echo $avg > "$R/ppt-avg"
[ -r "$R/perfil-energia" ] || powerprofilesctl get > "$R/perfil-energia"
read -r perfil < "$R/perfil-energia"
case "$perfil" in power-saver) ic="󰌪" ;; performance) ic="󰓅" ;; *) ic="󰾅" ;; esac
w() { printf '%d.%d' $(( $1/1000000 )) $(( ($1%1000000)/100000 )); }
if [ "$estado" = Discharging ]; then v=$(w $pnow); tip="Equipo: $v W"; else v=$(w $avg); tip="CPU+GPU: $v W"; fi
printf '{"text":"%s %sW","tooltip":"%s\\nPerfil: %s (click: cambiar)","class":"%s"}\n' "$ic" "$v" "$tip" "$perfil" "$perfil"
