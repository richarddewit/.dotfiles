#!/bin/sh
lock() {
    i3lock
}

case "$1" in
    lock)
        $HOME/.i3/i3lock.sh
        exit 0
        ;;
    logout)
        action() {
          if [[ `pgrep i3-cinnamon` ]]; then
            cinnamon-session-quit --logout --no-prompt
          else
            i3-msg exit
          fi
        }
        ;;
    suspend)
        action() {
          lock && systemctl suspend
        }
        ;;
    reboot)
        action() {
          if [[ `pgrep i3-cinnamon` ]]; then
            cinnamon-session-quit --reboot --no-prompt
          else
            systemctl reboot
          fi
        }
        ;;
    shutdown)
        action() {
          if [[ `pgrep i3-cinnamon` ]]; then
            cinnamon-session-quit --power-off --no-prompt
          else
            systemctl poweroff
          fi
        }
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
        exit 2
esac

XRES=`cat ~/.Xresources`
get_xres_color() {
    echo `echo "$XRES" | grep "#define $1" | awk '{print \$3}'`
}

C_FOREGROUND=`get_xres_color "base05"`
C_BACKGROUND=`get_xres_color "base00"`
C_RED=`get_xres_color "base08"`

[ `echo "NO\nYES" | dmenu -nb "$C_BACKGROUND" -nf "$C_FOREGROUND" -sb "$C_RED" -sf "$C_FOREGROUND" -i -p "Do you really want to $1?"` = "YES" ] && action

exit 0
