function rm_git(){
  local color_red color_yellow color_green color_purple color_cyan
  color_red='\e[0;38;5;196m'
  color_yellow='\e[0;38;5;190m'
  color_green='\e[0;38;5;46m'
  color_purple='\e[0;38;5;93m'
  color_cyan='\e[0;1;38;5;87m'

  if [[ "$(pwd)" == "${HOME}" ]] || [[ "$(pwd)" == "/" ]]; then
    printf "\n${color_red}Cannot run this command is %s or /\n\n" "${HOME}"
    return 1
  fi
  foundfiles="$(find -writable -user $(whoami) \
    -name '.git' -or -name '.gitignore' \
    -or -name '.gitkeep' -or -name '.gitattributes' \
    -or -name 'LICENSE' -or -name '.gitmodules' -or -name '.github' -not -name '.gitconfig')"

  foundfilesnum="$(echo "${foundfiles}" | wc -l)"

  printf "\n${color_red}This will remove all ${color_purple}%s ${color_green}'.git*' ${color_red}files and directories below ${color_purple}'%s'\n" "$foundfilesnum" "$(pwd)"
  printf "${color_yellow}Press ${color_green}Y${color_yellow} to confirm\e[0m\n"
  printf "${color_yellow}Press ${color_red}n${color_yellow} to cancel\e[0m\n"
  printf "${color_yellow}Press ${color_cyan}i${color_yellow} to list found files\e[0m: "
  read -r -k 1 -s answer; printf "\n"

  if [[ "${answer}" == "Y" ]]; then
  printf "\n${color_yellow}Press ${color_green}<Y>${color_yellow} to confirm\e[0m "
  read -r -k 1 -s answer; printf "\n"
    if [[ "${answer}" == "Y" ]]; then
      echo "${foundfiles}" | xargs -I{} rm --recursive --verbose {} | less
    else
      return 0
    fi
  elif [[ "${answer}" == "y" ]]; then
    clear
    printf "\n\n${color_purple}Please press 'Y' for yes.\n\n"
    sleep 2
    rm_git
  elif [[ "${answer}" == "i" ]] || [[ "${answer}" == "I" ]]; then
    echo "${foundfiles}" | less && clear ; rm_git
  else
    return 0
  fi

}; alias rm-git="rm_git"




  # fd                      \
  #   --regex '\.git'       \
  #   --exclude='*config*'  \
  #   --exclude='*hook*'    \
  #   --type directory      \
  #   --hidden              \
  #   --exec rm '{}' --recursive --verbo
