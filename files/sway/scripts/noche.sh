#!/bin/bash
# Luz nocturna con wlsunset. Tres modos, que rota el click: auto -> siempre -> apagada.
#   auto:    el filtro empieza a subir ANTES_ATARDECER min antes del ocaso (rampa de 90 min) y
#            termina de bajar DESPUES_AMANECER min despues del amanecer (otra rampa de 90 min)
#   siempre: filtro calido fijo, a cualquier hora
#   apagada: sin filtro
# Uso: noche.sh start | toggle | status (JSON para waybar)
# Ajustes (se pueden sobreescribir en ~/.config/tema/noche.conf): temperatura, coordenadas y margenes
T=4200; LAT=41.45; LON=2.25   # Badalona
DURACION=5400                   # segundos de transicion gradual (90 min) al anochecer y al amanecer
ANTES_ATARDECER=45; DESPUES_AMANECER=30   # minutos
[ -r "$HOME/.config/tema/noche.conf" ] && . "$HOME/.config/tema/noche.conf"
F=$HOME/.config/tema/noche-modo
C=${XDG_RUNTIME_DIR:-/tmp}/noche-horas
# Horas de hoy: empieza ANTES_ATARDECER min antes del ocaso y termina DESPUES_AMANECER min despues del amanecer
calcular() {
python3 - "$LAT" "$LON" "$ANTES_ATARDECER" "$DESPUES_AMANECER" <<'PY'
import sys, math, datetime
lat, lon, antes, despues = float(sys.argv[1]), float(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4])
hoy = datetime.date.today(); n = hoy.timetuple().tm_yday
def sol(sale):
    lh = lon / 15
    t = n + ((6 - lh) if sale else (18 - lh)) / 24
    M = 0.9856 * t - 3.289
    L = (M + 1.916 * math.sin(math.radians(M)) + 0.020 * math.sin(math.radians(2 * M)) + 282.634) % 360
    RA = math.degrees(math.atan(0.91764 * math.tan(math.radians(L)))) % 360
    RA += (math.floor(L / 90) - math.floor(RA / 90)) * 90
    sd = 0.39782 * math.sin(math.radians(L)); cd = math.cos(math.asin(sd))
    ch = (math.cos(math.radians(90.833)) - sd * math.sin(math.radians(lat))) / (cd * math.cos(math.radians(lat)))
    ch = max(-1, min(1, ch))
    H = (360 - math.degrees(math.acos(ch))) if sale else math.degrees(math.acos(ch))
    UT = (H / 15 + RA / 15 - 0.06571 * t - 6.622 - lh) % 24
    return (datetime.datetime(hoy.year, hoy.month, hoy.day, tzinfo=datetime.timezone.utc) + datetime.timedelta(hours=UT)).astimezone()
amanecer, ocaso = sol(True), sol(False)
d = ocaso - datetime.timedelta(minutes=antes); h = amanecer + datetime.timedelta(minutes=despues)
print(hoy, d.strftime('%H:%M'), h.strftime('%H:%M'), amanecer.strftime('%H:%M'), ocaso.strftime('%H:%M'))
PY
}
horas() {
  if [ ! -r "$C" ] || [ "$(cut -d' ' -f1 "$C")" != "$(date +%F)" ]; then calcular > "$C"; NUEVO=1; fi
  read -r _ DESDE HASTA AMANECER OCASO < "$C"
}
horas
modo=$(cat "$F" 2>/dev/null || echo auto)
aplicar() {
  pkill -x wlsunset
  case "$1" in
    auto)    setsid wlsunset -t "$T" -T 6500 -s "$DESDE" -S "$HASTA" -d "$DURACION" >/dev/null 2>&1 & ;;
    siempre) setsid wlsunset -t "$T" -T "$((T+1))" -s 19:00 -S 07:00 >/dev/null 2>&1 & ;;
  esac
}
hhmm() { IFS=: read -r h m <<<"$1"; echo $((10#$h*60 + 10#$m)); }
case "$1" in
  start) command -v wlsunset >/dev/null && aplicar "$modo" ;;
  toggle)
    command -v wlsunset >/dev/null || { notify-send -u critical -a "Luz nocturna" "Falta wlsunset"; exit 1; }
    case "$modo" in auto) n=siempre; msg="Siempre activa (${T} K)" ;; siempre) n=apagada; msg="Apagada" ;; *) n=auto; msg="Automática: de $DESDE a $HASTA" ;; esac
    echo "$n" > "$F"; aplicar "$n"; notify-send -a "Luz nocturna" "$msg"; pkill -RTMIN+10 waybar ;;
  status)
    horas
    [ "$NUEVO" = 1 ] && [ "$modo" = auto ] && aplicar auto   # nuevo dia: recalcular las horas del filtro
    now=$(hhmm "$(date +%H:%M)"); d=$(hhmm "$DESDE"); h=$(hhmm "$HASTA")
    if [ "$d" -gt "$h" ]; then { [ "$now" -ge "$d" ] || [ "$now" -lt "$h" ]; } && noche=1 || noche=0
    else { [ "$now" -ge "$d" ] && [ "$now" -lt "$h" ]; } && noche=1 || noche=0; fi
    case "$modo" in
      auto)    [ $noche = 1 ] && c="activa" || c="espera"; echo "{\"text\":\"󰔎\",\"tooltip\":\"Luz nocturna automática: $DESDE a $HASTA\\n(amanecer $AMANECER, ocaso $OCASO)\\nclick: siempre activa\",\"class\":\"$c\"}" ;;
      siempre) echo '{"text":"󰖔","tooltip":"Luz nocturna siempre activa\nclick: apagar","class":"activa"}' ;;
      *)       echo '{"text":"󰖙","tooltip":"Luz nocturna apagada\nclick: automática","class":"apagada"}' ;;
    esac ;;
esac
