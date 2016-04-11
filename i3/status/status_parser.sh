#!/usr/bin/env bash

. $(dirname $0)/status_parser.conf

while read -r line ; do
  case $line in
    CNK*)
      # Conky
      set -- ${line#???}

      weekday=$1; shift
      day=$1; shift
      month=$1; shift
      time=$1; shift

      cpu=$1; shift
      mem=$1; shift
      mem_perc=$1; shift

      disk_root_free=$1; shift
      disk_root_used_perc=$1; shift

      disk_home_free=$1; shift
      disk_home_used_perc=$1; shift

      wifi_ssid=$1; shift
      wifi_sig=$1; shift

      eth_ip=$1; shift
      eth_dl=$1; shift

      # date
      date="${icon_calendar} ${weekday} ${day} ${month}"
      printf -v date "$text_str" "$date"

      # time
      time="${icon_clock} ${time}"
      printf -v time "$text_str" "$time"

      # cpu
      color="$white"
      [ "$cpu" -ge "$cpu_critical_threshold" ] && color="$base08"
      cpu="${icon_cpu} ${cpu}%"
      printf -v cpu "$text_color_str" "$cpu" "$color"

      # mem
      mem="${icon_mem} ${mem}"
      color="$white"
      [ "$mem_perc" -ge "$mem_critical_threshold" ] && color="$base08"
      printf -v mem "$text_color_str" "$mem" "$color"

      # disk
      if [[ "$disk_root_free" = "$disk_home_free" ]]; then
        # Most probably the same disk
        disk_root="${icon_disk} ${disk_root_free}"

        disk_home=""
      else
        # Home is a separate partition
        disk_root="${icon_disk}${icon_linux} ${disk_root_free}"

        disk_home="${icon_disk}${icon_home} ${disk_home_free}"
        color="$white"
        [ "$disk_home_used_perc" -ge "$disk_warning_threshold" ] && color="$base0A"
        [ "$disk_home_used_perc" -ge "$disk_critical_threshold" ] && color="$base08"
        printf -v disk_home "$text_color_str" "$disk_home" "$color"
      fi
      color="$white"
      [ "$disk_root_used_perc" -ge "$disk_warning_threshold" ] && color="$base0A"
      [ "$disk_root_used_perc" -ge "$disk_critical_threshold" ] && color="$base08"
      printf -v disk_root "$text_color_str" "$disk_root" "$color"


      # wlan/eth
      if [ "$wifi_ssid" != "down" ] && [ "$wifi_sig" != "down" ]; then
        net="${icon_wlan} ${wifi_ssid} @ ${wifi_sig}%"
        net_color="$base0B"
      elif [ "$eth_ip" != "down" ] && [ "$eth_dl" != "down" ]; then
        net="${icon_eth} ${eth_ip}"
        net_color="$base0B"
      else
        net="${icon_wlan} ${icon_eth} D/C"
        net_color="$base08"
      fi
      printf -v net "$text_color_str" "$net" "$net_color"
      ;;

    BAT*)
      # Battery readout:
      #   [0] = integer part
      #   [1] = charging status (D(ischarging), C(harging))
      #   [2] = power level (F(ull), N(ormal), L(ow), C(ritical))
      bat_arr=(${line#???})
      bat_icons=($icon_battery)
      if [[ ${bat_arr[1]} == "C" ]]; then
        icon="${icon_charging}"
      else
        icon="${bat_icons[$(((${bat_arr[0]}*(${#bat_icons[@]}-1))/100))]}"
      fi
      color="$white"

      if [[ ${bat_arr[2]} == "L" ]]; then
        color="$base0A"
      elif [[ ${bat_arr[2]} == "C" ]]; then
        color="$base08"
      elif [[ ${bat_arr[2]} == "F" ]]; then
        color="$base0B"
      fi

      bat="${icon} ${bat_arr[0]}%"
      printf -v bat "$text_color_str" "$bat" "$color"
      ;;

    VOL*)
      # Volume:
      #   [0] Muted indicator: (M=Muted / (anything else)=Unmuted)
      #   [1] On/off (muted) status (1=Unmuted / 0=Muted)
      vol_arr=(${line#???})
      color="$white"
      vol_ico=$icon_vol
      vol_txt=${vol_arr[1]}
      if [[ ${vol_arr[0]} == "M" ]]; then
        color="$base0A"
        vol_ico=$icon_mute
      fi

      # Click handlers
      # vol_l_click="pavucontrol &"
      # vol_m_click="~/scripts/lemon_volume.sh M"
      # vol_r_click="killall pavucontrol"
      # vol_s_up="~/scripts/lemon_volume.sh +"
      # vol_s_down="~/scripts/lemon_volume.sh -"

      vol="${vol_ico} ${vol_txt}%"
      printf -v vol "$text_color_str" "$vol" "$color"
      ;;

    WIN*)
      # Window title
      title="${line#???}"
      title=$(echo "$title" | sed "s/\\\'/'/g")
      printf -v title "$text_color_str" "$title" "$base0C"
      ;;

  esac

  echo "[${title}${net}${cpu}${mem}${disk_root}${disk_home}${vol}${bat}${date}${time}${last_empty}],"
done

