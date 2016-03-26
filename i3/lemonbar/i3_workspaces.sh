# Print i3 workspaces on every change.
#
# Format:
#   For every workspace (x = workspace name)
#       - "FOCx" -> Focused workspace
#       - "INAx" -> Inactive workspace
#       - "ACTx" -> Active workspace
#       - "URGx" -> Urgent workspace

containsElement () {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

# $ws1="1 "
# $ws2="2 "
# $ws3="3 "
# $ws4="4"
# $ws5="5"
# $ws6="6"
# $ws7="7 "
# $ws8="8 "
# $ws9="9 "
# $ws10="10"

wss=(
  "1 "
  "2 "
  "3 "
  "4"
  "5"
  "6"
  "7 "
  "8 "
  "9 "
  "10"
)

while true; do
  msg=`i3-msg -t get_workspaces`
  current_ws=`echo "$msg" | jq -r 'map(select(.focused))[0].num'`
  urgent_ws=`echo "$msg" | jq -r 'map(select(.urgent))[0].num'`
  active_wss_list=`echo "$msg" | jq -r 'map(.num)|.[]'`
  active_wss=()
  while read -r line; do
    active_wss+=("$line")
  done <<< "$active_wss_list"

  output='WSP'

  for (( i = 0; i < ${#wss[@]}; i++ )); do
    ws_ix=$(($i+1))
    current_ws_name="${wss[$i]}"

    if [ "$ws_ix" = "$urgent_ws" ]; then
      output+="URG${current_ws_name} "
    elif [ "$ws_ix" = "$current_ws" ]; then
      output+="FOC${current_ws_name} "
    elif [[ " ${active_wss[@]} " =~ " ${ws_ix} " ]]; then
      output+="ACT${current_ws_name} "
    else
      output+="INA${current_ws_name} "
    fi
  done

  echo $output
  sleep 0.5
done

