#!/bin/bash
#
# Input parser for i3 bar

# Load config
. $(dirname $0)/i3_lemonbar_config


# Parser
while read -r line ; do
  case $line in
    SYS*)
      # conky sys_arr:
      # 0 = weekday
      # 1 = day
      # 2 = month
      # 3 = time
      # 4 = cpu
      # 5 = mem
      # 6 = disk /
      # 7 = disk /home
      # 8-9 = ssid/sigstr wlan
      # 10-11 = ip/dlspeed eth
      sys_arr=(${line#???})

      # date
      date="${sys_arr[0]} ${sys_arr[1]} ${sys_arr[2]}"
      date="%{A:gsimplecal:} ${icon_calendar} ${date} %{A}"

      # time
      time=" ${icon_clock} ${sys_arr[3]} "

      # cpu
      cpu=" ${icon_cpu} ${sys_arr[4]}% "

      # mem
      mem=" ${icon_mem} ${sys_arr[5]} "

      # wlan/eth
      if [ "${sys_arr[8]}" != "down" ] && [ "${sys_arr[9]}" != "down" ]; then
        net="%{F${c_green_d}} ${icon_wlan} ${sys_arr[8]} @ ${sys_arr[9]}% %{F-}"
      elif [ "${sys_arr[10]}" != "down" ] && [ "${sys_arr[11]}" != "down" ]; then
        net="%{F${c_green_d}} ${icon_eth} ${sys_arr[10]} %{F-}"
      else
        net="%{F${c_red_d}} ${icon_wlan} ${icon_eth} D/C %{F-}"
      fi
      ;;

    VOL*)
      # Volume:
      #   [0] Muted indicator: (M=Muted / (anything else)=Unmuted)
      #   [1] On/off (muted) status (1=Unmuted / 0=Muted)
      vol_arr=(${line#???})
      vol_frg=-
      vol_oln=-
      vol_ico=$icon_vol
      vol_txt=${vol_arr[1]}
      if [[ ${vol_arr[0]} == "M" ]]; then
        vol_frg=${c_yellow_d}
        vol_ico=$icon_mute
      fi
      vol_l_click="pavucontrol &"
      vol_m_click="~/scripts/lemon_volume.sh M"
      vol_r_click="killall pavucontrol"
      vol_s_up="~/scripts/lemon_volume.sh +"
      vol_s_down="~/scripts/lemon_volume.sh -"
      # TODO: Fix volume controls, now only l_click and s_down works :S
      vol="%{F${vol_frg} A1:${vol_l_click}: A2:${vol_m_click}: A3:${vol_r_click}: A4:${vol_s_up}: A5:${vol_s_down}:}${vol_ico} ${vol_txt}% %{F- A A A A A}"
      ;;

    MPD*)
      # Music
      mpd_arr=(${line#???})
      if [ -z "${line#???}" ]; then
        song="none";
      elif [ "${mpd_arr[1]}" == "error:" ]; then
        song="mpd off";
      else
        song="${line#???}";
      fi
      mpd=" ${icon_music} ${song} "
      ;;

    BAT*)
      # Battery readout:
      #   [0] = integer part
      #   [1] = charging status (D(ischarging), C(harging))
      #   [2] = power level (F(ull), N(ormal), L(ow), C(ritical))
      bat_arr=(${line#???})
      bat_icons=($icon_battery)
      if [[ ${bat_arr[1]} == "C" ]]; then
        ico="${icon_charging}"
      else
        ico="${bat_icons[$(((${bat_arr[0]}*(${#bat_icons[@]}-1))/100))]}"
      fi
      bkg=-
      frg="${color_fglight}"
      oln="${color_back}"

      if [[ ${bat_arr[2]} == "L" ]]; then
        oln="${color_warning}"
      elif [[ ${bat_arr[2]} == "C" ]]; then
        oln="${color_critical}"
      elif [[ ${bat_arr[2]} == "F" ]]; then
        oln="${color_success}"
      fi

      batamt="%{+u U${oln} F${frg}} ${ico} ${bat_arr[0]}% %{-u}"
      ;;

    WSP*)
      # I3 Workspaces
      wsp="%{F${color_fglight} B${color_bgdark}}"
      set -- ${line#???}
      while [ $# -gt 0 ] ; do
        case $1 in
         FOC*)
           wsp="${wsp}%{F${color_accent1text} B${color_accent1}}  ${1#???}  %{F${color_fglight} B${color_bgdark}}"
           ;;
         ACT*)
           wsp="${wsp}%{+u U${color_accent2}}  ${1#???}  %{-u U-}"
           ;;
         INA*)
           wsp="${wsp}%{F${color_fgdark}}  ${1#???}  %{F${color_fglight}}"
           ;;
         URG*)
           wsp="${wsp}%{F${color_fglight} B${color_critical}}  ${1#???}  %{F${color_fglight} B${color_bgdark}}"
           ;;
        esac
        shift
      done
      ;;

    WIN*)
      # window title
      title=" %{+u U${c_cyan_d}}  ${line#???}  %{-u U-}"
      ;;

  esac

  # And finally, output
  printf "%s%s%s%s\n" \
    "%{l}  ${wsp}" \
    "%{Sf c}${title}" \
    "%{Sl c}${title}" \
    "%{r}${net}${stab}${cpu}${stab}${mem}${stab}${vol}${stab}${batamt}${date}${stab}${time}  "
done
