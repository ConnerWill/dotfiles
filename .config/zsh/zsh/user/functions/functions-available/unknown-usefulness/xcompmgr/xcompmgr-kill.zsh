function xcompmgr-kill(){

  local PIDOFXCOMPMGR=$(pidof xcompmgr)
  
  kill "$PIDOFXCOMPMGR" \
    || echo "CANNOT KILL 'xcompmgr'" \
      || return

}
