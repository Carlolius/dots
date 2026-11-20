#!/bin/bash
# Salvapantallas: un bonsai (cbonsai) que crece a pantalla completa en cada monitor.
# Uso: salvapantallas.sh start | stop     (swayidle lo arranca a los 3 min y lo para con cualquier tecla o ratón)
case "$1" in
  start)
    command -v cbonsai >/dev/null || exit 0
    swaymsg -t get_tree | grep -q '"app_id": "salvapantallas"' && exit 0
    actual=$(swaymsg -t get_outputs -r | python3 -c "import json,sys;print([o['name'] for o in json.load(sys.stdin) if o['focused']][0])")
    for o in $(swaymsg -t get_outputs -r | python3 -c "import json,sys;print(' '.join(o['name'] for o in json.load(sys.stdin) if o['active']))"); do
      swaymsg "focus output $o" >/dev/null
      setsid foot --app-id salvapantallas --fullscreen sh -c 'sleep 0.7; exec cbonsai -l -i -w 4 -L 55' >/dev/null 2>&1 &
      sleep 0.3
    done
    swaymsg "focus output $actual" >/dev/null ;;
  stop) swaymsg '[app_id="salvapantallas"] kill' >/dev/null 2>&1 ;;
esac
