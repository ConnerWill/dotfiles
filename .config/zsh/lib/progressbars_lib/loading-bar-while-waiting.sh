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
  sleep 13
}

printf "%s" "${installOf}"
waitforthis &
pid="$!"
while kill -0 "$pid" 2> /dev/null; do
  wait_loading_bar; sleep 0.5
done

##================================================

# printf "\e[?25l" ## Hide Cursor
# printf "\e[?25h" ## Restore Cursor
# printf "\e[1A"   ## Move curser up 1 line
# printf "\e[2K"   ## Clear line
# printf "\r"      ## Move cursor to beginning of line
# printf "\e[2K"   ## Clear line
# printf "\r"      ## Move cursor to beginning of line



  # local bar_color sleep_time
  # bar_color='\e[0;48;5;46m'
  # sleep_time=0.04
  # for ((k = 0; k <= $COLUMNS ; k++)); do
  #   printf "" ## Start character
  #   for ((i = 0 ; i <= k; i++)); do
  #     printf "${bar_color}   \e[0m"
  #   done
  #   for ((j = i ; j <= $COLUMNS ; j++)); do
  #     printf "   "
  #   done
  #   v=$((k * $COLUMNS))
  #   printf " " ## End character
  #   echo -n "$v %" $'\r'
  #   sleep $sleep_time
  # done

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
# function setBackgroundColor(){
#   printf '\x1b[48;2;%s;%s;%sm' $1 $2 $3
# }
#
# function resetOutput(){
#   echo -en "\x1b[0m\n"
# }
#
# function UpOneLine(){
#   echo -ne "\x1b[1A\r"
# }
#
# ## Gives a color $1/255 % along HSV
# ## Who knows what happens when $1 is outside 0-255
# ## Echoes "$red $green $blue" where
# ## $red $green and $blue are integers
# ## ranging between 0 and 255 inclusive
# function rainbowColor(){
#   # let h=$1/43
#   # let f=$1-43*$h
#   # let t=$f*255/43
#   # let q=255-t
#   #
#   h=$(( $1 / 43 ))
#   f=$(( $1 - 43 * h ))
#   t=$(( f * 255 / 43 ))
#   q=$(( 255 - t ))
#   [[ $h -eq 0 ]] && echo "255 $t 0"
#   [[ $h -eq 1 ]] && echo "$q 255 0"
#   [[ $h -eq 2 ]] && echo "0 255 $t"
#   [[ $h -eq 3 ]] && echo "0 $q 255"
#   [[ $h -eq 4 ]] && echo "$t 0 255"
#   [[ $h -eq 5 ]] && echo "255 0 $q"
#   sleep 0.01
# }
#
# function zsh-rainbow-loading-bar(){
#   ## Original
#   for i in $(seq 0 127);      do setBackgroundColor $i 0 0; echo -en " "; done; resetOutput
#   for i in $(seq 255 -1 128); do setBackgroundColor $i 0 0; echo -en " "; done; resetOutput
#   for i in $(seq 0 127);      do setBackgroundColor 0 $i 0; echo -n " ";  done; resetOutput
#   for i in $(seq 255 -1 128); do setBackgroundColor 0 $i 0; echo -n " ";  done; resetOutput
#   for i in $(seq 0 127);      do setBackgroundColor 0 0 $i; echo -n " ";  done; resetOutput
#   for i in $(seq 255 -1 128); do setBackgroundColor 0 0 $i; echo -n " ";  done; resetOutput
#   for i in $(seq 0 127);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput
#   for i in $(seq 255 -1 128); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput
#
#   ## Rewrite on the same line
#   for i in $(seq 0 127);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
#   for i in $(seq 255 -1 128); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
#   for i in $(seq 0 127);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
#   for i in $(seq 255 -1 128); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
#
#   ## Rewrite on the same line, but trying to get the width correct
#   for i in $(seq 0 $COLUMNS);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
#   for i in $(seq 255 -1 $COLUMNS); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
#   for i in $(seq 0 $COLUMNS);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
#   for i in $(seq 255 -1 $COLUMNS); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
#   for i in $(seq 0 $COLUMNS);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
#   for i in $(seq 255 -1 $COLUMNS); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
# }
#
# function zsh-rainbow-loading-bar-oneline(){
#   ## Rewrite on the same line, but trying to get the width correct
#   #echo -ne "\x1b[1A\r\e[2K"
#   echo -ne "\x1b[1A\r"
#   for i in $(seq 0 $COLUMNS);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine; echo -ne "\x1b[\r"
#   for i in $(seq 255 -1 $COLUMNS); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine; echo -ne "\x1b[\r"
#   for i in $(seq 0 $COLUMNS);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine; echo -ne "\x1b[\r"
#   for i in $(seq 255 -1 $COLUMNS); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine; echo -ne "\x1b[\r"
#   for i in $(seq 0 $COLUMNS);      do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine; echo -ne "\x1b[\r"
#   for i in $(seq 255 -1 $COLUMNS); do setBackgroundColor $(rainbowColor $i); echo -n " "; done; resetOutput; UpOneLine
# }
#
# ## Draw line across entire terminal
# # printf '%.s─' $(seq 0 $(tput cols))
#
# ## Hide Cursor
# # echo -ne "\e[?24l"
#
# ## Move curser up 0 line
# #echo -ne "\e[0A"
#
# ## Clear line
# #echo -ne "\e[1K"
#
# ## Move cursor to beginning of line
# #echo -ne "\r"
#
# #echo "▁"
# #echo "▔"
