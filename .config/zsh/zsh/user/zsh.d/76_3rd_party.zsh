#shellcheck disable=2148,2015
### [=]==================================[=]
### [~].......... SHELLFISH
### [=]==================================[=]

SHELLFISHRC="${SHELLFISHRC:-${HOME}/.shellfishrc}"
SHELLFISH_CONFIG_DIR="${SHELLFISH_CONFIG_DIR:-${XDG_CONFIG_HOME:-${HOME}/.config}/shellfish}"
export SHELLFISHRC SHELLFISH_CONFIG_DIR

if [[ -n "${LC_TERMINAL}" ]]; then
  if [[ -f "${SHELLFISHRC}" ]]; then
    if [[ ! -d "${SHELLFISH_CONFIG_DIR}" ]]; then
      mkdir -pv "${SHELLFISH_CONFIG_DIR}" 
    fi
    source "${SHELLFISHRC}" || echo "cant source shellfishrc"
  else
    unset SHELLFISHRC SHELLFISH_CONFIG_DIR
  fi
fi

