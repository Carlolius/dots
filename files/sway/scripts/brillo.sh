#!/bin/bash
# Brillo del portatil (con OSD de swayosd) y del monitor externo por DDC/CI (ddcutil), si responde.
# Uso: brillo.sh up | down
d=$1; [ "$d" = up ] && { l=raise; s="+"; } || { l=lower; s="-"; }
swayosd-client --brightness "$l" &
if command -v ddcutil >/dev/null; then
  # el monitor externo (marca Acer); si el DDC/CI no responde, no pasa nada
  ( timeout 5 ddcutil --model HA240Y --noverify setvcp 10 "$s" 10 >/dev/null 2>&1 ) &
fi
wait
