#shellcheck disable=2148,2015
### [=]==================================[=]
### [~]............ SOURCE FPATH
### [=]==================================[=]
fpath+=( "${ZSH_USER_DIR}/completion"                                 )
fpath+=( "${ZSH_USER_DIR}/fpath"                                      )
fpath+=( "${ZSH_USER_DIR}/functions/functions-available"              )
fpath+=( "${ZSH_USER_DIR}/functions/functions-manual/dotf/bin"        )
fpath+=( "${ZSH_USER_DIR}/functions/functions-manual/dotf/completion" )
fpath+=( "${ZSH_USER_DIR}/functions/functions-maunal"                 )

## Alternativly set PATH like this
# export PATH="${PATH}:${HOME}/.bin"

# automatically remove duplicates from these arrays
#typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH
