#!/bin/bash
# Control multimedia sobre el reproductor correcto. Con varios reproductores MPRIS a la vez (p. ej. Spotify
# y el movil por KDE Connect), `playerctl` sin -p actua sobre el primero de la lista, que puede ser el movil.
# Aqui: el que esta sonando; si ninguno suena, el ultimo que sono (asi, tras pausar Spotify, el siguiente
# click lo reanuda a el y no al movil); y si no hay ultimo, el primero de la lista.
# Uso: media.sh toggle | next | prev | back | fwd | pick
ULT=${XDG_RUNTIME_DIR:-/tmp}/media-ultimo
pick() {
  local p u
  for p in $(playerctl -l 2>/dev/null); do
    [ "$(playerctl -p "$p" status 2>/dev/null)" = Playing ] && { echo "$p" > "$ULT"; echo "$p"; return; }
  done
  if [ -r "$ULT" ]; then read -r u < "$ULT"; playerctl -l 2>/dev/null | grep -qxF "$u" && { echo "$u"; return; }; fi
  playerctl -l 2>/dev/null | head -1
}
p=$(pick); [ -z "$p" ] && exit 0
case "$1" in
  toggle) playerctl -p "$p" play-pause ;;
  next)   playerctl -p "$p" next ;;
  prev)   playerctl -p "$p" previous ;;
  back)   playerctl -p "$p" position 3- ;;
  fwd)    playerctl -p "$p" position 3+ ;;
  pick)   echo "$p" ;;
esac
