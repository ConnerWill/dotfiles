
function highlight () {
  hl_color='\e[1;4;38;5;196m'
  #hl_color='\e[0;1;3;4;38;5;46mMATCH:\e[0m--->\t\e[1;38;5;196m'

  [[ "${commands[perl]}" ]] \
        || printf "\e[1;38;5;190m'perl' \e[38;5;196mis nowhere to be found. Make sure it is installed!\e[0m\n" \
        || return

  local INPUT PATTERN
  PATTERN="${1}" INPUT="${2}"

  if [[ -z "${PATTERN}" ]]; then 
    printf "No search pattern :(\n"
    return 1
  fi

  if [[ -z "${INPUT}" ]]; then 
    perl -pe "s/$PATTERN/${hl_color}$&\e[0m/g"
    exitstatus=$?
  else 
    [[ -f "${INPUT}" ]] && INPUT=$(<"${INPUT}")
    printf "%s\n" "${INPUT}" | perl -pe "s/$1/${hl_color}$&\e[0m/g"
    exitstatus=$?
  fi
  return $?

}
