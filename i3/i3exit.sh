#!/bin/sh
lock() {
    i3lock
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        # i3-msg exit
        i3-nagbar -t warning -m 'Do you really want to logout?' -b 'Logout' 'i3-msg exit'
        ;;
    suspend)
        lock && systemctl suspend
        ;;
    reboot)
        # systemctl reboot
        i3-nagbar -t warning -m 'Do you really want to reboot?' -b 'Reboot' 'systemctl reboot'
        ;;
    shutdown)
        # systemctl poweroff
        i3-nagbar -t warning -m 'Do you really want to shutdown?' -b 'Shutdown' 'systemctl poweroff'
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
        exit 2
esac

exit 0
