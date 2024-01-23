#shellcheck disable=2148

case "${OSTYPE}" in
  "linux-gnu")
      if [[ -f /etc/os-release ]]; then
        DISTRO=$(grep --extended-regexp --regexp='^NAME=' /etc/os-release | cut -d'=' -f2 | cut -d' ' -f1 | cut -d'"' -f2)
        export DISTRO
      fi
    ;;
  "linux-musl")
      if [[ -f /etc/os-release ]]; then
        DISTRO=$(grep --extended-regexp --regexp='^NAME=' /etc/os-release | cut -d'=' -f2 | cut -d' ' -f1 | cut -d'"' -f2)
        export DISTRO
      fi
    ;;
  "linux-android")
      DISTRO="Android"
      export DISTRO
    ;;
  "darwin"*)
      DISTRO="Darwin"
      export DISTRO
    ;;
  *)
      unset DISTRO
    ;;
esac
