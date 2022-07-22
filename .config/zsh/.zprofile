# zprofile

[[ -z "${XDG_CONFIG_HOME}" ]] \
  && export XDG_CONFIG_HOME="${HOME}/.config"

[[ -z "${ZDOTDIR}" ]] \
  && export ZDOTDIR="${HOME}/.config/zsh"

[[ -z "${ZSHRC}" ]] \
  && export ZSHRC="${ZDOTDIR}/.zshrc"

[[ -z "${EDITOR}" ]] \
  && export EDITOR="nvim"

# Set our umask (defualt: 022)
umask 0077

