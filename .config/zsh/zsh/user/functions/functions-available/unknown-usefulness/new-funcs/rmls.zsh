#!/bin/env bash


function rmls(){
  local IINPUT="$1"
  echo "$IINPUT"

  [[ -z "$IINPUT" ]] \
    && echo -e "Usage:\t$0 <file(s)>" \
      && return 1

  clear
  lsd -A -l --total-size --sizesort --reverse
  echo -e "\e[1;38;5;5m▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂\e[0m\n"

  if [[ -d "$IINPUT" ]]; then
    echo -e "\e[1;38;5;190m'$IINPUT'\e[0;1;38;5;186m is a directory...\e[0m"
    echo -e "\e[1;38;5;186mPress \e[0;1;38;5;127m'y'\e[0;1;38;5;186m To Remove:\t\e[0;38;5;6m'$IINPUT'\e[0m \e[1;38;5;186mand ALL contents of \e[0;38;5;6m'$IINPUT'\e[0m"
    read -s -r -t 10 -q toremoveornottoremovedir
    echo -e ""
    if [[ "$toremoveornottoremovedir" == "y" ]]; then
      echo -e "Are you sure? Press 'y' To Remove:\t'$IINPUT' and ALL contents of '$IINPUT'" && read -s -r -t 5 -q toremoveornottoremove
#      toremoveornottoremove="$toremoveornottoremove"
    else
      echo -e "\e[1;38;5;4mExiting without removing \e[0;38;5;6m '$IINPUT'\e[0m:("
      return 1
    fi

  elif [[ -f "$IINPUT" ]]; then
    echo -e -n "\tPress 'y' To Remove:\t\e[0;38;5;6m'$IINPUT'\e[0m" && read -s -r -t 10 -q toremoveornottoremove
    echo -e ""
#    toremoveornottoremove="$toremoveornottoremove"
  else
      echo -e "\e[1;38;5;4m'$IINPUT'\e[0;38;5;6m is not a file \e[0m:("
      return 1
  fi

  if [[ "$toremoveornottoremove" == "y" ]]; then
    rm -v -f -r "$IINPUT"
    sleep 0.5
#    clear
    lsd -A -l --total-size --sizesort --reverse
  elif [[ "$toremoveornottoremove" == "n" ]]; then
    echo -e "\e[1;38;5;82mExiting ...\e[0m"

  else
    echo -e "\e[1;38;5;4mExiting without removing \e[0;38;5;6m '$IINPUT'\e[0m:("
  fi
}
