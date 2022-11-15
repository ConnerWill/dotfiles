function rmcwd(){
  local color_reset color_error color_warning color_success RMDIR RMDIR_parent
  local color_red color_yellow color_green color_purple color_cyan INPUT
  color_red='\e[0;38;5;196m'
  color_yellow='\e[0;38;5;190m'
  color_green='\e[0;38;5;46m'
  color_purple='\e[0;38;5;93m'
  color_cyan='\e[0;1;3;38;5;87m'
  color_error='\e[0;1;48;5;196;38;5;15m'   color_reset='\e[0m'
  color_warning='\e[0;1;38;5;190m' color_success='\e[0;1;38;5;46m'
  color_question='\e[0;3;38;5;93m' color_dir='\e[0;1;3;4;38;5;201m'
  RMDIR="${PWD}"
  INPUT="${*}"
  [[ "${INPUT}" == "${PWD}" ]] && printf "\n\t\n${color_cyan}▁▂▃▄▅▆▇ █ ▊ ▋ ▌ ▍ ▎ ▏ ▐${color_reset}${color_purple}SWAG${color_reset}${color_cyan}▐ ▏ ▎ ▍ ▌ ▋ ▊ █ ▇▆▅▄▃▂▁"
  RMDIR_parent="${RMDIR:h}"
  [[   "${RMDIR}" == "/"     \
    || "${RMDIR}" == "/etc"  \
    || "${RMDIR}" == "/usr"  \
    || "${RMDIR}" == "/bin"  \
    || "${RMDIR}" == "/sbin" \
    || "${RMDIR}" == "/var"  \
    || "${RMDIR}" == "/sys"  \
    || "${RMDIR}" == "/dev"  \
    || "${RMDIR}" == "/boot" \
    || "${RMDIR}" == "/mnt"  \
    || "${RMDIR}" == "/run"  \
    || "${RMDIR}" == "/proc" \
    || "${RMDIR}" == "${HOME}" \
    || "${RMDIR}" == "${XDG_CONFIG_HOME:-${HOME}/.config}" \
    || "${RMDIR}" == "${XDG_DATA_HOME:-${HOME}/.local}"    \
    || "${RMDIR_parent}" == "${HOME}"                      \
    ]] && printf "${color_warning}Refusing to remove directory:\t${color_dir}%s${color_reset}\n\n\t(${color_cyan}Too close to %s${color_reset})\n\n" "${RMDIR}" "${HOME}" && return 1
  printf "\n${color_red}This will remove ${color_red}all files and directories below ${color_purple}'%s'" "${RMDIR}"
  printf "\n${color_yellow}Press ${color_green}Y${color_yellow} to confirm\e[0m"
  printf "\n${color_yellow}Press ${color_red}n${color_yellow} to cancel\e[0m"
  printf "\n${color_yellow}Press ${color_cyan}i${color_yellow} to list found files\e[0m: "
  read -r -k 1 -s answer; printf "\n"

  if [[ "${answer}" == "Y" ]]; then
  printf "\n${color_yellow}Press ${color_green}<Y>${color_yellow} to confirm\e[0m "
  read -r -k 1 -s answer; printf "\n"
    if [[ "${answer}" == "Y" ]]; then
      echo "${foundfiles}" | xargs -I{} rm --recursive --verbose {} #| less
      cd "${RMDIR_parent}" \
        || printf "${color_error}Cannot move out of \t${color_dir}%s${color_reset} \n" "${RMDIR}" || return 1 \
        && printf "${color_question}Removing all directory and all of its contents?:\t${color_dir}%s${color_reset}\n" "${RMDIR}"
    else
      return 0
    fi
  elif [[ "${answer}" == "y" ]]; then
    clear
    printf "\n\n${color_purple}Please press 'Y' for yes.\n\n"
    sleep 2
    rmcwd "${*}"
  elif [[ "${answer}" == "i" ]] || [[ "${answer}" == "I" ]]; then
    echo "${foundfiles}" | less && clear ; rm_git
  else
    return 0
  fi
  if rm --recursive --force --verbose "${RMDIR}"; then
    printf "${color_success}Removed directory:${color_reset}\t${color_dir}%s${color_reset}\n" "${RMDIR}"
    return 0
  else
    printf "${color_error}Cannot remove directory:${color_reset}\t${color_dir}%s${color_reset}\n" "${RMDIR}"
    cd "${RMDIR}" \
      && printf "${color_success}Moved back to original directory${color_reset}\n" \
      || printf "${color_error}Cannot cd back to directory:${color_reset}\t${color_dir}%s${color_reset}\n" "${RMDIR}"
    return 1
  fi

}
