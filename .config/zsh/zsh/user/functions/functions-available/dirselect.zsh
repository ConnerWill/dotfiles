#shellcheck disable=2148,2300,2031,2086,2031,1012,2030,2162,2059
function dirselect() {
  emulate -L zsh
  local color numcolor promptcolor errorcolor reset_color sleeptime bar
  color='\e[38;5;33m'
  numcolor='\e[38;5;190m'
  promptcolor='\e[38;5;201m'
  errorcolor='\e[38;5;196m'
  reset_color='\e[0m'
  #bar="┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  bar="━"
  sleeptime=0.5
  integer i=0
  # tput smcup
  dirs -p | while read -r dir
  do
    local num="${$(printf "%-4d " ${i})/ /.}"
    printf " ${numcolor}%s${reset_color}  ${color}%s${reset_color}\n" "${num}" "${dir}"
    (( i++ ))
  done
  integer dir=-1
  #printf "${promptcolor}%s${reset_color}\n" "${bar}"

  cols=$(tput cols)
  printf '%.s━' $(seq 1 $((cols - 1)))

  printf "${promptcolor}ddd┃ Jump to directory${reset_color}"
  read -r 'dir?: ' || tput rmcup || return
  (( dir == -1 )) && tput rmcup && return
  if (( dir < 0 || dir >= i ))
  then
    printf "${errorcolor} d: no such directory stack entry:\t%s${reset_color}\n" "${dir}"
    sleep $sleeptime
    tput rmcup
    return 1
  fi
  cd ~${dir}                                                                                    \
    || printf "${errorcolor} d: no such directory stack entry: \t%s\n${reset_color}" "${dir}"   \
    || sleep $sleeptime                                                                         \
    || tput rmcup                                                                               \
    || return 1
}
