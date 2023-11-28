#vim:filetype=zsh:shiftwidth=2:softtabstop=2:expandtab:foldmethod=marker:foldmarker=###{{{,###}}}
# ╔══════════════════════════════════════════════════════════════════════════╗
# ║            ┌────────────────────────────────────────────────┐            ║
# ║            │         ███▀▀▀███▄█▀▀▀█▄█████▀  ▀████▀▀        │            ║
# ║            │          █▀   ███▄██    ▀█ ██      ██          │            ║
# ║            │          ▀   ███ ▀███▄     ██      ██          │            ║
# ║            │             ███    ▀█████▄ ██████████          │            ║
# ║            │            ███   ▄     ▀██ ██      ██          │            ║
# ║            │           ███   ▄██     ██ ██      ██          │            ║
# ║            │         █████████▀█████▀▄████▄  ▄████▄▄        │            ║
# ║            ├────────────────────────────────────────────────┤            ║
# ║            │            ＺＳＨ ＣＯＮＦＩＧ                 │            ║
# ║            │ Ｍｙ Ｚ－Ｓｈｅｌｌ Ｃｏｎｆｉｇｕｒａｔｉｏｎ │            ║
# ║            └────────────────────────────────────────────────┘            ║
# ╚══════════════════════════════════════════════════════════════════════════╝
# ┌──────────────────────────────────────────────────────────────────────────┐
# │ Documentation:                                                           │
# ├──────────────────────────────────────────────────────────────────────────┤
# │ - bool values should be commented out (undefined), not set to false or 0 │
# │ -                                                                        │
# │ -                                                                        │
# │ -                                                                        │
# │ -                                                                        │
# │                                                                          │
# └──────────────────────────────────────────────────────────────────────────┘

## Do not load the rest of this file if '_INHERIT_ENV' is true (default: false) (type: bool)
#_INHERIT_ENV=
[[ -n "${_INHERIT_ENV}" ]] && PS1=":> " && printf "To reload zsh with your configurations, run the following command:\n\n%s_INHERIT_ENV= exec zsh\n\n" "${PS1}" && return 0

## Turn on extreme verbosity (default: false) (type: bool)
#_ZSH_LOAD_VERBOSE=
[[ -n "${_ZSH_LOAD_VERBOSE}" ]] && printf "This will be very verbose! To stop loading verbosly, run the following command:\n\n$ unsetopt xtrace\n\nWill continue startup in 3 seconds" && sleep 3 && setopt xtrace

## Show error messeges. This is unrelated to '_ZSH_LOAD_VERBOSE' (default: true) (type: bool)
_ZSH_SHOW_ERROR_MESSEGE=1

## Show verbose messeges. This is unrelated to '_ZSH_LOAD_VERBOSE' (default: true) (type: bool)
_ZSH_SHOW_VERBOSE_MESSEGE=1

## Directory that ZSH logs will be written to.
ZSH_DEBUG_LOG_DIR="${ZDOTDIR}/logs"

## If this option is set, a debug log will be written to '$ZSH_DEBUG_LOG_DIR'
_ZSH_DEBUGGING_ENABLED="TRUE"

## Name of the User-Folder for the 'profile' to use. This makes it easy to work
## on multiple zsh config profiles on the same machine/user (default: user) (type: string)
##   example:  $ ZSH_USER_DIR_NAME=different_user exec zsh
ZSH_USER_DIR_NAME="${ZSH_USER_DIR_NAME:-user}"

## Path to profile directory (default: zsh) (type: string)
ZSH_USER_DIR="${ZDOTDIR:-$HOME/.config/zsh}"/zsh/"${ZSH_USER_DIR_NAME}"

## Path to the folder that will be looped looking for file with and
## extension of '.zsh'. All files with an extension of '.zsh' will be sourced durring startup. (default: zsh.d) (type: string)
ZSH_USER_LOAD_DIR="${ZSH_USER_DIR}/zsh.d"

## Run zprof zsh module to debug zsh startup (default: false) (type: bool)
#ZSH_PROFILE_RC=
if [[ -n "$ZSH_PROFILE_RC" ]]; then
  which zmodload >&/dev/null && zmodload zsh/zprof
  PS4=$'\\\011%D{%s%6.}\011%x\011%I\011%N\011%e\011'
  exec 3>&2 2>${ZSH_DEBUG_LOG_DIR:-/tmp}/zshstart.$$.log
  setopt xtrace prompt_subst
fi


function _zshrc_VERBOSE_MESSEGE(){
  [[ -z "${_ZSH_SHOW_VERBOSE_MESSEGE}" ]] && return 0
  printf "\x1B[0;1;48;5;12;38;5;255m[VERBOSE]\x1B[0m:\t\x1B[0;38;5;255m%s\x1B[0m\n" "${@}"
}

function _zshrc_VERBOSE_ERROR(){
  [[ -z "${_ZSH_SHOW_ERROR_MESSEGE}" ]] && return 0
  printf "\x1B[0;1;48;5;196;38;5;255m[ERROR]\x1B[0m:\t\x1B[0;38;5;196m%s\x1B[0m\n" "${@}" >&2
  return 1
}


## MAIN
# shellcheck disable=1009,1072,1058,1036,1073
if [[ -d "${ZSH_USER_LOAD_DIR}" ]]; then
  for ZSH_FILE in "${ZSH_USER_LOAD_DIR}"/*.zsh(N); do
    source "${ZSH_FILE}" || _zshrc_VERBOSE_ERROR "Unable to source file: ${ZSH_FILE}"
  done
else
  _zshrc_VERBOSE_ERROR "Directory does not exist: ${ZSH_USER_LOAD_DIR}"
fi
