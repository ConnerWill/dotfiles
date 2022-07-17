function cht(){
  echo "Searching for cheatsheets ..."
  curl --silent "https://cht.sh"/"$1" | bat --plain --language=Manpage
}
