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
## Do not load the rest of this file if 'INHERIT_ENV' is true (default: false)
[[ -n "${INHERIT_ENV}" ]] && return 0

#_ZSH_LOAD_VERBOSE_VERBOSE="True"
[[ -n "${_ZSH_LOAD_VERBOSE_VERBOSE}" ]] && setopt xtrace

#ZSH_PROFILE_RC=1
if [[ -n "$ZSH_PROFILE_RC" ]]; then
  which zmodload >&/dev/null && zmodload zsh/zprof
  PS4=$'\\\011%D{%s%6.}\011%x\011%I\011%N\011%e\011'
  exec 3>&2 2>${ZSH_DEBUG_LOG_DIR:-/tmp}/zshstart.$$.log
  setopt xtrace prompt_subst
fi

unset  _ZSH_LOAD_VERBOSE _ZSH_SHOW_ERRORS
export _ZSH_LOAD_VERBOSE _ZSH_SHOW_ERRORS \
       ZSH_USER_DIR_NAME ZSH_USER_DIR ZSH_USER_LOAD_DIR

## Name of the User-Folder for the 'profile' to use. This makes it easy to work
## on multiple zsh config profiles on the same machine/user
ZSH_USER_DIR_NAME="${ZSH_USER_DIR_NAME:-user}"

## Define the path of sub-profiles
ZSH_USER_DIR="${ZDOTDIR:-$HOME/.config/zsh}"/zsh/"${ZSH_USER_DIR_NAME}"

## Define the name of the folder that will be looped looking for file with and
## extension of '.zsh'. All files with an extension of '.zsh' will be sourced durring startup.
ZSH_USER_LOAD_DIR="${ZSH_USER_DIR}/zsh.d"

## Show error messeges. This is unrelated to '_ZSH_LOAD_VERBOSE'
_ZSH_SHOW_ERRORS="TRUE"

## Directory that ZSH logs will be written to.
ZSH_DEBUG_LOG_DIR="${ZDOTDIR}/logs"

## If this option is set, a debug log will be written to '$ZSH_DEBUG_LOG_DIR'
_ZSH_DEBUGGING_ENABLED="TRUE"

function _zshrc_VERBOSE_MESSEGE(){
  printf "\x1B[0;1;48;5;12;38;5;255m[VERBOSE]\x1B[0m:\t\x1B[0;38;5;255m%s\x1B[0m\n" "${1}"
}

function _zshrc_VERBOSE_ERROR(){
  printf "\x1B[0;1;48;5;196;38;5;255m[ERROR]\x1B[0m:\t\x1B[0;38;5;196m%s\x1B[0m\n" "${1}" >&2
  return 1
}

function _zshload_clear_line(){
  printf "\x1B[2K\r"
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
