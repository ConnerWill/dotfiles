function cht(){
  local i chtoutput
  for i in "${@}"; do
    printf "Searching for %s ...\n" "${i}"
    chtoutput+=$(printf "\n\n\e[0;1;4;38;5;46m%s\e[0m\n\n" "${i}")
    chtoutput+=$(curl --silent "https://cht.sh"/"${i}")
    # curl --silent "https://cht.sh"/"${i}" | bat --plain --language=Manpage
  done
  echo -e "${chtoutput}" | bat --plain --language=Manpage
}
