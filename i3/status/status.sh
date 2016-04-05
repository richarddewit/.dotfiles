#!/usr/bin/env bash

. $(dirname $0)/status_parser.conf

# Create named pipe (FIFO)
[ -e "${status_fifo}" ] && rm "${status_fifo}"
mkfifo "${status_fifo}"

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

# Start i3bar JSON
# Send the header so i3bar knows that we want to use JSON
echo '{"version": 1}'

# Begin endless array
echo '['

# First an empty array to make the loop simpler
echo '[],'

# Send data
# Conky
conky -c $(dirname $0)/conky_status.conf > ${status_fifo} &

# Update intervals
count_vol=${upd_vol}
count_bat=${upd_bat}

while :; do

  # Volume, "VOL"
  if [ $((count_vol++)) -ge ${upd_vol} ]; then
    echo "VOL$(~/scripts/alsa_status.sh)" > "${status_fifo}" &
    count_vol=0
  fi

  # Battey, "BAT"
  if [ $((count_bat++)) -ge ${upd_bat} ]; then
    echo "$(~/scripts/batstat.sh)" > "${status_fifo}" &
    count_bat=0
  fi

  sleep 1s;
done &

# Loop FIFO
cat $status_fifo | $(dirname $0)/status_parser.sh

wait
