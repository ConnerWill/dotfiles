
funtion login-motd(){
  figletfont="ANSI Shadow"
  #printf "[1;34m"
  printf "\e[0;38;5;13m"
  figlet -f "$figletfont" $(hostname --short)
  printf "\e[0m"
  #printf "[0m"
  [[ -f /etc/os-release ]] && source /etc/os-release || PRETTY_NAME="Linux"
  printf "\e[0;38;5;87m%s \e[0;38;5;46m%s\t\e[0;38;5;27m%s\e[0m\n"  "$PRETTY_NAME" "$(uname -r)" "$(date)"
  printf "\e[0;38;5;93m"
  load=$(cat /proc/loadavg     | awk '{print $2}')
  memory_usage=$(free -m       | awk '/Mem/ { printf("%3.1f%%", $3/($2+1)*100) }')
  memory_total=$(free -g       | awk '/Mem/ { printf("%3.0f", $2) }')
  swap_usage=$(free -m         | awk '/Swap/ { printf("%3.1f%%", $3/($2+1)*100) }')
  swap_total=$(free -g         | awk '/Swap/ { printf("%3.0f", $2) }')
  users=$(users                | wc -w)
  printf "\e[0m"
  printf "\e[0;38;5;93mSystem load:\t\e[0;38;5;190m%s\t\t\e[0;38;5;93mMemory usage:\t\e[0;38;5;204m%s \e[0;38;5;93mof \e[0;38;5;196m%sG\n" $load $memory_usage $memory_total
  printf "\e[0;38;5;93mLocal users:\t\e[0;38;5;201m%s\t\t\e[0;38;5;93mSwap usage:\t\e[0;38;5;8m%s \e[0;38;5;93mof \e[0;38;5;7m%sG\n\n"  $users $swap_usage $swap_total

  if $(command -v dfrs >/dev/null 2>&1); then
   dfrs
  elif $(command -v dfc >/dev/null 2>&1); then
   dfc
  else
   timeout --signal=kill 2s df -h | grep -E "^(/dev/|Filesystem)"
  fi
  printf "\n"

}
#login-motd
