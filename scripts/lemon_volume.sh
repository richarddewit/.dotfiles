#!/bin/bash

# -- Script to adjust Pulseaudio volume and pipe info to lemonbar at the same time
# Usage: lemonvol <volume-amt>        (set volume to given amount)
#        lemonvol M                   (toggle muting)

case $1 in
  +)
    pulseaudio-ctl up
    ;;
  -)
    pulseaudio-ctl down
    ;;
  M)
    pulseaudio-ctl mute
    ;;
  *)
    pulseaudio-ctl set $1
    ;;
esac

echo "VOL`~/scripts/volume_status.sh`" > /tmp/i3_lemonbar_$USER
