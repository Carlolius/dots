#!/bin/bash
# Alt+Tab al estilo KDE (version simple): salta a la ventana usada justo antes en este escritorio.
# Alt+Shift+Tab (arg "atras"): va a la ventana menos reciente. Lee el orden de foco que ya lleva sway.
id=$(python3 - "$1" <<'PY'
import json, subprocess, sys
t = json.loads(subprocess.check_output(['swaymsg', '-t', 'get_tree', '-r']))
def hojas(n):
    hijos = n.get('nodes', []) + n.get('floating_nodes', [])
    orden = {i: k for k, i in enumerate(n.get('focus', []))}
    hijos.sort(key=lambda c: orden.get(c['id'], 999))
    if not hijos:
        if n.get('pid'): yield n
        return
    for c in hijos: yield from hojas(c)
def ws_enfocado(n, ws=None):
    if n['type'] == 'workspace': ws = n
    if n.get('focused') and ws: return ws
    for c in n.get('nodes', []) + n.get('floating_nodes', []):
        r = ws_enfocado(c, ws)
        if r: return r
ws = ws_enfocado(t)
v = list(hojas(ws)) if ws else []
if len(v) > 1: print(v[-1]['id'] if sys.argv[1] == 'atras' else v[1]['id'])
PY
)
[ -n "$id" ] && swaymsg "[con_id=$id] focus" >/dev/null
