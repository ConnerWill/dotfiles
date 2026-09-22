#shellcheck disable=2148,2015
### [=]==================================[=]
### [~]............ SOURCE PATH
### [=]==================================[=]

## Automatically remove duplicates from these arrays (must be set before appending)
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

## Only append directories that actually exist, keeping $PATH clean.
for _p in \
  "/bin" \
  "/sbin" \
  "/usr/bin" \
  "/usr/local/bin" \
  "/usr/local/sbin" \
  "/usr/sbin" \
  "${HOME}/.bin" \
  "${HOME}/.cargo/bin" \
  "${HOME}/.local/bin" \
  "${HOME}/.local/bin/Python/3.8/bin" \
  "${HOME}/.local/lib/bat-extras/bin" \
  "${HOME}/.platformio/penv/bin" \
  "${HOME}/go/bin" \
  "${XDG_DATA_HOME}/gem/ruby/3.0.0/bin" \
; do
  [[ -d "${_p}" ]] && path+=( "${_p}" )
done; unset _p

## Alternativly set PATH like this
# export PATH="${PATH}:${HOME}/.bin"
