#shellcheck disable=2148,2015
### [=]==================================[=]
### [~]............ SOURCE PATH
### [=]==================================[=]

path+=( "${HOME}/.bin"                        )
path+=( "${HOME}/.local/bin"                  )
path+=( "${HOME}/.local/lib/bat-extras/bin"   )
path+=( "${HOME}/.local/bin/Python/3.8/bin"   )
path+=( "${HOME}/go/bin"                      )
path+=( "${HOME}/.cargo/bin"                  )
path+=( "${XDG_DATA_HOME}/gem/ruby/3.0.0/bin" )

### [=]==================================[=]
### [~]............ SOURCE FPATH
### [=]==================================[=]
fpath+=( "${ZSH_USER_DIR}/completion"                                 )
fpath+=( "${ZSH_USER_DIR}/fpath"                                      )
fpath+=( "${ZSH_USER_DIR}/functions/functions-available"              )
fpath+=( "${ZSH_USER_DIR}/functions/functions-maunal"                 )
fpath+=( "${ZSH_USER_DIR}/functions/functions-manual/dotf/completion" )
fpath+=( "${ZSH_USER_DIR}/functions/functions-manual/dotf/bin"        )

## Alternativly set PATH like this
# export PATH="${PATH}:${HOME}/.bin"

# automatically remove duplicates from these arrays
#typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH
