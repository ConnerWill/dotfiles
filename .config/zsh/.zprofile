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


###zprofile
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"

## zsh config files
export ZDOTDIR="${ZDOTDIR:-${HOME}/.config/zsh}"
export ZSHRC="${ZSHRC:-${ZDOTDIR}/.zshrc}"


# ## Editor
# if   [[ "${commands[nvim]}" ]]; then prefered_editor="nvim"
# elif [[ "${commands[vim]}"  ]]; then prefered_editor="vim"
# elif [[ "${commands[nano]}" ]]; then prefered_editor="nano"
# elif [[ "${commands[vi]}"   ]]; then prefered_editor="vi"
# else                                 prefered_editor=
# fi
#
EDITOR="${EDITOR:-${commands[nvim]:-${commands[vim]}}}"
export EDITOR="${EDITOR:-${prefered_editor}}"
unset prefered_editor



# Set our umask (Defualt: 022)
umask 0077

if [[ -n "${DISPLAY}" ]] {
  $KEY

  setxkbmap     \
    -layout us  \
    -variant ,qwerty-option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape'

  xset r rate 200 30
}


## Set '_enable_ssh_gpg_agent' to 1 to enable ssh gpg agent
_enable_ssh_gpg_agent=${_enable_ssh_gpg_agent:-1}
if (( _enable_ssh_gpg_agent )) {
  function _zshinit_ssh_gpg_agent(){
    GPG_TTY="$(tty)"
    SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)
    gpgconf --launch gpg-agent 2>/dev/null

    export GPG_TTY SSH_AUTH_SOCK

  }; _zshinit_ssh_gpg_agent
  unset -f _zshinit_ssh_gpg_agent
}
unset _enable_ssh_gpg_agent
