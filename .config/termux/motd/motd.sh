#!/bin/bash

function setBackgroundColor(){
  printf '\x1b[48;2;%s;%s;%sm' $1 $2 $3
}
function rainbowColor(){
  START=$(shuf -i 1-255 -n 1)
  h=$(( $1 / 43 ))
  f=$(( $1 - 43 * h ))
  t=$(( f * 255 / 43 ))
  q=$(( 255 - t ))
  [[ $h -eq 0 ]] && printf "255 %s 0" $t
  [[ $h -eq 1 ]] && printf "%s 255 0" $q
  [[ $h -eq 2 ]] && printf "0 255 %s" $t
  [[ $h -eq 3 ]] && printf "0 %s 255" $q
  [[ $h -eq 4 ]] && printf "%s 0 255" $t
  [[ $h -eq 5 ]] && printf "255 0 %s" $q
  sleep 0.00001
}
function wait_loading_bar(){
  printf "\r\e[3K\r"
  for i in $(seq 0 $(( COLUMNS - 2 ))); do
    setBackgroundColor $(rainbowColor $i)
    printf " "
  done
    printf "\r\e[3K\r"
  for i in $(seq $(( COLUMNS - 2 )) -1 0); do
    setBackgroundColor $(rainbowColor $i)
    printf " "
  done
}
function waitforthis(){
  # pkg upgrade >/dev/null 2>&1
  sleep 3 &
}
printf "%s" "${installOf}"
waitforthis &
pid="$!"
while kill -0 "$pid" 2> /dev/null; do
  wait_loading_bar
  sleep 0.1
done
