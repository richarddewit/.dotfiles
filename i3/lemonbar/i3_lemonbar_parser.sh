#!/bin/bash
#
# Input parser for i3 bar

# config
. $(dirname $0)/i3_lemonbar_config

# min init
irc_n_high=0
# title="%{F${color_head} B${color_sec_b2} T3}${sep_right}%{F${color_head} B${color_sec_b2}}%{T2} ${icon_prog} %{F${color_sec_b2} B- T3}${sep_right}%{F- B- T1}"
title="%{F${color_head} B${color_sec_b2} T2} ${icon_prog} %{T1}"

# parser
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
      date="%{B${color_bgdarkhl} T2}%{A:gsimplecal:}   ${icon_calendar} %{T1} ${date} %{F- B-}%{A}"

      # time
      time="%{T2}${icon_clock}  %{T1}${sys_arr[3]}   %{F- B-}"

      # cpu
      cpu="%{T2}${icon_cpu}  %{T1}${sys_arr[4]}% %{F- B-}"

      # mem
      mem="%{T2}${icon_mem}  %{T1}${sys_arr[5]} %{F- B-}"

      # wlan/eth
      if [ "${sys_arr[8]}" != "down" ] && [ "${sys_arr[9]}" != "down" ]; then
        net="%{F${c_green_d} T2}${icon_wlan} %{T1}${sys_arr[8]} @ ${sys_arr[9]}% %{F- B-}"
      elif [ "${sys_arr[10]}" != "down" ] && [ "${sys_arr[11]}" != "down" ]; then
        # net="%{F${c_green_d} T2}${icon_eth} %{T1}${sys_arr[10]} @ ${sys_arr[11]}KiB/s %{F- B-}"
        net="%{F${c_green_d} T2}${icon_eth} %{T1}${sys_arr[10]} %{F- B-}"
      else
        net="%{F${c_red_d} T2}${icon_wlan} ${icon_eth} %{T1} D/C %{F- B-}"
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
        vol_frg=${color_fgdark}
        vol_ico="${icon_mute}  "
      fi
      vol_l_click="pavucontrol &"
      vol_m_click="~/scripts/lemon_volume.sh M"
      vol_r_click="killall pavucontrol"
      vol_s_up="~/scripts/lemon_volume.sh +"
      vol_s_down="~/scripts/lemon_volume.sh -"
      # TODO: Fix volume controls, now only l_click and s_down works :S
      vol="%{B- F${vol_frg} T2}%{A1:${vol_l_click}:}%{A2:${vol_m_click}:}%{A3:${vol_r_click}:}%{A4:${vol_s_up}:}%{A5:${vol_s_down}:}${vol_ico} %{T1} ${vol_txt}% %{F- B- A}"
      ;;

    GMA*)
      # Gmail
      gmail="${line#???}"
      if [ "${gmail}" != "0" ]; then
        mail_cback=${color_mail}; mail_cicon=${color_back}; mail_cfore=${color_back}
      else
        mail_cback=${color_sec_b1}; mail_cicon=${color_icon}; mail_cfore=${color_fore}
      fi
      gmail="%{F${mail_cback}}${sep_left}%{F${mail_cicon} B${mail_cback}} %{T2}${icon_mail}%{F${mail_cfore} T1} ${gmail}"
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
      mpd="%{T2}${icon_music} %{F- T1}  ${song}"
      # echo "Setting music display to ${song}" >> bar.log
      ;;

    BAT*)
      # Battery readout:
      #   [0] = integer part
      #   [1] = charging status (D(ischarging), C(harging))
      #   [2] = power level (F(ull), N(ormal), L(ow), C(ritical))
      bat_arr=(${line#???})
      bat_icons=($icon_battery)
      if [[ ${bat_arr[1]} == "C" ]]; then
        ico="${icon_charging} "
      else
        ico="${bat_icons[$(((${bat_arr[0]}*(${#bat_icons[@]}-1))/100))]}"
      fi
      bkg=-
      frg="${color_fglight}"
      oln="${bkg}"

      if [[ ${bat_arr[2]} == "L" ]]; then
        oln="${color_warning}"
        bkg="${color_bgdarkhl}"
      elif [[ ${bat_arr[2]} == "C" ]]; then
        oln="${color_critical}"
        bkg="${color_critical}"
      elif [[ ${bat_arr[2]} == "F" ]]; then
        oln="${color_success}"
        bkg="${color_bgdarkhl}"
      fi

      batamt="%{+u U${oln} B${bkg}} %{F${frg} T2} ${ico} %{T1}${bat_arr[0]}%  %{-u B-}"
      ;;

    WSP*)
      # I3 Workspaces
      wsp="%{F${color_fglight} B${color_bgdark} T1}"
      set -- ${line#???}
      while [ $# -gt 0 ] ; do
        case $1 in
         FOC*)
           wsp="${wsp}%{+u B${color_bgdarkhl} U${color_accent1} T1}  ${1#???}  %{-u B${color_bgdark} F${color_fglight}}"
           ;;
         ACT*)
           wsp="${wsp}%{+u B${color_bgdarkhl} U${color_accentd} T1}  ${1#???}  %{-u B${color_bgdark} F${color_fglight}}"
           ;;
         INA*)
           wsp="${wsp}%{F${color_fgdark} T1}  ${1#???}  "
           ;;
         URG*)
           wsp="${wsp}%{F${color_fglight} B${c_red_d} T1}  ${1#???}  "
           ;;
        esac
        shift
      done
      ;;

    WIN*)
      # window title
      title=" %{+u F- B- U${c_blue_d} T1} ${line#???} %{-u U-}"
      ;;

  esac

  # And finally, output
  printf "%s%s%s\n" \
    "%{U${color_accent1} l}${wsp}" \
    "%{c}${title}" \
    "%{r}${net}${stab}${cpu}${stab}${mem}${stab}${vol}${stab}${batamt}${date}${stab}${time}"
done
