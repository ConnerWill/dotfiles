function qr-code(){
  local linktoencode 
  local _no_input_error
  local QR_prog
  local linesep

  _no_input_error='No Input Received'
  _no_qr_error='"qr" is not installed'
  linesep="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

  QR_prog=$(which qr)
  [[ -a "$QR_prog" ]] \
    || printf '\e[0;1;48;5;196;38;5;15m ERROR \e[0;38;5;190m  %s\e[0;1;38;5;201m :(\e[0m\n' "$_no_qr_error" \
      || return 1

  linktoencode="$1"
  [[ -z "$linktoencode" ]] \
    && printf '\e[0;1;48;5;196;38;5;15m ERROR \e[0;38;5;190m  %s\e[0;1;38;5;201m :(\e[0m\n' "$_no_input_error" \
      && return 1

  clear
  printf '\e[0;1;38;5;87m%s\e[0m\n' "$linesep"
  echo "$linktoencode" | ${QR_prog}
  printf '\e[0;1;38;5;87m%s\e[0m\n' "$linesep"
  printf '\e[0;1;38;5;93m%s\e[0m\n' "$linktoencode"
  printf '\e[0;1;38;5;87m%s\e[0m\n' "$linesep"
  return 0 
}

