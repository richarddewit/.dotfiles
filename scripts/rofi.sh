# --- APPLY XRES BEGIN
c_background="2C3E50"
c_green_l="2ECC71"
c_magenta_d="9B59B6"
c_black_l="95A5A6"
c_foreground="E0E0E0"
c_blue_d="3498DB"
c_magenta_l="9B59B6"
c_blue_l="3498DB"
c_white_l="ECF0F1"
c_green_d="2ECC71"
c_yellow_d="F1C40F"
c_cursor="E0E0E0"
c_cyan_l="1ABC9C"
c_white_d="E0E0E0"
c_cyan_d="1ABC9C"
c_red_d="E74C3C"
c_red_l="E74C3C"
c_yellow_l="F1C40F"
c_black_d="2C3E50"
# --- APPLY XRES END

tod=`~/scripts/timeofday.sh`

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
    bg="$c_background"
    fg="$c_yellow_d"
    ;;
  "Night")
    bg="$c_black_d"
    fg="$c_blue_l"
    ;;
esac

width=`xrandr | grep "*" | sed -r 's/\s*([0-9]+)\s*x\s*([0-9]+).*/\1/g' | head -n 1`
height=`xrandr | grep "*" | sed -r 's/\s*([0-9]+)\s*x\s*([0-9]+).*/\2/g' | tail -n 1`
lines=8
font_size=18
line_height=`echo $font_size | awk '{print int($1*1.5)}'`
padding=$((($height-($lines*$line_height+48))/2))
rofi -dmenu -i -show run -width $width -fg "#$fg" -bg "#$bg" -hlbg "#$fg" -hlfg "#$bg" -bc "#$c_background" -location 0 -lines $lines -bw 0 -font "Hack $font_size" -padding $padding -separator-style none -opacity 85

