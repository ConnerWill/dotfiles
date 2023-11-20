#shellcheck disable=2148
EDITOR="${EDITOR:-${commands[nvim]:-${commands[vim]}}}"

# Set our umask (Defualt: 022)
umask 0077

if [[ -n "${DISPLAY}" ]]; then
  $KEY
  setxkbmap     \
    -layout us  \
    -variant ,qwerty-option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape'
  xset r rate 200 30
fi

_enable_ssh_gpg_agent=${_enable_ssh_gpg_agent:-1}  ## Set '_enable_ssh_gpg_agent' to 1 to enable ssh gpg agent
if [[ ${_enable_ssh_gpg_agent} == 1 ]]; then
  function _zshinit_ssh_gpg_agent(){
    GPG_TTY="$(tty)"
    SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null)
    gpgconf --launch gpg-agent 2>/dev/null
    export GPG_TTY SSH_AUTH_SOCK
  }; _zshinit_ssh_gpg_agent; unset -f _zshinit_ssh_gpg_agent
fi; unset _enable_ssh_gpg_agent
