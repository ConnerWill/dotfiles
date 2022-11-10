#!/bin/bash
#shellcheck disable=2059

function gh-gist-clone(){
  local gist gistname userinput
  declare -A C
  C[GRAY]='\e[38;5;7m'     C[DARKGRAY]='\e[38;5;8m'
  C[GREEN]='\e[38;5;46m'   C[PURPLE]='\e[38;5;93m'
  C[YELLOW]='\e[38;5;190m' C[RED]='\e[38;5;196m'
  C[B]='\e[1m'             C[U]='\e[4m'
  C[I]='\e[3m'             C[RESET]='\e[0m'
  C[CURHIDE]='\e[?25l'     C[CURSHOW]='\e[?25h'
  C[CURUP]='\e[1A'         C[CURHOME]='\r'
  C[CLEARLINE]='\e[2K'
  userinput="${*}"
  [[ -z "${userinput}" ]] && printf "${C[B]}${C[U]}${C[RED]}DID NOT RECEIVE ANY INPUT${C[RESET]}\n" && return 1
  #trap 'return $?' 1 SIGINT SIGQUIT
  for gist in "${userinput[@]}"; do
    printf "${C[DARKGRAY]}"
    # gistname=$(basename "$(gh gist view "${gist}" --files)")
    basename "$(gh gist view "${gist}" --files; ViewCode=$?; echo $ViewCode)"
 
  printf "${C[RESET]}"

    
    if [[ "${gistname}" == "not found" ]]; then
      printf "${C[RED]}FAILED TO CLONE GIST:\t${C[B]}${C[YELLOW}%s${C[RESET]}\n" "${gist}"
      printf "${C[YELLOW]}Downloading gist:\t${C[B]}${C[PURPLE]}%s${C[RESET]}\n" "${gist}"; printf "${C[DARKGRAY]}"
      gh gist clone "${gist}" "${gistname%.*}" \
        && printf "${C[GREEN]}Cloned gist:\t${C[B]}${C[GREEN]}%s${C[RESET]}\n" "${gist}" \
        || printf "${C[RED]}FAILED TO CLONE GIST:\t${C[B]}${C[YELLOW}%s${C[RESET]}\n" "${gist}" \
        || return 1
    fi
  done
  printf "${C[CLEARLINE]}${C[CURHIDE]}${CURUP}${C[CURHOME]}${C[B]}${C[PURPLE]}GoodBye :)${C[RESET]}" && sleep 1; print "${C[CURSHOW]}${C[CLEARLINE]}${C[RESET]}"
  #trap - 1 SIGINT SIGQUIT
  return 0

}

###############################################################################
##
##    > *Cloning this script with this script*
##    ```shell
##      [dampsock@localhost] $ gh-gist-clone-pretty "e9e3a3902474ff4938c95a9c0c3d5bf1"
##        Cloning into 'gh-gist-clone-pretty.sh'...
##        remote: Enumerating objects: 3, done.
##        remote: Counting objects: 100% (3/3), done.
##        remote: Compressing objects: 100% (3/3), done.
##        remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
##        Receiving objects: 100% (3/3), done.
##    ```
##
##    > *Viewing files in cloned directory*
##    ```shell
##
##      [dampsock@localhost] $ ls -lA gh-gist-clone-pretty.sh/
##        drwx------ dampsock dampsock 4.0 KB 2001-09-11 09:48:02 .git
##        .rw------- dampsock dampsock 522 B  2001-09-11 11:26:02 gh-gist-clone-pretty.sh
##        .rw------- dampsock dampsock 694 B  2001-09-11 00:00:01 README.md
##
##    ```
##
###############################################################################
