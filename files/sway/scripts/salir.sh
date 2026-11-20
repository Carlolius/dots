#!/bin/bash
# Menu de sesion y energia con fuzzel. Confirma antes de lo irreversible.
sel=$(printf '%s\n' "󰌾  Bloquear" "󰤄  Suspender" "󰒲  Hibernar" "󰍃  Cerrar sesión" "󰜉  Reiniciar" "󰐥  Apagar" \
  | fuzzel --dmenu --prompt "󰐥 " --lines 6) || exit 0
confirmar() { [ "$(printf 'No\nSí\n' | fuzzel --dmenu --prompt "$1 " --lines 2)" = "Sí" ]; }
case "$sel" in
  *Bloquear)  ~/.config/sway/lock.sh ;;
  *Suspender) systemctl suspend ;;
  *Hibernar)  systemctl hibernate ;;
  *"Cerrar sesión") confirmar "¿Cerrar sesión?" && swaymsg exit ;;
  *Reiniciar) confirmar "¿Reiniciar?" && systemctl reboot ;;
  *Apagar)    confirmar "¿Apagar?" && systemctl poweroff ;;
esac
