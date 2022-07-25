### [=]==================================[=]
### [~]............ SOURCE PATH
### [=]==================================[=]
###{{{

export PATH="${PATH}:$HOME/.bin"
export PATH="${PATH}:$HOME/.local/bin"
export PATH="${PATH}:$HOME/.local/lib/bat-extras/bin"
export PATH="${PATH}:$HOME/.local/bin/Python/3.8/bin"

###}}}

export ZSH_COMPLETIONS_DIR="$ZSH_USER_DIR/completion"
[[ -d "${ZSH_COMPLETIONS_DIR}" ]] \
  && fpath+=( "${ZSH_COMPLETIONS_DIR}" ) \
  || mkdir -vp "${ZSH_COMPLETIONS_DIR}"


# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

