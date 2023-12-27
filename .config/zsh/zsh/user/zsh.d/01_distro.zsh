#shellcheck disable=2148

if [[ "${OSTYPE}" == "linux-gnu" ]]; then
  [[ -f /etc/os-release ]] && export DISTRO=$(cat /etc/os-release | grep --extended-regexp --regexp='^NAME=' | cut -d'=' -f2 | cut -d' ' -f1 | cut -d'"' -f2)
elif [[ "${OSTYPE}" == "linux-android" ]]; then
  export DISTRO="Android"
elif [[ "${OSTYPE}" == "darwin"* ]]; then
  export DISTRO="Darwin"
else
  unset DISTRO
fi
