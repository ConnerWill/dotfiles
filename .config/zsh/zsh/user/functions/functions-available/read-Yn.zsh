
read-Yn(){
  printf "%s\t:" "${@}"
  read -k 1 -r -s # "${@}"
  printf "\n"
  [[ $REPLY =~ ^[Yy]$ ]] && return 0 || return 1
}

