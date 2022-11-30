#!/bin/bash

PROG=$0
PROGDIR="$(dirname "$PROG")"
FONTDIR="$PROGDIR/fonts"
OUTPATH="${HOME}/nmap-scans/${targets[1]}"

function nmap-html-output(){
  local input outpath
  declare -a targets

  declare -a fonts=( $(find $FONTDIR -type f) )
  fontsnum=$(echo ${fonts[@]} | wc -l)
  echo $fontsnum
  randnum=$(shuf -i 1-$fontsnum -n 1)

  echo $randnum
  randfont=$(basename --suffix='.flf' "${fonts[$randnum]}")

  command -v toilet >/dev/null 2>&1 && toilet --directory "${FONTDIR}" --gay --filter border --font "${randfont}" "NMAP"

  targets=( ${@} )
  [[ -z "${targets}" ]] && printf "No Target!\tYou no want scan???\n" && return 1

  outpath="${OUTPATH}/${targets[1]}"
  if [[ ! -d "${outpath}"  ]]; then
   mkdir -pv "${outpath}" || printf "Cannot create dir:\t%s\n" "${outpath}"  || return 1
  fi

  nmap -vv -sV -T4 --unprivileged -P --script=default -A --webxml -oA "${outpath}" "${targets[@]}"
}

nmap-html-output "${@}"
