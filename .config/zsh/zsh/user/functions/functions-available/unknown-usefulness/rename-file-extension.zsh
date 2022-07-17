function rename-file-extension(){
  local searchpath findext replaceext
  searchpath="$1"
  findext="$2"
  replaceext="$3"


  fd_command="$(command -v fd)"
  [[ -z "${fd_command}" ]] \
    && printf "'fd' is not installed or not in your path\nPlease install fd before running again!\n\n\nUsage:\n\n\t$ rename-file-extension <SearchPath> <FindExt> <ReplaceExt>\n" \
    && return 1

  [[ -z "${searchpath}" ]] \
    && printf "Error: Please Include A Search Path! (Use . for the current directory)\n\nUsage:\n\n\t$ rename-file-extension <SearchPath> <FindExt> <ReplaceExt>\n" \
    && printf "\nExample:\n\n\t$ rename-file-extension . .JPEG .jpg\n\n" \
    && printf "\nExample:\n\n\t$ rename-file-extension \"\$(pwd)\" .txt .md\n\n" \
    && return 1
  
  [[ -z "${findext}" ]] \
    && printf "Error: Please Include An Extenstion To Search For!\n\nUsage:\n\n\t$ rename-file-extension %s <FindExt> <ReplaceExt>\n" "${searchpath}" \
    && printf "\nExample:\n\n\t$ rename-file-extension ~/scripts .zsh .sh\n\n" \
    && return 1


  [[ -z "${replaceext}" ]] \
    && printf "Error: Please Include An Extenstion To Replace The Search Extenstion! (You want to replace files with the extenstion '%s'\nSo what do you want the new extenstion to be!?!?!?\n\nUsage:\n\n\t$ rename-file-extension %s %s <ReplaceExt>\n" "${findext}" "${searchpath}" "${findext}" \
    && printf "\nExample:\n\n\t$ rename-file-extension \"\$(pwd)\" .exe .mp4.exe\n\n" \
    && return 1

  fd \
    --type=file \
    --ignore-case \
    --threads=16 \
    --regex "${findext}" \
      --exec rename "${findext}" "${replaceext}" {} \
    ||  printf "\nEPIC_FAIL!\t>:)\n" \
      || return 1 \
    &&  printf "\nSUCCESS!\t:o\n" \
      && return 0

}
