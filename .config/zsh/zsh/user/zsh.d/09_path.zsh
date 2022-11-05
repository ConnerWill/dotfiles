#shellcheck disable=2148,2015,2034

timelogging_start "09"

### [=]==================================[=]
### [~]............ SOURCE PATH
### [=]==================================[=]
###{{{

export PATH="${PATH}:$HOME/.bin"
export PATH="${PATH}:$HOME/.local/bin"
export PATH="${PATH}:$HOME/.local/lib/bat-extras/bin"
export PATH="${PATH}:$HOME/.local/bin/Python/3.8/bin"

###}}}

export ZSH_COMPLETIONS_DIR
ZSH_COMPLETIONS_DIR="$ZSH_USER_DIR/completion"
ZSH_USER_FPATH_DIR="${ZSH_USER_DIR}/fpath"
[[ -d "${ZSH_COMPLETIONS_DIR}" ]] && fpath+=( "${ZSH_COMPLETIONS_DIR}" ) || mkdir -vp "${ZSH_COMPLETIONS_DIR}"
[[ -d "${ZSH_USER_FPATH_DIR}" ]] && fpath+=( "${ZSH_USER_FPATH_DIR}" )

# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

timelogging_end 09
