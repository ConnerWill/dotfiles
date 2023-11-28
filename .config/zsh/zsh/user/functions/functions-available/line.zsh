#!/bin/env bash


_hrs_hr() {
  local WORD LINE
  WORD="${1}"
  LINE=''
  [[ -z "$WORD" ]] && return
  printf -v LINE '%*s' "$COLS"
  LINE="${LINE// /${WORD}}"
  echo "${LINE:0:${COLS}}"
}

line() {
  COLS="$(tput cols)"
  (( COLS <= 0 )) && COLS="${COLUMNS:-80}"
    local WORD
    for WORD in "${@:-═}"; do
      _hrs_hr "$WORD"
    done
}

# [[ "${0}" == "$BASH_SOURCE" ]] && hrs "${@}"
