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
        # i3-msg exit
        # i3-nagbar -t warning -m 'Do you really want to logout?' -b 'Logout' 'i3-msg exit'
        action() {
          if [[ `pgrep i3-cinnamon` ]]; then
            cinnamon-session-quit --logout --no-prompt
          else
            i3-msg exit
          fi
        }
        ;;
    suspend)
        lock && systemctl suspend
        exit 0
        ;;
    reboot)
        # systemctl reboot
        # i3-nagbar -t warning -m 'Do you really want to reboot?' -b 'Reboot' 'systemctl reboot'
        action() {
          if [[ `pgrep i3-cinnamon` ]]; then
            cinnamon-session-quit --reboot --no-prompt
          else
            systemctl reboot
          fi
        }
        ;;
    shutdown)
        # systemctl poweroff
        # i3-nagbar -t warning -m 'Do you really want to shutdown?' -b 'Shutdown' 'systemctl poweroff'
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

[ $(echo -e "NO\nYES" | dmenu -nb "#2C3E50" -nf "#E0E0E0" -sb "#E74C3C" -sf "#E0E0E0" -i -p "Do you really want to $1?") = "YES" ] && action

exit 0
