if [[ -n "${DISPLAY}" ]]; then
  toggle-monitor-power(){
    local monitor_status monitor_action
    is-monitor-on(){ xset q | grep 'Monitor is' | cut -d' ' -f5 }
    monitor_status=$(is-monitor-on) ; unfunction is-monitor-on
    [[ "${monitor_status:l}" == "on"  ]] && monitor_action="off"
    [[ "${monitor_status:l}" == "off" ]] && monitor_action="on"
    echo "Turning monitors: '${monitor_action}' in 5 seconds...\n\nPress <Ctrl-c> to cancel!"
    sleep 5 || return 1 && xset dpms force "${monitor_action}"
  }
fi
