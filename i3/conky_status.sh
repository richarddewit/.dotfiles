#!/usr/bin/env bash

# Create a named pipe (FIFO)
panel_fifo="/tmp/conky_status_${USER}"
[ -e "${panel_fifo}" ] && rm "${panel_fifo}"
mkfifo "${panel_fifo}"

# Kill on exit, killsignal, error, etc.
trap 'trap - TERM; kill 0' INT TERM QUIT EXIT


# Send the header so that i3bar knows we want to use JSON:
echo '{"version":1}'

# Begin the endless array.
echo '['

# We send an empty first array of blocks to make the loop simpler:
echo '[],'

# Now send blocks with information forever:
conky -c $HOME/.i3/conky_status.conf > ${panel_fifo} &

# Loop FIFO
while read line; do
  echo $line | sed -r 's/"=green="/"#00FF00"/g'
done < ${panel_fifo}
