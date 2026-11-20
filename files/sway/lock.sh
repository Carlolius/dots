#!/bin/bash
# Generado por ~/.config/tema/aplicar.sh desde la paleta: no editar a mano (editar plantillas/lock.sh).
# Pantalla de bloqueo: captura desenfocada con vineta, hora y fecha grandes y anillo del color de la paleta.
# hyprlock SIN periodo de gracia: con la gracia, desbloquear moviendo el raton cuenta como un fallo de PAM (faillock)
# y tres seguidos bloquean la cuenta 10 minutos. Con swaylock (respaldo) la gracia si se respeta.
# Con hyprlock (si esta instalado): se lanza en segundo plano y se vuelve enseguida, para que swayidle
# (before-sleep) no se quede esperando. Solo se entiende --grace N; el resto de argumentos se ignoran.
grace=0
while [ $# -gt 0 ]; do [ "$1" = --grace ] && { grace=$2; shift; }; shift; done
~/.config/sway/scripts/salvapantallas.sh stop 2>/dev/null
# hyprlock solo se usa si existe ~/.config/tema/usar-hyprlock (activarlo cuando se haya comprobado el aspecto)
if [ -e ~/.config/tema/usar-hyprlock ] && command -v hyprlock >/dev/null; then
  pgrep -x hyprlock >/dev/null || { setsid hyprlock --config ~/.config/hypr/hyprlock.conf --grace 0 --no-fade-in >/dev/null 2>&1 & sleep 1; }
  exit 0
fi
# Respaldo: swaylock
exec swaylock --grace "$grace" --fade-in 0.3 \
  --screenshots --effect-blur 9x4 --effect-vignette 0.25:0.6 \
  --ignore-empty-password \
  --clock --timestr "%H:%M" --datestr "%a %d %b" \
  --font "Hack Nerd Font" --font-size 24 \
  --indicator --indicator-idle-visible --indicator-caps-lock \
  --indicator-radius 150 --indicator-thickness 8 \
  --text-color c0caf5ff --text-clear-color c0caf5ff --text-ver-color c0caf5ff --text-wrong-color f7768eff \
  --inside-color 1a1b26cc --inside-clear-color 1a1b26cc --inside-ver-color 1a1b26cc --inside-wrong-color 1a1b26cc \
  --ring-color 7aa2f7ff --ring-clear-color 565f89ff --ring-ver-color e0af68ff --ring-wrong-color f7768eff \
  --key-hl-color bb9af7ff --bs-hl-color f7768eff \
  --line-color 00000000 --line-clear-color 00000000 --line-ver-color 00000000 --line-wrong-color 00000000 \
  --separator-color 00000000
