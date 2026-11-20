#!/bin/bash
# Aplica una paleta (sweet, tokyonight, dracula, gruvbox) a todas las herramientas.
# Uso: aplicar.sh [nombre]   (sin nombre: abre un menu)
# Las paletas estan en ~/.config/tema/paletas, las plantillas en ~/.config/tema/plantillas.
# Para anadir una paleta: copia una existente y cambia los colores.
D=~/.config/tema
nombre=$1
actual=$(cat "$D/actual" 2>/dev/null || echo tokyonight)
forma=$(cat "$D/forma" 2>/dev/null || echo redondeada)
if [ -z "$nombre" ]; then
  sel=$( (ls "$D/paletas"; echo "── Esquinas redondeadas"; echo "── Esquinas cuadradas"; echo "── Bloqueo: completo"; echo "── Bloqueo: minimalista") | fuzzel --dmenu --prompt "󰏘 " --lines 11) || exit 0
  case "$sel" in
    *redondeadas) forma=redondeada; nombre=$actual ;;
    *cuadradas)   forma=cuadrada;   nombre=$actual ;;
    *completo)    echo completo > "$D/lock-estilo"; nombre=$actual ;;
    *minimalista) echo minimal  > "$D/lock-estilo"; nombre=$actual ;;
    *) nombre=$sel ;;
  esac
fi
echo "$forma" > "$D/forma"
[ -f "$D/paletas/$nombre" ] || { echo "No existe la paleta $nombre" >&2; exit 1; }

render() {  # plantilla destino
  python3 - "$D/paletas/$nombre" "$1" "$2" <<'PY'
import sys, os
pal = dict(l.strip().split('=') for l in open(sys.argv[1]) if '=' in l)
forma = open(os.path.expanduser('~/.config/tema/forma')).read().strip()
pal.update(dict(r1='0', r2='0', r3='0', rp='0', rn='6', rni='4') if forma == 'cuadrada' else dict(r1='14', r2='10', r3='8', rp='999', rn='14', rni='8'))
t = open(sys.argv[2]).read()
import re as _re
m = _re.search(r'^output \* bg "?([^"\n]+?)"? fill', open(os.path.expanduser('~/.config/sway/config')).read(), _re.M)
pal['fondo'] = os.path.expanduser(m.group(1)) if m else ''
pal['home'] = os.path.expanduser('~')
for k, v in pal.items(): t = t.replace(f'@{k}@', v)
dst = os.path.expanduser(sys.argv[3]); os.makedirs(os.path.dirname(dst), exist_ok=True)
open(dst, 'w').write(t)
PY
}
render "$D/plantillas/fuzzel.ini"  ~/.config/fuzzel/fuzzel.ini
render "$D/plantillas/swayosd.css" ~/.config/swayosd/style.css
render "$D/plantillas/swaync.css"  ~/.config/swaync/style.css
render "$D/plantillas/waybar.css" ~/.config/waybar/style.css
estilo=$(cat "$D/lock-estilo" 2>/dev/null || echo completo)
[ -f "$D/plantillas/hyprlock-$estilo.conf" ] || estilo=completo
render "$D/plantillas/hyprlock-$estilo.conf" ~/.config/hypr/hyprlock.conf
render "$D/plantillas/lock.sh" ~/.config/sway/lock.sh; chmod +x ~/.config/sway/lock.sh
render "$D/plantillas/sway-colores.conf" ~/.config/sway/config.d/colores
python3 "$D/kde-colores.py" "$D/paletas/$nombre"
echo "$nombre" > "$D/actual"

pkill -SIGUSR2 waybar
swaymsg reload >/dev/null; sleep 0.5; kanshictl reload
pkill swayosd-server; setsid swayosd-server >/dev/null 2>&1 &
swaync-client -R >/dev/null 2>&1; swaync-client -rs >/dev/null 2>&1
notify-send "Tema: $nombre" "Paleta aplicada"
