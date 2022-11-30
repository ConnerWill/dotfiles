#shellcheck disable=1073,1083,1009

# ## Set terminal title
# function title {
#   if [[ $TERM == "screen" ]]; then ## Use these two for GNU Screen:
#     print -nR $' 33k'$1$' 33'\
#     print -nR $' 33]0;'$2$''
#   elif [[ $TERM == "xterm" || $TERM == "rxvt" ]]; then ## Use this one instead for XTerms:
#     print -nR $' 33]0;'$*$''
#   elif [[ $TERM == "xterm-256color" ]]; then ## Use this one instead for XTerms:
#     printf "\x1B]2;${1}\a"
#   fi
# }
#
# function precmd { title zsh "${PWD}" }
# function preexec {
#   emulate -L zsh
#   local -a cmd; cmd=(${1})
#   title ${cmd}
#
#   ## Format title to only show command and now subcommand or options
#   # local -a cmd; cmd=(${(z)1})
#   # title ${cmd[1]:t} "${cmd[2,-1]}"
# }

### REMEMBERING RECENT DIRECTORIES
###     cdr allows you to change the working directory to a previous
###     working directory from a list maintained automatically.=

# export chpwd_recent_dirs="${chpwd_recent_dirs:-${XDG_CACHE_HOME}/zsg/.chpwd-recent-dirs}"
# autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
# add-zsh-hook chpwd chpwd_recent_dirs

### Completion for the argument to cdr is available if compinit
### has been run; menu selection is recommended, using:
# zstyle ':completion:*:*:cdr:*:*' menu selection
#set the value of the recent-dirs-max style to 0
# zstyle ':chpwd:*' recent-dirs-max 0


#       recent-dirs-file
#              The  file  where  the list of directories is saved.  The default is ${ZDOTDIR:-$HOME}/.chpwd-recent-dirs, i.e. this is in your home directory unless you have set the variable ZDOTDIR to point
#              somewhere else.  Directory names are saved in $'...' quoted form, so each line in the file can be supplied directly to the shell as an argument.
#
#              The value of this style may be an array.  In this case, the first file in the list will always be used for saving directories while any other files are left untouched.  When reading  the  re‐
#              cent  directory  list, if there are fewer than the maximum number of entries in the first file, the contents of later files in the array will be appended with duplicates removed from the list
#              shown.  The contents of the two files are not sorted together, i.e. all the entries in the first file are shown first.  The special value + can appear in the list to indicate the default file
#              should be read at that point.  This allows effects like the following:
#
#                     zstyle ':chpwd:*' recent-dirs-file \
#                     ~/.chpwd-recent-dirs-${TTY##*/} +
#
#              Recent directories are read from a file numbered according to the terminal.  If there are insufficient entries the list is supplemented from the default file.
#
#              It is possible to use zstyle -e to make the directory configurable at run time:
#
#                     zstyle -e ':chpwd:*' recent-dirs-file pick-recent-dirs-file
#                     pick-recent-dirs-file() {
#                       if [[ $PWD = ~/text/writing(|/*) ]]; then
#                         reply=(~/.chpwd-recent-dirs-writing)
#                       else
#                         reply=(+)
#                       fi
#                     }
#
#              In this example, if the current directory is ~/text/writing or a directory under it, then use a special file for saving recent directories, else use the default.


#zstyle :zdn:zdn_mywrapper: mapping zdn_mywrapper_top
#autoload -Uz add-zsh-hook zsh_diretory_name_generic zdn_mywrapper
#add-zsh-hook -U zsh_directory_name zdn_mywrapper

#       It is also possible to use global associative arrays, suitably named, and set the style for the context of your wrapper function to refer to this.
#       Then your set up code would contain the following:
#
#              typeset -A zdn_mywrapper_top=(...)
#              # ... and so on for other associative arrays ...
#              zstyle ':zdn:zdn_mywrapper:' mapping zdn_mywrapper_top
#              autoload -Uz add-zsh-hook zsh_directory_name_generic zdn_mywrapper
#              add-zsh-hook -U zsh_directory_name zdn_mywrapper
#
#       and the function zdn_mywrapper would contain only the following:
#
#              zsh_directory_name_generic "$@"
