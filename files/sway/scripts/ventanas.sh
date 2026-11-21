#!/bin/bash
# Selector de ventanas en fuzzel (Meta+Tab): todas las ventanas abiertas, de todos los escritorios y pantallas,
# en el orden de foco que lleva sway (la anterior primero). Al elegir una, se enfoca (y cambia de escritorio si hace falta).
sel=$(python3 - <<'PY' | fuzzel --dmenu --prompt "󰖲 " --width 70 --lines 12 --index
import json, subprocess
t = json.loads(subprocess.check_output(['swaymsg', '-t', 'get_tree', '-r']))
filas = []
def hojas(n, ws=None):
    if n['type'] == 'workspace': ws = n['name']
    hijos = n.get('nodes', []) + n.get('floating_nodes', [])
    orden = {i: k for k, i in enumerate(n.get('focus', []))}
    hijos.sort(key=lambda c: orden.get(c['id'], 999))
    if not hijos:
        if n.get('pid') and ws and ws != '__i3_scratch': filas.append((n, ws))
        return
    for c in hijos: hojas(c, ws)
hojas(t)
# la ventana enfocada va la ultima (con Enter se salta a la anterior)
filas.sort(key=lambda f: 1 if f[0].get('focused') else 0)
for n, ws in filas:
    app = n.get('app_id') or (n.get('window_properties') or {}).get('class') or '?'
    print(f"{app:<22} {(n.get('name') or '')[:60]}  [{ws}]")
PY
)
[ -z "$sel" ] && exit 0
id=$(python3 - "$sel" <<'PY'
import json, subprocess, sys
idx = int(sys.argv[1])
t = json.loads(subprocess.check_output(['swaymsg', '-t', 'get_tree', '-r']))
filas = []
def hojas(n, ws=None):
    if n['type'] == 'workspace': ws = n['name']
    hijos = n.get('nodes', []) + n.get('floating_nodes', [])
    orden = {i: k for k, i in enumerate(n.get('focus', []))}
    hijos.sort(key=lambda c: orden.get(c['id'], 999))
    if not hijos:
        if n.get('pid') and ws and ws != '__i3_scratch': filas.append(n)
        return
    for c in hijos: hojas(c, ws)
hojas(t)
filas.sort(key=lambda n: 1 if n.get('focused') else 0)
print(filas[idx]['id'])
PY
)
[ -n "$id" ] && swaymsg "[con_id=$id] focus" >/dev/null
