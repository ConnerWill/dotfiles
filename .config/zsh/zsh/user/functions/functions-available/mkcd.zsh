#shellcheck disable=2148

function mkcd(){
  [[ -z "${*}" ]] && printf "\e[0;1;38;5;196mNo input received\t\e[0;3;38;5;93m:(\e[0m\n" && return 1
  if mkdir -p "${*}" >/dev/null 2>&1; then
    printf "\e[0;1;38;5;46mCreated directory:\t\e[0;3;38;5;93m%s\e[0m\n" "$_"
    cd "$_" || printf "\e[0;1;38;5;196mCould not move to directory:\t\e[0;3;38;5;93m%s\e[0m\n" "$_" || return 1
  else
    printf "\e[0;1;38;5;196mUnable to create directory\t\e[0;3;38;5;93m%s\e[0m\n" "${@}"; return 1
  fi
}
