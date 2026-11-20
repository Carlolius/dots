#!/bin/bash
# Menu de capturas con fuzzel. Guarda en ~/Imágenes/Capturas de pantalla.
DIR=~/"Imágenes/Capturas de pantalla"; mkdir -p "$DIR"
F="$DIR/captura_$(date +%Y%m%d_%H%M%S).png"
if [ "$1" = activa ]; then   # Print: ventana activa solo al portapapeles, sin menu
  g=$(swaymsg -t get_tree -r | python3 -c "
import json,sys
def f(n):
    if n.get('focused') and n.get('pid'):
        r=n['rect']; print(f\"{r['x']},{r['y']} {r['width']}x{r['height']}\"); return True
    return any(f(c) for c in n.get('nodes',[])+n.get('floating_nodes',[]))
f(json.load(sys.stdin))")
  [ -z "$g" ] && { notify-send -u critical -a Capturas "No hay ventana activa"; exit 1; }
  grim -g "$g" - | wl-copy && notify-send -a Capturas "Ventana copiada al portapapeles"
  exit 0
fi
if [ "$1" = pantalla ]; then   # Meta+Print: pantalla actual solo al portapapeles, sin menu
  salida=$(swaymsg -t get_outputs -r | python3 -c "import json,sys;print([o['name'] for o in json.load(sys.stdin) if o['focused']][0])")
  grim -o "$salida" - | wl-copy && notify-send -a Capturas "Captura copiada al portapapeles"
  exit 0
fi
sel=$(printf '%s\n' \
 "󰆞  Área → portapapeles" \
 "󰆞  Área → archivo" \
 "󰆞  Área → editar (swappy)" \
 "󰍹  Pantalla actual → portapapeles" \
 "󰍹  Pantalla actual → archivo" \
 "󰖲  Ventana → portapapeles" \
 "󰖲  Ventana → archivo" \
 "󰔛  Pantalla completa en 5 s → archivo" \
 "󰄀  Abrir carpeta de capturas" | fuzzel --dmenu --prompt "󰄀 " --lines 9) || exit 0
salida=$(swaymsg -t get_outputs -r | python3 -c "import json,sys;print([o['name'] for o in json.load(sys.stdin) if o['focused']][0])")
ventana() { swaymsg -t get_tree -r | python3 -c "
import json,sys
def w(n):
    if n.get('pid') and n.get('visible'): r=n['rect']; print(f\"{r['x']},{r['y']} {r['width']}x{r['height']}\")
    for c in n.get('nodes',[])+n.get('floating_nodes',[]): w(c)
w(json.load(sys.stdin))" | slurp -r; }
hecho() { notify-send -a Capturas "Captura hecha" "$1"; }
sleep 0.3
case "$sel" in
  "󰆞  Área → portapapeles") g=$(slurp) || exit 0; grim -g "$g" - | wl-copy && hecho "Área copiada" ;;
  "󰆞  Área → archivo")      g=$(slurp) || exit 0; grim -g "$g" "$F" && hecho "$F" ;;
  "󰆞  Área → editar"*)      g=$(slurp) || exit 0; grim -g "$g" - | swappy -f - ;;
  "󰍹  Pantalla actual → portapapeles") grim -o "$salida" - | wl-copy && hecho "Pantalla copiada" ;;
  "󰍹  Pantalla actual → archivo")      grim -o "$salida" "$F" && hecho "$F" ;;
  "󰖲  Ventana → portapapeles") g=$(ventana) || exit 0; grim -g "$g" - | wl-copy && hecho "Ventana copiada" ;;
  "󰖲  Ventana → archivo")      g=$(ventana) || exit 0; grim -g "$g" "$F" && hecho "$F" ;;
  "󰔛"*) sleep 5; grim "$F" && hecho "$F" ;;
  "󰄀"*) xdg-open "$DIR" ;;
esac
