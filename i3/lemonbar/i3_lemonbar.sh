#! /bin/bash
#
# I3 bar with https://github.com/LemonBoy/bar

. $(dirname $0)/i3_lemonbar_config

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
    printf "%s\n" "The status bar is already running." >&2
    exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "${panel_fifo}" ] && rm "${panel_fifo}"
mkfifo "${panel_fifo}"


### EVENTS METERS

# Window title, "WIN"
xtitle -s | sed -un 's/\(.*\)/WIN\1/p' > "${panel_fifo}" &

# i3 Workspaces, "WSP"
$(dirname $0)/i3_workspaces.sh > ${panel_fifo} &

# Conky, "SYS"
conky -c $(dirname $0)/i3_lemonbar_conky > "${panel_fifo}" &

### UPDATE INTERVAL METERS
cnt_vol=${upd_vol}
cnt_mail=${upd_mail}
cnt_mpd=${upd_mpd}
cnt_bat=${upd_bat}
# cnt_ssid=${upd_ssid}

while :; do

  # Volume, "VOL"
  if [ $((cnt_vol++)) -ge ${upd_vol} ]; then
    echo "VOL$(~/scripts/alsa_status.sh)" > "${panel_fifo}" &
    cnt_vol=0
  fi

  # Music, "MPD"
  if [ $((cnt_mpd++)) -ge ${upd_mpd} ]; then
    printf "%s%s\n" "MPD" "$(mpc current -f '[[%artist% - ]%title%]|[%file%]' 2>&1 | head -c 70)" > "${panel_fifo}"
    cnt_mpd=0
  fi

  # Battey, "BAT"
  if [ $((cnt_bat++)) -ge ${upd_bat} ]; then
    echo "$(~/scripts/batstat.sh)" > "${panel_fifo}" &
    cnt_bat=0
  fi

  # Finally, wait 1 second
  sleep 1s;

done &

#### LOOP FIFO

cat "${panel_fifo}" | $(dirname $0)/i3_lemonbar_parser.sh \
  | lemonbar -p -b -f "${font}" -f "${iconfont}" -g "${geometry}" -B "${color_back}" -F "${color_fore}" -u 3 | sh

wait

