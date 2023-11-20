#shellcheck disable=2148

## XDG
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_CONFIG_HOME XDG_DATA_HOME XDG_CACHE_HOME

## ZSH
ZDOTDIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-${HOME}/.config}/zsh}"
ZSHRC="${ZSHRC:-${ZDOTDIR:-${XDG_CONFIG_HOME:-${HOME}/.config}/zsh}/.zshrc}"
export ZDOTDIR ZSHRC

## LOCALE
LC_ALL="${LC_ALL:-en_US.UTF-8}"
export LC_ALL
