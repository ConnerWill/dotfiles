#shellcheck disable=2148,2015
### [=]==================================[=]
### [~]............ SOURCE PATH
### [=]==================================[=]
###{{{

export PATH="${PATH}:${HOME}/.bin"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/.local/lib/bat-extras/bin"
export PATH="${PATH}:${HOME}/.local/bin/Python/3.8/bin"
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${PATH}:${XDG_DATA_HOME}/gem/ruby/3.0.0/bin"

path+=( "${HOME}/.bin"                          )
path+=( "${HOME}/.local/bin"                    )
path+=( "${HOME}/.local/lib/bat-extras/bin"     )
path+=( "${HOME}/.local/bin/Python/3.8/bin"     )
path+=( "${HOME}/go/bin"                        )
path+=( "${XDG_DATA_HOME}/gem/ruby/3.0.0/bin"   )



export ZSH_COMPLETIONS_DIR="$ZSH_USER_DIR/completion"
[[ -d "${ZSH_COMPLETIONS_DIR}" ]] \
  && fpath+=( "${ZSH_COMPLETIONS_DIR}" ) \
  || mkdir -vp "${ZSH_COMPLETIONS_DIR}"

ZSH_USER_FPATH_DIR="${ZSH_USER_DIR}/fpath"
[[ -d "${ZSH_USER_FPATH_DIR}" ]] \
  && fpath+=( "${ZSH_USER_FPATH_DIR}" )

# automatically remove duplicates from these arrays
#shellcheck disable=2034
#typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH
