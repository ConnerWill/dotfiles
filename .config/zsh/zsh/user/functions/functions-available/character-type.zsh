# shellcheck disable=2190,2034,2148,2206
character-type(){
  typeset -A assoc
  typeset -a inputarray
  assoc=('[0-9]' digit '[a-zA-Z]' letter '[^0-9a-zA-Z]' neither)
  inputarray=( ${(ie)*} )

  echo "Input Array ${inputarray[(ie)]}\nArray length: ${#inputarray}\n"

  if (( ${#inputarray} > 0 )); then
    for inputchar in "${inputarray[@]}";
    do
      echo "${inputchar}"
      case ${inputchar} in
        ([0-9]) print digit
        ;;
        ([a-zA-Z]) print letter
        ;;
        ([^0-9a-zA-Z]) print neither
        ;;
        #((^$)) print null
        #;;
      esac
    done
    else
    print null
  fi
}
