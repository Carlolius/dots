#!/bin/bash
# Menu buscable con todos los atajos de sway, leidos de los configs (nunca se desactualiza).
# Descripcion: comentario al final de la linea (bindsym ... # texto).
python3 - <<'PY' | fuzzel --dmenu --prompt "󰌌 " --width 80 --lines 18 >/dev/null
import re, glob, os
base = os.path.expanduser('~/.config/sway')
files = [base + '/config'] + sorted(glob.glob(base + '/config.d/*'))
vars_ = {}
rows = []
names = {'Mod4': 'Meta', 'Mod1': 'Alt', 'Control': 'Ctrl', 'Shift': 'Shift'}
def pretty(k):
    parts = k.split('+')
    return '+'.join(names.get(p, p.capitalize() if len(p) == 1 else p) for p in parts)
def human(c):
    t = [
     (r'^focus (left|right|up|down)$', lambda m: 'Foco: ' + {'left':'izquierda','right':'derecha','up':'arriba','down':'abajo'}[m[1]]),
     (r'^move (left|right|up|down)$', lambda m: 'Mover ventana: ' + {'left':'izquierda','right':'derecha','up':'arriba','down':'abajo'}[m[1]]),
     (r'^workspace number (\d+)$', lambda m: 'Ir al escritorio ' + m[1]),
     (r'^move container to workspace number (\d+)$', lambda m: 'Ventana al escritorio ' + m[1]),
     (r'^workspace (prev|next)(_on_output)?$', lambda m: 'Escritorio ' + ('anterior' if m[1]=='prev' else 'siguiente')),
     (r'^foot$|^foot .*|^\S*foot$', lambda m: 'Abrir terminal'),
     (r'^kill$', lambda m: 'Cerrar ventana'),
     (r'^reload$', lambda m: 'Recargar configuracion de sway'),
     (r'^fuzzel.*', lambda m: 'Lanzador de aplicaciones'),
     (r'^fullscreen$', lambda m: 'Pantalla completa'),
     (r'^floating toggle$', lambda m: 'Flotante/mosaico'),
     (r'^layout (stacking|tabbed|toggle split)$', lambda m: 'Disposicion: ' + m[1]),
     (r'^splith$', lambda m: 'Dividir en horizontal'),
     (r'^splitv$', lambda m: 'Dividir en vertical'),
     (r'^scratchpad show$', lambda m: 'Mostrar/ocultar scratchpad'),
     (r'^move scratchpad$', lambda m: 'Ventana al scratchpad'),
     (r'^border toggle$', lambda m: 'Mostrar/ocultar borde'),
     (r'^focus parent$', lambda m: 'Foco al contenedor padre'),
     (r'^focus mode_toggle$', lambda m: 'Alternar foco mosaico/flotantes'),
     (r'^mode "?resize"?$', lambda m: 'Modo redimensionar'),
     (r'^mode "?\$?screenshot"?$|^mode "\$screenshot"$', lambda m: 'Menu de capturas'),
     (r'^mode \$exit$', lambda m: 'Menu de apagado/sesion'),
     (r'.*playerctl play-pause.*', lambda m: 'Play/pausa'),
     (r'.*playerctl next.*', lambda m: 'Pista siguiente'),
     (r'.*playerctl previous.*', lambda m: 'Pista anterior'),
     (r'.*lock\.sh.*', lambda m: 'Bloquear pantalla'),
     (r"^'?grim - \| swappy.*", lambda m: 'Captura de pantalla completa'),
     (r"^'?grim -g.*", lambda m: 'Captura de un area'),
    ]
    for p, f in t:
        m = re.match(p, c)
        if m: return f(m)
    return c

for f in files:
    if not os.path.isfile(f): continue
    mode = ''
    pend = ''
    for line in open(f):
        s = line.strip()
        if s.startswith('#:'): pend = s[2:].strip(); continue
        m = re.match(r'set\s+(\$\w+)\s+(.+)', s)
        if m: vars_[m.group(1)] = m.group(2); continue
        m = re.match(r'mode\s+"?([^"{]+?)"?\s*\{', s)
        if m: mode = m.group(1); continue
        if s == '}': mode = ''; continue
        m = re.match(r'bind(?:sym|code|gesture)\s+(?:--\S+\s+)*(\S+)\s+(.*)', s)
        if not m: continue
        key, cmd = m.groups()
        desc, pend = pend, ''
        for v in sorted(vars_, key=len, reverse=True):
            key = key.replace(v, vars_[v])
        key = pretty(key)
        cmd = cmd.strip()
        cmd = re.sub(r'^exec\s+', '', cmd)
        for v in sorted(vars_, key=len, reverse=True):
            cmd = cmd.replace(v, vars_[v])
        text = desc.strip() or human(cmd)
        tag = f'[{mode}] ' if mode else ''
        if mode == 'resize': continue
        rows.append(f'{tag}{key:<28} {text}')
import collections
vistos = set(); res = []
for r in rows:
    k, _, d = r.partition('  ')
    k = k.strip(); d = d.strip()
    m = re.match(r'^(Meta|Meta\+Shift)\+(\d)$', k)
    if m:
        if m.group(2) != '1': continue
        r = f"{m.group(1)}+1..9, 0".ljust(28) + ' ' + re.sub(r' \d+$', ' N', d); 
    elif re.match(r'^(Meta|Meta\+Shift)\+(Left|Right|Up|Down)$', k):
        continue
    elif re.match(r'^(Meta|Meta\+Shift)\+H$', k):
        r = r.replace(k, k + ' J K L'.replace(' ', '/'), 1) if False else f"{k}/J/K/L (o flechas)".ljust(28) + ' ' + re.sub(r': (izquierda|abajo|arriba|derecha)$', ': dirección', d)
    elif re.match(r'^(Meta|Meta\+Shift)\+[JKL]$', k): continue
    if r in vistos: continue
    vistos.add(r); res.append(r)
print('\n'.join(res))
PY
