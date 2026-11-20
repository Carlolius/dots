#!/bin/bash
# Menu de pantallas: cambia la disposicion al momento, sin tocar ficheros.
# Es temporal: al enchufar/quitar un monitor, kanshi vuelve a su perfil.
INT=eDP-1

# Imprime los comandos de sway para la disposicion pedida ($1), centrando una pantalla
# respecto a la otra cuando tienen distinto tamano.
comandos() {
python3 - "$INT" "$1" <<'PY'
import json, subprocess, sys
INT, modo = sys.argv[1:3]
outs = json.loads(subprocess.check_output(['swaymsg', '-t', 'get_outputs', '-r']))
size = {o['name']: (o['current_mode']['width'], o['current_mode']['height']) if o.get('current_mode')
        else (o['rect']['width'], o['rect']['height']) for o in outs}
ext = next((n for n in size if n != INT), None)
(iw, ih), (ew, eh) = size[INT], size.get(ext, (0, 0))
cmds = []
def place(n, x, y): cmds.append(f'output {n} enable pos {x} {y}')
if modo == 'derecha':   h = max(ih, eh); place(INT, 0, (h-ih)//2); place(ext, iw, (h-eh)//2)
elif modo == 'izquierda': h = max(ih, eh); place(ext, 0, (h-eh)//2); place(INT, ew, (h-ih)//2)
elif modo == 'arriba':  w = max(iw, ew); place(ext, (w-ew)//2, 0); place(INT, (w-iw)//2, eh)
elif modo == 'abajo':   w = max(iw, ew); place(INT, (w-iw)//2, 0); place(ext, (w-ew)//2, ih)
elif modo == 'portatil': place(INT, 0, 0); cmds.append(f'output {ext} disable')
elif modo == 'externa':  place(ext, 0, 0); cmds.append(f'output {INT} disable')
print('; '.join(cmds))
PY
}

hay_externa=$(swaymsg -t get_outputs -r | python3 -c "
import json,sys
print(sum(1 for o in json.load(sys.stdin) if o['name']!='$INT'))")

if [ "$hay_externa" -gt 0 ]; then
  opciones="󰍹  Externa a la derecha
󰍹  Externa a la izquierda
󰍹  Externa arriba
󰍹  Externa abajo
󰌢  Solo portátil
󰍹  Solo externa
󰑓  Automático (perfil de kanshi)"
else
  opciones="󰑓  Automático (perfil de kanshi)"
fi

sel=$(printf '%s\n' "$opciones" | fuzzel --dmenu --prompt "󰍹 " --lines 7) || exit 0
case "$sel" in
  *derecha)   swaymsg "$(comandos derecha)" ;;
  *izquierda) swaymsg "$(comandos izquierda)" ;;
  *arriba)    swaymsg "$(comandos arriba)" ;;
  *abajo)     swaymsg "$(comandos abajo)" ;;
  *"Solo portátil") swaymsg "$(comandos portatil)" ;;
  *"Solo externa")  swaymsg "$(comandos externa)" ;;
  *Automático*)     kanshictl reload ;;
esac
