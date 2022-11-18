
function highlight () {
  [[ "${commands[perl]}" ]] \
        || printf "'perl' is nowhere to be found. Make sure it is installed!\n" \
        || return 1

  local INPUT PATTERN
  PATTERN="${1}" INPUT="${2}"

  if [[ -z "${PATTERN}" ]]; then 
    printf "No search pattern :(\n"
    return 1
  fi

  if [[ -z "${INPUT}" ]]; then 
    perl -pe "s/$PATTERN/\e[1;38;5;196m$&\e[0m/g"
  else 
    [[ -f "${INPUT}" ]] && INPUT=$(<"${INPUT}")
    printf "%s" "${INPUT}" | perl -pe "s/$1/\e[1;38;5;196m$&\e[0m/g"
  fi
}
