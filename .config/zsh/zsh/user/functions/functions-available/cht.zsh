function cht(){
  local i chtoutput
  for i in "${@}"; do
    printf "Searching for %s ...\n" "${i}"
    chtoutput+=$(printf "\n\n\e[0;1;4;38;5;46m%s\e[0m\n\n" "${i}")
    chtoutput+=$(curl --silent "https://cht.sh"/"${i}")
  done
  echo -e "${chtoutput}" | "${PAGER:-${commands[cat]}}"
}
