       #
       # -a file
       #        true if file exists.
       #
       # -b file
       #        true if file exists and is a block special file.
       #
       # -c file
       #        true if file exists and is a character special file.
       #
       # -d file
       #        true if file exists and is a directory.
       #
       # -e file
       #        true if file exists.
       #
       # -f file
       #        true if file exists and is a regular file.
       #
       # -g file
       #        true if file exists and has its setgid bit set.
       #
       # -h file
       #        true if file exists and is a symbolic link.
       #
       # -k file
       #        true if file exists and has its sticky bit set.
       #
       # -n string
       #        true if length of string is non-zero.
       #
       # -o option
       #        true if option named option is on.  option may be a single char‐
       #        acter,  in  which  case it is a single letter option name.  (See
       #        the section `Specifying Options'.)
       #
       #        When no option named option exists, and the  POSIX_BUILTINS  op‐
       #        tion  hasn't  been set, return 3 with a warning.  If that option
       #        is set, return 1 with no warning.
       #
       # -p file
       #        true if file exists and is a FIFO special file (named pipe).
       #
       # -r file
       #        true if file exists and is readable by current process.
       #
       # -s file
       #        true if file exists and has size greater than zero.
       #
       # -t fd  true if file descriptor number fd is open and associated with  a
       #        terminal device.  (note: fd is not optional)
       #
       # -u file
       #        true if file exists and has its setuid bit set.
       #
       # -v varname
       #        true if shell variable varname is set.
       #
       # -w file
       #        true if file exists and is writable by current process.
       #
       # -x file
       #        true  if  file  exists and is executable by current process.  If
       #        file exists and is a directory, then  the  current  process  has
       #        permission to search in the directory.
       #
       # -z string
       #        true if length of string is zero.
       #
       # -L file
       #        true if file exists and is a symbolic link.
       #
       # -O file
       #        true  if  file  exists  and is owned by the effective user ID of
       #        this process.
       #
       # -G file
       #        true if file exists and its group matches the effective group ID
       #        of this process.
       #
       # -S file
       #        true if file exists and is a socket.
       #
       # -N file
       #        true  if  file  exists and its access time is not newer than its
       #        modification time.
       #


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

#
# function cdlink(){
#   ## Define colors
#   local COLOR_CORRECTING='\e[1;38;5;88m' 
#   local COLOR_CORRECTED='\e[1;38;5;28m' 
#   local COLOR_ERROR_MSG='\e[5;38;5;190m' 
#   local COLOR_ERROR='\e[1;38;5;255;48;5;124m' 
#   local COLOR_ERROR_PATH='\e[3;4;38;5;33m' 
#   local COLOR_RESET='\e[0m' 
#   
#   if (( ${#argv} == 1 )) && [[ -f ${1} ]]; then
#     ## Check if input is NOT a file
#     [[ ! -e ${1:h} ]] \
#       && return 1
#     ## Show messege 
#     print "Correcting ${COLOR_CORRECTING}${1}${COLOR_RESET} to ${COLOR_CORRECTED}${1:h}${COLOR_RESET}"
#     ## Move to directory, Showing error if failed
#     builtin cd ${1:h} \
#       || print "${COLOR_ERROR} Error ${COLOR_RESET}${COLOR_ERROR_MSG}${COLOR_ERROR_MSG}  Cannot move to ${COLOR_RESET}${COLOR_RESET}${COLOR_ERROR_PATH}${1}${COLOR_RESET}"
#
#   else
#     ## Check if input is empty, if empty run 'cd'
#     [[ -z "$@" ]] \
#       && builtin cd \
#         && return 0
#     ## Check if input is exists and is not a directory
#     [[ ! -d ${1} ]] \
#       && print "${COLOR_ERROR} Error ${COLOR_RESET}${COLOR_ERROR_MSG}${COLOR_ERROR_MSG}  Directory does not exist ${COLOR_RESET}${COLOR_RESET}${COLOR_ERROR_PATH}${1}${COLOR_RESET}" \
#         && return 1
#     ## Move to directory of input, Showing error if failed
#     builtin cd "$@" \
#       || print "${COLOR_ERROR} Error ${COLOR_RESET}${COLOR_ERROR_MSG}${COLOR_ERROR_MSG}  Cannot move to ${COLOR_RESET}${COLOR_RESET}${COLOR_ERROR_PATH}${1}${COLOR_RESET}"
#   fi
# }
