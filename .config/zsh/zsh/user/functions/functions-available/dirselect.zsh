#shellcheck disable=2148,2300,2031,2086,2031,1012,2030,2162
function dirselect() {
  emulate -L zsh
  local color='\e[38;5;33m'
  local numcolor='\e[38;5;190m'
  local promptcolor='\e[38;5;201m'
  local errorcolor='\e[38;5;196m'
  local reset_color='\e[0m'
  integer i=0
  tput smcup
  dirs -p | while read -r dir
  do
      local num="${$(printf "%-4d " $i)/ /.}"
      printf " $numcolor%s$reset_color  $color%s$reset_color\n" $num $dir
      (( i++ ))
  done
  integer dir=-1
  printf "$promptcolor━━━━━━━━━━━━━━━━━━━━━$reset_color\n"
  printf "$promptcolor Jump to directory $reset_color"
  read -r 'dir?: ' || tput rmcup || return
  (( dir == -1 )) && tput rmcup && return
  if (( dir < 0 || dir >= i ))
  then
      printf "$errorcolor d: no such directory stack entry:\t%s$reset_color\n" $dir
      sleep 1
      tput rmcup
      return 1
  fi
  cd ~$dir                                            \
    || printf "$errorcolor d: no such directory stack entry:\t%s\n$reset_color" $dir \
    || sleep 1 \
    || tput rmcup \
    || return 1
}
