function rmcwd(){
  local color_reset color_error color_warning color_success RMDIR RMDIR_parent
  color_error='\e[0;1;48;5;196;38;5;15m'   color_reset='\e[0m'
  color_warning='\e[0;1;38;5;190m' color_success='\e[0;1;38;5;46m'
  color_question='\e[0;3;38;5;93m' color_dir='\e[0;1;3;4;38;5;201m'
  RMDIR="${PWD}"
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
  ]] && printf "${color_warning}Refusing remove directory:\t${color_dir}%s${color_reset}\n" "${RMDIR}" && return 1
  cd "${RMDIR_parent}" \
    || printf "${color_error}Cannot move out of \t${color_dir}%s${color_reset} \n" "${RMDIR}" || return 1 \
    && printf "${color_question}Do you want to remove this directory and all of its contents?:\t${color_dir}%s${color_reset}\n" "${RMDIR}"
  if rm --recursive --force --verbose --interactive=once "${RMDIR}"; then
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
