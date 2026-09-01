#!/usr/bin/env bash
# Middle-click on waybar's media module: lists every MPRIS player that's
# playing or paused (multiple apps, phone via kdeconnect, etc.) and toggles
# play/pause on whichever one you pick — a lightweight stand-in for the
# multi-player switcher KDE's media widget has.
set -u

mapfile -t players < <(playerctl -l 2>/dev/null)

if [ ${#players[@]} -eq 0 ]; then
  notify-send "Media" "No hay reproductores activos" 2>/dev/null
  exit 0
fi

declare -A label_to_player
lines=()
for p in "${players[@]}"; do
  status=$(playerctl -p "$p" status 2>/dev/null)
  title=$(playerctl -p "$p" metadata --format '{{title}}' 2>/dev/null)
  artist=$(playerctl -p "$p" metadata --format '{{artist}}' 2>/dev/null)

  label="$p — ${status:-?}"
  if [ -n "$title" ]; then
    label="$label: $title"
    [ -n "$artist" ] && label="$label - $artist"
  fi

  lines+=("$label")
  label_to_player["$label"]="$p"
done

chosen=$(printf '%s\n' "${lines[@]}" | rofi -dmenu -p "Reproductor")
[ -z "$chosen" ] && exit 0

target="${label_to_player[$chosen]:-}"
[ -n "$target" ] && playerctl -p "$target" play-pause
