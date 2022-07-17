#!/bin/env bash

function getIP(){

  nmcli device show \
    | grep IP4.ADDRESS \
      | grep -v '127.0.0.1' \
        | awk '{print $2}' \
          | sed s/\\/\..// \
            | head -n 1 \
              || return 1

}

function generateQR(){

  QRdata="$1"
  [[ -z "$QRdata" ]] \
    && echo "ERROR: no input to QR" \
      && return 1
  
  QRcmd=$(which qr)
  [[ -z "$QRcmd" ]] \
    && echo "Cannot Find 'qrencode'" \
      && return 1

  "$QRcmd" "$QRdata" \
    || echo "ERROR generating QR code" \
      || return 1
}


function startHTTPserver(){

  serverPORT="$1"
  [[ -z "$serverPORT" ]] \
    && echo "ERROR: No port received" \
    && return 1
  
  python -m http.server "$serverPORT"
}

function helpmenu(){

  echo -e "\n\e[1;4;38;5;21mDESCRIPTION\e[0m\n\t\e[38;5;15mSimple HTTP server that serves files from the current directory and any of its subdirectories.\n\n\tWhen run, it outputs a QR code of the address of the server.\e[0m\n"
  echo -e "\n\e[1;4;38;5;21mUSAGE\e[0m\n\t\e[38;5;15m$0 \e[3;38;5;8m[PORT]\e[0m\n"
  return 0


}

function _http_server_QR(){

 [[ "$1" == "-h" ]] \
   || [[ "$1" == "--help" ]] \
    && helpmenu \
      && return 0

  clear

  local PORT="$1"
  [[ -z "$PORT" ]] \
    && local PORT="8000"

  local IPADDR=$(getIP)
  [[ -z "$IPADDR" ]] \
    && echo "Cannot get IP" \
      && return 1

  local IPADDRPORTURL="http://$IPADDR:$PORT"
  [[ -z "$IPADDRPORTURL" ]] \
    && echo "ERROR: Cannot find IP or Port" \
      && return 1

  echo "$IPADDRPORTURL"
  generateQR "$IPADDRPORTURL" \

  startHTTPserver "$PORT" \
    || echo "ERROR: cannot start http server" \
      && echo "Goodbye" \
        && return 0
}


_http_server_QR "$1"
