#!/bin/bash
# swaync no renderiza <a href="...">: lo enseña como codigo. Esto reemplaza la notificacion
# por otra con el enlace limpio ("texto (url)") y sin etiquetas HTML no soportadas.
# Se dispara desde ~/.config/swaync/config.json (scripts, run-on receive) cuando el cuerpo trae '<a '.
limpio=$(python3 - <<'PY'
import os, re, html
b = os.environ.get('SWAYNC_BODY', '')
def enlace(m):
    url, txt = html.unescape(m.group(1)), html.unescape(re.sub(r'<[^>]+>', '', m.group(2)).strip())
    return html.escape(url, quote=False) if (not txt or txt == url) else f'{html.escape(txt, quote=False)} ({html.escape(url, quote=False)})'
b = re.sub(r'<a\s+[^>]*href=["\']([^"\']+)["\'][^>]*>(.*?)</a>', enlace, b, flags=re.S|re.I)
# lo que queda: conservar solo b/i/u, escapar el resto
b = re.sub(r'<(?!/?(?:b|i|u)>)[^>]*>', '', b)
b = re.sub(r'&(?!(?:amp|lt|gt|quot|apos|#\d+);)', '&amp;', b)
print(b)
PY
)
args=(-a "${SWAYNC_APP_NAME:-Notificacion}")
[ -n "$SWAYNC_REPLACES_ID" ] && [ "$SWAYNC_REPLACES_ID" != 0 ] || true
notify-send "${args[@]}" -r "$SWAYNC_ID" -u "$(echo "${SWAYNC_URGENCY:-normal}" | tr 'A-Z' 'a-z')" "$SWAYNC_SUMMARY" "$limpio"
