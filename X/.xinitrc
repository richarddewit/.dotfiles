#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[ -f /etc/xprofile ] && source /etc/xprofile
[ -f $HOME/.xprofile ] && source $HOME/.xprofile

session=${1:-i3}

case $session in
       i3          ) exec i3;;
       cinnamon    ) exec cinnamon-session;;
       i3cinnamon  ) exec cinnamon-session-i3;;
       *           ) exec $1;;
esac
