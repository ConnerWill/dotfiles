#shellcheck disable=2148,2015
### [=]==================================[=]
### [~]............ SOURCE PATH
### [=]==================================[=]

path+=( "/bin"                                )
path+=( "/sbin"                               )
path+=( "/usr/bin"                            )
path+=( "/usr/local/bin"                      )
path+=( "/usr/local/sbin"                     )
path+=( "/usr/sbin"                           )
path+=( "${HOME}/.bin"                        )
path+=( "${HOME}/.cargo/bin"                  )
path+=( "${HOME}/.local/bin"                  )
path+=( "${HOME}/.local/bin/Python/3.8/bin"   )
path+=( "${HOME}/.local/lib/bat-extras/bin"   )
path+=( "${HOME}/go/bin"                      )
path+=( "${XDG_DATA_HOME}/gem/ruby/3.0.0/bin" )

## Alternativly set PATH like this
# export PATH="${PATH}:${HOME}/.bin"

# automatically remove duplicates from these arrays
#typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH
