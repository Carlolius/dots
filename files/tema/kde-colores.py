#!/usr/bin/env python3
"""Genera ~/.local/share/color-schemes/Tema.colors (esquema de color KDE/Qt) desde una paleta.
Uso: kde-colores.py ruta/paleta. No toca kdeglobals ni ningun rc: solo crea el esquema."""
import os, re, sys
pal = dict(l.strip().split('=') for l in open(sys.argv[1]) if '=' in l)
rgb = lambda k: ','.join(str(int(pal[k][i:i+2], 16)) for i in (0, 2, 4))
common = dict(ForegroundNormal=rgb('fg'), ForegroundInactive=rgb('dim'), ForegroundActive=rgb('accent'),
              ForegroundLink=rgb('accent2'), ForegroundVisited=rgb('accent'), ForegroundNegative=rgb('urgent'),
              ForegroundNeutral=rgb('yellow'), ForegroundPositive=rgb('green'),
              DecorationFocus=rgb('accent'), DecorationHover=rgb('accent'))
grupos = {
  'Colors:Window':  dict(BackgroundNormal=rgb('bg'),  BackgroundAlternate=rgb('bg2'), **common),
  'Colors:View':    dict(BackgroundNormal=rgb('bg'),  BackgroundAlternate=rgb('bg2'), **common),
  'Colors:Button':  dict(BackgroundNormal=rgb('bg2'), BackgroundAlternate=rgb('bg'),  **common),
  'Colors:Tooltip': dict(BackgroundNormal=rgb('bg'),  BackgroundAlternate=rgb('bg2'), **common),
  'Colors:Selection': dict(BackgroundNormal=rgb('accent'), BackgroundAlternate=rgb('accent2'),
                           **{**common, 'ForegroundNormal': rgb('bg'), 'ForegroundInactive': rgb('bg2'),
                              'ForegroundActive': rgb('bg'), 'ForegroundLink': rgb('bg'), 'ForegroundVisited': rgb('bg')}),
  'WM': dict(activeBackground=rgb('bg'), activeForeground=rgb('fg'), inactiveBackground=rgb('bg'),
             inactiveForeground=rgb('dim'), activeBlend=rgb('accent'), inactiveBlend=rgb('bg2')),
}
base = open('/usr/share/color-schemes/BreezeDark.colors').read()
out, sec = [], None
for linea in base.splitlines():
    m = re.match(r'\[(.+)\]', linea)
    if m: sec = m.group(1)
    elif '=' in linea and sec in grupos:
        k = linea.split('=')[0]
        if k in grupos[sec]: linea = f'{k}={grupos[sec][k]}'
    elif linea.startswith('Name=') and sec == 'General': linea = 'Name=Tema'
    out.append(linea)
d = os.path.expanduser('~/.local/share/color-schemes'); os.makedirs(d, exist_ok=True)
open(d + '/Tema.colors', 'w').write('\n'.join(out) + '\n')
