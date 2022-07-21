function cdlink(){
  ## Define colors
  local COLOR_CORRECTING='\e[1;38;5;88m' 
  local COLOR_CORRECTED='\e[1;38;5;28m' 
  local COLOR_ERROR_MSG='\e[5;38;5;190m' 
  local COLOR_ERROR='\e[1;38;5;255;48;5;124m' 
  local COLOR_ERROR_PATH='\e[3;4;38;5;33m' 
  local COLOR_RESET='\e[0m' 
  local readedlink
  
  ## Readlink input
  readedlink=$(readlink "${1}")
  
  if (( ${#argv} == 1 )) && [[ -f ${readedlink} ]]; then
    ## Check if input is NOT a file
    [[ ! -e ${readedlink:h} ]] \
      && return 1
    ## Show messege 
    print "Correcting ${COLOR_CORRECTING}${1}${COLOR_RESET} to ${COLOR_CORRECTED}${readedlink:h}${COLOR_RESET}"
    ## Move to directory, Showing error if failed
    builtin cd ${readedlink:h} \
      || print "${COLOR_ERROR} Error ${COLOR_RESET}${COLOR_ERROR_MSG}${COLOR_ERROR_MSG}  Cannot move to ${COLOR_RESET}${COLOR_RESET}${COLOR_ERROR_PATH}${1}${COLOR_RESET}"
  else
    ## Check if input is empty, if empty run 'cd'
    [[ -z "$@" ]] \
        && return 0
    ## Check if input is exists and is not a directory
    [[ ! -d ${1} ]] \
      && print "${COLOR_ERROR} Error ${COLOR_RESET}${COLOR_ERROR_MSG}${COLOR_ERROR_MSG}  Directory does not exist ${COLOR_RESET}${COLOR_RESET}${COLOR_ERROR_PATH}${1}${COLOR_RESET}" \
        && return 1
    ## Move to directory of input, Showing error if failed
    builtin cd "$@" \
      || print "${COLOR_ERROR} Error ${COLOR_RESET}${COLOR_ERROR_MSG}${COLOR_ERROR_MSG}  Cannot move to ${COLOR_RESET}${COLOR_RESET}${COLOR_ERROR_PATH}${1}${COLOR_RESET}"
  fi
}
