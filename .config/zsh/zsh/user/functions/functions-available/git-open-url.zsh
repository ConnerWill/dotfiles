#shellcheck disable=2148,2059,2154
function git-open-url(){
  local color_error color_warning color_cyan color_green color_reset
  color_reset='\e[0m'
  color_warning='\e[0;3;38;5;226m' color_error='\e[0;1;4;38;5;196m'
  color_cyan='\e[0;1;38;5;51m' color_green='\e[0;1;38;5;46m'
  if "${commands[git]}" status >/dev/null 2>&1; then
    print "\e[2K\r\e[2K\e[1A"
    xdg-open "$(${commands[git]} config remote.origin.url 2>/dev/null)" 2>/dev/null \
      || printf "${color_error}Failed to open URL of repository${color_reset}\t${color_cyan}:(${color_reset}" \
      || return 1
    [[ ${functions[zshlib_printline]} ]] && zshlib_printline 4 "${color_cyan}" && printf "\n${color_green}Opening URL ${color_warning}:)${color_reset}\n" && zshlib_printline 4 "${color_cyan}"
  else
    printf "${color_warning}Are you sure you are in a git repository${color_cyan}???${color_reset}"
    sleep 1.5; print "\e[2K\r\e[2K\e[1A"; return 1
  fi
  return 0
}
