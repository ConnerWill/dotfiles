#!/bin/bash
#
# https://notes.burke.libbey.me/ansi-escape-codes/
## This file was originally taken from iterm2 https://github.com/gnachman/iTerm2/blob/master/tests/24-bit-color.sh
##
## This file echoes a bunch of 24-bit color codes
## to the terminal to demonstrate its functionality.
## The foreground escape sequence is ^[38;2;<r>;<g>;<b>m
## The background escape sequence is ^[48;2;<r>;<g>;<b>m
## <r> <g> <b> range from 0 to 255 inclusive.
## The escape sequence ^[0m returns output to default

function setBackgroundColor(){
  printf '\x1b[48;2;%s;%s;%sm' $1 $2 $3
}

function resetOutput(){
  echo -en "\x1b[0m\n"
}

function UpOneLine(){
  echo -ne "\x1b[1A\r"
}

## Gives a color $1/255 % along HSV
## Who knows what happens when $1 is outside 0-255
## Echoes "$red $green $blue" where
## $red $green and $blue are integers
## ranging between 0 and 255 inclusive
function rainbowColor(){ 
  let h=$1/43
  let f=$1-43*$h
  let t=$f*255/43
  let q=255-t
  [[ $h -eq 0 ]] && echo "255 $t 0"
  [[ $h -eq 1 ]] && echo "$q 255 0"
  [[ $h -eq 2 ]] && echo "0 255 $t"
  [[ $h -eq 3 ]] && echo "0 $q 255"
  [[ $h -eq 4 ]] && echo "$t 0 255"
  [[ $h -eq 5 ]] && echo "255 0 $q"
}

function zsh-rainbow-loading-bar(){
  ## Original
  for i in $(seq 0 127);      do setBackgroundColor $i 0 0; echo -en " "; done; resetOutput
  for i in $(seq 255 -1 128); do setBackgroundColor $i 0 0; echo -en " "; done; resetOutput
  for i in $(seq 0 127);      do setBackgroundColor 0 $i 0; echo -n " ";  done; resetOutput
  for i in $(seq 255 -1 128); do setBackgroundColor 0 $i 0; echo -n " ";  done; resetOutput
  for i in $(seq 0 127);      do setBackgroundColor 0 0 $i; echo -n " ";  done; resetOutput
  for i in $(seq 255 -1 128); do setBackgroundColor 0 0 $i; echo -n " ";  done; resetOutput
  for i in $(seq 0 127);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput
  for i in $(seq 255 -1 128); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput

  ## Rewrite on the same line
  for i in $(seq 0 127);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
  for i in $(seq 255 -1 128); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
  for i in $(seq 0 127);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
  for i in $(seq 255 -1 128); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine

  ## Rewrite on the same line, but trying to get the width correct
  for i in $(seq 0 $COLUMNS);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
  for i in $(seq 255 -1 $COLUMNS); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
  for i in $(seq 0 $COLUMNS);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
  for i in $(seq 255 -1 $COLUMNS); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
  for i in $(seq 0 $COLUMNS);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
  for i in $(seq 255 -1 $COLUMNS); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
}

## Draw line across entire terminal
# printf '%.s─' $(seq 0 $(tput cols))

## Hide Cursor
# echo -ne "\e[?24l"

## Move curser up 0 line
#echo -ne "\e[0A"

## Clear line
#echo -ne "\e[1K"

## Move cursor to beginning of line
#echo -ne "\r"

#echo "▁"
#echo "▔"


