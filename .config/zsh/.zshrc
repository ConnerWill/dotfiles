# vim:filetype=zsh:shiftwidth=2:softtabstop=2:expandtab:foldmethod=marker:foldmarker=###{{{,###}}}

###{{{ DOCUMENTATION
#############################################################
#############################################################
##                                                         ##
##    ┍────────────────────────────────────────────────┐   ##
##    │         ███▀▀▀███▄█▀▀▀█▄█████▀  ▀████▀▀        │   ##
##    │          █▀   ███▄██    ▀█ ██      ██          │   ##
##    │          ▀   ███ ▀███▄     ██      ██          │   ##
##    │             ███    ▀█████▄ ██████████          │   ##
##    │            ███   ▄     ▀██ ██      ██          │   ##
##    │           ███   ▄██     ██ ██      ██          │   ##
##    │         █████████▀█████▀▄████▄  ▄████▄▄        │   ##
##    ├────────────────────────────────────────────────┤   ##
##    │            ＺＳＨ ＣＯＮＦＩＧ                 │   ##
##    │ Ｍｙ Ｚ－Ｓｈｅｌｌ Ｃｏｎｆｉｇｕｒａｔｉｏｎ │   ##
##    └────────────────────────────────────────────────┘   ##
##__     ___                                    ____     __##
####|___|###\                                  /####|___|####
#############\__________/ZSH CONFIG\__________/##############
#############################################################

########################
#### DOCUMENTATION  ####
#############################################################
###
##:
##:
#############################################################

#############################################################
##;:::::::::::::::::::;---ZSHRC---;:::::::::::::::::::::::;##
##,_______________________________________________________,##
##|ENVIRONMENT VARIABLES|. . . . . Description . . . . . . ##
##'====================='----------------------------------##
##                                                         ##
##  ${ZDOTDIR}::::::::::: Directory containing zsh files   ##
##                          ( ~/.config/zsh )              ##
##                                                         ##
##  ${ZSHRC}::::::::::::: Path to the '.zshrc' file        ##
##                          ( ${$ZDOTDIR:-$HOME}/.zshrc )  ##
##                                                         ##
##  ${ZSH_USER_DIR_NAME}: Name of zsh config profile to use##
##                          ( user )                       ##
##                                                         ##
##  ${ZSH_USER_DIR}:::::: Path to current config profile   ##
##             ( ${$ZDOTDIR:-$HOME/.config/zsh}/zsh/user ) ##
##                                                         ##
##  ${ZSHDDIR}::::::::::: Directory containing configs that##
##                        will be sourced in numeric order ##
##                          ( $ZSH_USER_DIR/zsh.d )        ##
##                                                         ##
##_________________________________________________________##
#############################################################

# \e[?25l ## Hide Cursor
# \e[?25h ## Restore Cursor
# \e[2K   ## Clear line
# \e[1A   ## Move curser up 1 line
# \e[5A   ## Move curser up 5 lines
# \r      ## Move cursor to beginning of line
# \e[22;0t             ## Save title of terminal
# \e]0;TITLE TEXT\e\\  ## Set title of terminal
# \e[23;0t' # Restore title of terminal







###}}}

### ::::::::::::::::::::::: DEBUGGING :::::::::::::::::::::: ###{{{
########################
####   DEBUGGING    ####
############################################################
###: To run a diagnostics dump, run command:# For boolean options:
##:      zsh_diagnostic_dump
##:
##:  If you're getting weird behavior and can't find the culprit,
##:  run the following command to enable debug mode:
##:
##:      zsh -xv 2> >(tee ./omz-debug.log &>/dev/null)
##:
##:  Afterwards, reproduce the behavior (i.e. if it's a particular command, run it),
##:  and when you're done, run exit to stop the debugging session.
##:  This will create a omz-debug.log file on your home directory,
##:  with a trace of every command executed and its output.
##:  You can then upload this file when creating an issue.
##:
##:  If you only need to debug the session initialization, you can do so with the command:
##:
##:      zsh -xvic exit &> ./omz-debug.log
##:
##:  To list all keybindings, run this command
##:      bindkey -l | xargs -I{} zsh --onecmd -c "printf '\e[0;1;38;5;46m======================\e[0m\n\t{}\t\t\n\e[0;1;38;5;46m======================\e[0m\n' && bindkey -R -M '{}'" | less --RAW-CONTROL-CHARS
##:
##:  Or:
##:
##:      bindkey -l | xargs -I{} zsh --onecmd -c "printf '======================\n\t{}\t\t\n======================\n' && bindkey -R -M '{}'" | bat -l zsh
##:
###########################################################
[ -n "$INHERIT_ENV" ] && return 0

#_ZSH_LOAD_VERBOSE_VERBOSE="True"
#: VERY Verbose loading zshrc
if [[ -n "${_ZSH_LOAD_VERBOSE_VERBOSE}" ]]; then
  setopt xtrace
fi
# #  Profiling
# #ZSH_PROFILE_RC=1
# if [[ -n "$ZSH_PROFILE_RC" ]]; then
#   which zmodload >&/dev/null && zmodload zsh/zprof
#   PS4=$'\\\011%D{%s%6.}\011%x\011%I\011%N\011%e\011'
#   exec 3>&2 2>${ZSH_DEBUG_LOG_DIR:-/tmp}/zshstart.$$.log
#   setopt xtrace prompt_subst
# fi

### ::::::::::::::::::: END DEBUGGING :::::::::::::::::::::: ###}}}

### :::::::::::::: ZSHRC EXPORT VARIABLES ::::::::::::::::: ###{{{
export LC_ALL="en_US.UTF-8"
unset                 \
  _ZSH_LOAD_VERBOSE   \
  _ZSH_SHOW_ERRORS    \
  _ZSH_BANNER_SHOW    \
  _ZSH_BANNER_START
export                \
  _ZSH_LOAD_VERBOSE   \
  _ZSH_SHOW_ERRORS    \
  _ZSH_BANNER_SHOW    \
  _ZSH_BANNER_START   \
  ZSH_USER_DIR_NAME   \
  ZSH_USER_DIR        \
  ZSH_USER_LOAD_DIR   \
  LC_ALL
### :::::::::::::: END ZSHRC EXPORT VARIABLES ::::::::::::: ###}}}

### :::::::::::::: ZSHRC USER CONFIG :::::::::::::::::::::: ###{{{
########################
#┌─ Config options ####
#├─┐ For boolean options:
#│ ├─── To enable options, set the value to anything (e.g. TRUE).
#│ └─── To disable options, comment out the option or leave it unset.
#└─┐ For string options:
#  ├──── See the description next to the value to find what values cam be used,
#  └──── To disable options, comment out the option or leave it unset.
##########################################################################
### :::::::::::::: BEGIN ZSHRC USER CONFIG :::::::::::::::: ###



[[ -z "${ZSH_USER_DIR_NAME}" ]] \
  && ZSH_USER_DIR_NAME="user"        #┌ Name of the User-Folder for the 'profile' to use.
                                     #└─ This makes it easy to work on multiple zsh configs on the same machine/user

ZSH_USER_DIR="${ZDOTDIR:-$HOME/.config/zsh}"/zsh/"${ZSH_USER_DIR_NAME}" #: Define the path of sub-profiles

ZSH_USER_LOAD_DIR="${ZSH_USER_DIR}/zsh.d" #┌ Define the name of the folder that will be looped
                                          #├─ through looking for file with and extension of '.zsh'.
                                          #├─ All files with an extension of '.zsh' will
                                          #└─ be sourced durring startup.

# _ZSH_LOAD_VERBOSE="TRUE"             #: Show what is being loaded verbosely

_ZSH_SHOW_ERRORS="TRUE"              #: Show error messeges. This is unrelated to '_ZSH_LOAD_VERBOSE'

ZSH_DEBUG_LOG_DIR="${ZDOTDIR}/logs"  #: Directory that ZSH logs will be written to.

_ZSH_DEBUGGING_ENABLED="TRUE"        #┌ If this option is set, a debug log will
                                     #└─ be written to '$ZSH_DEBUG_LOG_DIR'

# _ZSH_BANNER_SHOW="TRUE"              #: Show banner art

# _ZSH_BANNER_START="TRUE"             #┌ Show banner art before loading other files.
                                     #├─ If this option is enabled (default), banner art will
                                     #├─  be shown before other files are loaded.
                                     #├─ If this option is disabled, banner art will
                                     #├─  be shown after all files are loaded.
                                     #└┐
                                     # ├──── NOTE: Banner art will only be shown if
                                     # └─────────── also '_ZSH_BANNER_SHOW' is enabled.



### :::::::::::::: END ZSHRC USER CONFIG :::::::::::::::::: ###}}}

### :::::::::::::: ZSHRC VERBOSE MESSEGES ::::::::::::::::: ###{{{
### VERBOSE / ERROR Displaying
function _zshrc_VERBOSE_MESSEGE(){
  if [[ -n "${_ZSH_LOAD_VERBOSE}" ]]; then
    local zsh_verbose_messege_verb zsh_verbose_messege
    zsh_verbose_messege_verb="$1"
    zsh_verbose_messege="$2"
    zsh_verbose_messege_type_color="$3"
    zsh_verbose_messege_color="$4"
    [[ -z "$zsh_verbose_messege_verb" ]] \
      && zsh_verbose_messege_verb=""
    printf "\e[0;1;38;5;190;48;5;21m VERBOSE \e[0m \e[0;38;5;%sm%s \e[0;38;5;%sm%s\e[0m\n" "$zsh_verbose_messege_type_color" "$zsh_verbose_messege_verb" "$zsh_verbose_messege_color" "$zsh_verbose_messege"
    return 0
  else
    return 0
  fi
}
function _zshrc_VERBOSE_ERROR(){
  if [[ -n "${_ZSH_SHOW_ERRORS}" ]]; then
    local zsh_verbose_error_verb zsh_verbose_error
    zsh_verbose_error_verb="$1"
    zsh_verbose_error="$2"
    zsh_verbose_error_type_color="$3"
    zsh_verbose_error_color="$4"
    [[ -z "$zsh_verbose_error_verb" ]] \
      && zsh_verbose_error_verb=""
    printf "\e[0;1;38;5;255;48;5;9m  ERROR  \e[0m \e[0;38;5;%sm%s \e[0;38;5;%sm%s\e[0m\n" "$zsh_verbose_error_type_color" "$zsh_verbose_error_verb" "$zsh_verbose_error_color" "$zsh_verbose_error"
    return 1
  else
    return 1
  fi
}
function _zshloadverbose(){
    [[ -z "$zsh_load_verbose_clear" ]] || clear
    [[ -z "$zsh_load_section" ]] || printf "Loading %s ..." "$zsh_load_section"
    [[ -z "$zsh_load_sleep" ]] || sleep "$zsh_load_sleep"
    unset zsh_load_section
    unset zsh_load_section_error
}
### :::::::::::::: END ZSHRC VERBOSE MESSEGING :::::::::::: ###}}}

### :::::::::::::: OS TYPE ::::::::::::::::::::::::: ###{{{
# ZSHLIB="${ZDOTDIR}/lib"
# if [[ -d "${ZSHLIB}" ]]; then
#   if [[ -f "${ZSHLIB}/ostype" ]]; then
#     source "${ZSHLIB}/ostype"
#     islinux && OSTYPE="linux"
#     isandroid && OSTYPE="linux"
#     ismacos &&
if [[ "${OSTYPE}" == "linux-gnu" ]]; then
  if [[ -f /etc/os-release ]]; then
    DISTRO=$(cat /etc/os-release | grep --extended-regexp --regexp='^NAME=' | cut -d'=' -f2 | cut -d' ' -f1 | cut -d'"' -f2)
    export DISTRO
  fi
elif [[ "${OSTYPE}" == "linux-android" ]]; then
  DISTRO="Android"
  export DISTRO
else
  unset DISTRO
fi
### ::::::::::::::::: END OS TYPE ::::::::::::::::::::::: ###}}}

### :::::::::::::: TMUX :::::::::::::::::::::::: ###{{{
## Set NOTMUX to any value to disable automatic tmux
NOTMUX=1
# shellcheck disable=2148
function _zshinittmux(){
 [[ -n "${NOTMUX}" ]] && return 0
  # Check if tmux is installed, return if not
  command -v tmux >/dev/null 2>&1 || return 0
  if [[ -z $TMUX && -n $SSH_TTY ]]; then
    if tmux has-session >/dev/null 2>&1; then
       exec tmux -2 attach-session
    else
       exec tmux -2 new-session
    fi
  fi
}
# _zshinittmux
unfunction _zshinittmux
### :::::::::::::: END TMUX ::::::::::::::::: ###}}}

### :::::::::::::: LOADING BAR ::::::::::::::::::::: ###{{{
function _loading_bar(){
  printf "\e[0;38;5;201mLOADING \e[0;38;5;46mZSH\e[0;38;5;201m ...\e[0m\t"
  local bar_color sleep_time
  bar_color='\e[0;48;5;46m'
  sleep_time=0.04
  for ((k = 0; k <= 10 ; k++)); do
    printf "" ## Start character
    for ((i = 0 ; i <= k; i++)); do
      printf "${bar_color}   \e[0m"
    done
    for ((j = i ; j <= 10 ; j++)); do
      printf "   "
    done
    v=$((k * 10))
    printf " " ## End character
    echo -n "$v %" $'\r'
    sleep $sleep_time
  done
}
### :::::::::::::::::: END LOADING BAR ::::::::::::::::::: ###}}}

### :::::::::::::: ZSHRC CLEAR SCREEN FUNCTIONS ::::::::::: ###{{{
function _zshloadstartclear(){ [[ -z "$zsh_load_start_clear" ]] || clear; }
function _zshloadendclear(){ [[ -z "$zsh_load_end_clear" ]] || clear; }
### :::::::::::::: END ZSHRC CLEAR SCREEN FUNCTIONS ::::::: ###}}}

### :::::::::::::: ZSHRC PRE-RUN CLEAR SCREEN ::::::::::::: ###{{{
_zshloadstartclear
#: Clear Screen Before Loading
### :::::::::::::: END ZSHRC PRE-RUN CLEAR SCREEN ::::::::: ###}}}

### :::::::::::::: ZSHRC SOURCE ZSHDDIR ::::::::::::::::::: ###{{{
#Something I've found to be successful is to have a $ZDOTDIR/zsh.d folder and drop
#plugins from other plugin managers (e.g. oh-my-zsh, prezto) there.
#You can then easily source the files in your .zshrc file with something like

# shellcheck disable=SC1009
if [[ -d "${ZSH_USER_LOAD_DIR}" ]]; then
  # shellcheck disable=SC1072,SC1058,SC1036,SC1073
  for ZSH_FILE in "${ZSH_USER_LOAD_DIR}"/*.zsh(N); do
    _zshrc_VERBOSE_MESSEGE "Source  " "$(basename ${ZSH_USER_LOAD_DIR})/$(basename ${ZSH_FILE})" "87" "226"
    source "${ZSH_FILE}" \
      || _zshrc_VERBOSE_ERROR "Sourcing Failed" "${ZSH_FILE}" "196" "190"
  done
else
  _zshrc_VERBOSE_ERROR "Directory does not exist" "${ZSH_USER_LOAD_DIR}" "196" "124"
fi
### :::::::::::::: END ZSHRC SOURCE ZSHDDIR ::::::::::::::: ###}}}

### :::::::::::::: ZSHRC PRE-RUN CLEAR SCREEN ::::::::::::: ###{{{
_zshloadendclear
#: Clear Screen After Loading
### :::::::::::::: END ZSHRC POST-RUN CLEAR SCREEN :::::::: ###}}}

### ::::::::::::::::::: DEBUGGING STOP :::::::::::::::::::: ###{{{

if [[ -n "$ZSH_PROFILE_RC" ]]; then
  unsetopt xtrace
  exec 2>&3 3>&-
  #zprof # >! ~/zshrc.zprof
  #exit
fi

### ::::::::::::::::::: END DEBUGGING STOP :::::::::::::::: ###}}}

### :::::::::::::: ZSHRC EXIT TRAPS ::::::::::::: ###{{{
 # TRAPEXIT() {
    # commands to run here, e.g. if you
    # always want to run .zlogout: if [[ ! -o login ]]; then
      # don't do this in a login shell because it happens anyway
      #source "${ZDOTDIR}/.zlogout"
    #fi
  #}
### ::::::::::: END ZSHRC EXIT TRAPS ::::::::::::: ###}}}
