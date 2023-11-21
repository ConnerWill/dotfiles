#shellcheck disable=2148

## XDG
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"

## ZSH
ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-${HOME}/.config}/zsh}"
ZSHRC="${ZSHRC:-${ZDOTDIR:-${XDG_CONFIG_HOME:-${HOME}/.config}/zsh}/.zshrc}"

## LOCALE
LC_ALL="${LC_ALL:-en_US.UTF-8}"

## DOTFILES
DOTFILES="${DOTFILES:-${HOME}/.dotfiles}"

## EDITOR
EDITOR="${EDITOR:-${commands[nvim]:-${commands[vim]:-vi}}}"
FCEDIT="${EDITOR}"


## Export variables to ENV
export                                         \
  ZDOTDIR ZSHRC                                \
  XDG_CONFIG_HOME XDG_DATA_HOME XDG_CACHE_HOME \
  LC_ALL                                       \
  DOTFILES                                     \
  EDITOR FCEDIT
