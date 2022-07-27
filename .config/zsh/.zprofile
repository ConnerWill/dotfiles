#!/bin/env zsh
#shellcheck disable=1071

#zprofile
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export ZDOTDIR="${ZDOTDIR:-${HOME}/.config/zsh}"
export ZSHRC="${ZSHRC:-${ZDOTDIR}/.zshrc}"
export EDITOR="${EDITOR:-nvim}"


# Set our umask (defualt: 022)
umask 0077

if [[ -n "${DISPLAY}" ]]; then
  setxkbmap     \
    -layout us  \
    -variant ,qwerty-option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape'
  xset r rate 200 30
fi
