# Colors Base16 Tomorrow
c_foreground="c5c8c6"
c_background="1d1f21"

c_black_d="1d1f21"
c_black_l="969896"
c_white_d="c5c8c6"
c_white_l="ffffff"

c_red_d="cc6666"
c_red_l="cc6666"
c_green_d="b5bd68"
c_green_l="b5bd68"
c_yellow_d="f0c674"
c_yellow_l="f0c674"
c_blue_d="81a2be"
c_blue_l="81a2be"
c_magenta_d="b294bb"
c_magenta_l="b294bb"
c_cyan_d="8abeb7"
c_cyan_l="8abeb7"

tod=`~/scripts/timeofday.sh`

# Uncomment a tod to test
# tod="Late Night"
# tod="Early Morning"
# tod="Morning"
# tod="Afternoon"
# tod="Late Afternoon"
# tod="Evening"
# tod="Night"

bg="$c_background"  # Default background for undefined times of day
fg="$c_foreground"
case $tod in
  "Late Night")
    bg="$c_black_d"
    fg="$c_black_l"
    ;;
  "Early Morning")
    bg="$c_blue_d"
    fg="$c_black_d"
    ;;
  "Morning")
    bg="$c_cyan_d"
    fg="$c_white_l"
    ;;
  "Afternoon")
    bg="$c_white_l"
    fg="$c_black_l"
    ;;
  "Late Afternoon")
    bg="$c_yellow_d"
    fg="$c_black_d"
    ;;
  "Evening")
    bg="$c_black_l"
    fg="$c_yellow_d"
    ;;
  "Night")
    bg="$c_black_d"
    fg="$c_blue_l"
    ;;
esac

# rofi -dmenu -i -show run -fullscreen -hide-scrollbar -fg "#$fg" -bg "#$bg" -hlbg "#$fg" -hlfg "#$bg" -bc "#$c_background" -location 0 -lines 8 -bw 0 -font "Hack 20" -padding 400 -separator-style none -opacity 85
rofi \
  -dmenu \
  -i \
  -show run \
  -p 'λ ' \
  -fullscreen \
  -hide-scrollbar \
  -color-window "#$bg, #$fg, #$fg" \
  -color-normal "#$bg, #$fg, #$bg, #$fg, #$bg" \
  -location 0 \
  -lines 8 \
  -bw 5 \
  -font "Terminus bold 24" \
  -padding 300 \
  -separator-style dash \
  -opacity 85
