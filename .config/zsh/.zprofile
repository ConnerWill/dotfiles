#!/bin/env zsh
#shellcheck disable=1071

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


## Set '_enable_ssh_gpg_agent' to 1 to enable ssh gpg agent
_enable_ssh_gpg_agent=${_enable_ssh_gpg_agent:-0}
if (( _enable_ssh_gpg_agent )) {
  function _zshinit_ssh_gpg_agent(){
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
  }; _zshinit_ssh_gpg_agent; unset -f _zshinit_ssh_gpg_agent
};unset _enable_ssh_gpg_agent
