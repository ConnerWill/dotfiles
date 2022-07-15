#!/bin/env bash


#export ZSHDDIR="$ZDOTDIR/zsh.d"
export ZSHDDIR="$HOME/temporary/zsh.d"

function _source_zshd(){

  [[ -z "$ZSHDDIR" ]] \
    && printf "\n'ZSHDDIR' is not defined\n" \
      && return 1

  [[ ! -d "$ZSHDDIR" ]] \
    && printf "\n'ZSHDDIR' is defined but does not exist...\nCreating directory: '%s\n" "$ZSHDDIR" \
      && mkdir -p "$ZSHDDIR" \
        && printf "\n# You can place 'zsh' or 'sh' scripts/configs\n# in the directory: '%s'" "${ZSHDDIR}" \
        && printf "\n# they will be sourced if they have and extension of '.zsh' or '.sh'\n# (eg.  '%s/example.zsh')\n" "${ZSHDDIR}" \
          | tee "$ZSHDDIR/00_begin.zsh" \
            && sleep 2

  if [ -d "$ZSHDDIR" ]; then 
    LSPATH="$(whereis ls | awk '{print $2}')"
    [[ ! -e "${LSPATH}" ]] \
      && printf "Cannot find command 'ls'\nConfirm it is in your PATH" \
        && return 1
    for zshd in $(${LSPATH} -A ${ZSHDDIR}/*.(z)sh); do
      if [ -f "${zshd}" ]; then
        printf "\e[38;5;241mSourcing:\e[0m\t\e[38;5;241m'\e[0m\e[38;5;190m%s\e[0m\e[38;5;241m'\e[0m\n" "${zshd}" \
        ZSHDIR_SCRIPT="$(realpath "$0")"
        local ZSHDIR_SCRIPT
        [[ ${zshd} != "$ZSHDIR_SCRIPT" ]] \
          && source "${zshd}"
      fi
    done
  fi
}
