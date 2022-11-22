#!/bin/env zsh
#shellcheck disable=1071

#  Profiling
#ZSH_PROFILE_RC=1
if [[ -n "$ZSH_PROFILE_RC" ]]; then
  which zmodload >&/dev/null && zmodload zsh/zprof
  PS4=$'\\\011%D{%s%6.}\011%x\011%I\011%N\011%e\011'
  exec 3>&2 2>${ZSH_DEBUG_LOG_DIR:-/tmp}/zshstart.$$.log
  setopt xtrace prompt_subst
fi


#zprofile
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export ZDOTDIR="${ZDOTDIR:-${HOME}/.config/zsh}"
export ZSHRC="${ZSHRC:-${ZDOTDIR}/.zshrc}"
export EDITOR="${EDITOR:-nvim}"


# Set our umask (defualt: 022)
umask 0077






if [[ -n "${DISPLAY}" ]] {
  $KEY
  setxkbmap     \
    -layout us  \
    -variant ,qwerty-option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape'
  xset r rate 200 30
}


_enable_ssh_gpg_agent=${_enable_ssh_gpg_agent:-1}
## Set '_enable_ssh_gpg_agent' to 1 to enable ssh gpg agent
_enable_ssh_gpg_agent=${_enable_ssh_gpg_agent:-0}
if (( _enable_ssh_gpg_agent )) {
  function _zshinit_ssh_gpg_agent(){
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
  }; _zshinit_ssh_gpg_agent; unset -f _zshinit_ssh_gpg_agent
};unset _enable_ssh_gpg_agent
