# smart cd function, allows switching to /etc when running 'cd /etc/fstab'
function cd () {
  local COLOR_CORRECTING COLOR_CORRECTED COLOR_ERROR_MSG COLOR_ERROR COLOR_ERROR_PATH COLOR_RESET
   COLOR_CORRECTING='\e[1;38;5;88m'
   COLOR_CORRECTED='\e[1;38;5;28m'
   COLOR_ERROR_MSG='\e[5;38;5;190m'
   COLOR_ERROR='\e[1;38;5;255;48;5;124m'
   COLOR_ERROR_PATH='\e[3;4;38;5;33m'
   COLOR_RESET='\e[0m'

   if (( ${#argv} == 1 )) && [[ -f ${1} ]]; then
        [[ ! -e ${1:h} ]] && return 1
        print "Correcting ${COLOR_CORRECTING}${1}${COLOR_RESET} to ${COLOR_CORRECTED}${1:h}${COLOR_RESET}"
        builtin cd "${1:h}" \
          || echo "cannot cd" \
          || return 1
    else
      [[ -z "$@" ]] \
        && builtin cd \
        && return 0

      [[ ! -d ${1} ]] \
        && print "${COLOR_ERROR} Error ${COLOR_RESET}${COLOR_ERROR_MSG}${COLOR_ERROR_MSG}  Directory does not exist ${COLOR_RESET}${COLOR_RESET}${COLOR_ERROR_PATH}${1}${COLOR_RESET}" \
        && return 1

      builtin cd "$@" \
          || echo "cannot cd" \
          || return 1
    fi
}

