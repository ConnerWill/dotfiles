# shellcheck disable=2148

chmodchown() {
  emulate -L zsh
  setopt pipe_fail

  autoload -U colors && colors

  # -------------------------------
  # color helpers
  # -------------------------------
  local C_ERR="%F{red}"
  local C_WARN="%F{yellow}"
  local C_OK="%F{green}"
  local C_HEAD="%F{cyan}"
  local C_BOLD="%B"
  local C_RESET="%f%b"

  # -------------------------------
  # helpers (intentionally nested)
  # -------------------------------

  chmodchown::usage() {
    print -P "${C_HEAD}${C_BOLD}Usage:${C_RESET} chmodchown [options] <reference_file> <target>\n"

    print -P "${C_HEAD}${C_BOLD}Description:${C_RESET}"
    print -P "  Make <target> match the ownership and permissions of <reference_file>.\n"

    print -P "${C_HEAD}${C_BOLD}Behavior:${C_RESET}"
    print -P "  • Ownership (chown) may be applied recursively"
    print -P "  • Permissions (chmod) are applied to <target> only\n"

    print -P "${C_HEAD}${C_BOLD}Options:${C_RESET}"
    print -P "  ${C_OK}-h${C_RESET}, ${C_OK}--help${C_RESET}        Show this help message"
    print -P "  ${C_OK}-v${C_RESET}, ${C_OK}--verbose${C_RESET}     Verbose output"
    print -P "  ${C_OK}-R${C_RESET}, ${C_OK}--recursive${C_RESET}   Apply ownership recursively (chown only)\n"

    print -P "${C_HEAD}${C_BOLD}Environment:${C_RESET}"
    print -P "  ${C_OK}VERBOSE${C_RESET}           Enable verbose output\n"

    print -P "${C_HEAD}${C_BOLD}Examples:${C_RESET}"
    print -P "  chmodchown template.conf myfile"
    print -P "  chmodchown -R -v template.conf /etc/myapp"
  }

  chmodchown::parse_opts() {
    verbose=0
    recursive=0

    while (( ${#} )); do
      case "${1}" in
        -h|--he*)
          chmodchown::usage
          return 1
          ;;
        -v|--verb*)
          verbose=1
          shift
          ;;
        -R|--recur*)
          recursive=1
          shift
          ;;
        --)
          shift
          break
          ;;
        -*)
          print -P "${C_ERR}Error:${C_RESET} Unknown option: ${C_BOLD}${1}${C_RESET}"
          print -P "${C_WARN}Hint:${C_RESET} Try: chmodchown --help"
          return 1
          ;;
        *)
          break
          ;;
      esac
    done

    reference_file="${1:-}"
    target="${2:-}"
  }

  chmodchown::validate() {
    if [[ -z "${reference_file}" || -z "${target}" ]]; then
      print -P "${C_ERR}Error:${C_RESET} Missing arguments"
      print -P "${C_WARN}Hint:${C_RESET} Try: chmodchown --help"
      return 1
    fi

    if [[ ! -e "${reference_file}" ]]; then
      print -P "${C_ERR}Error:${C_RESET} Reference file does not exist: ${C_BOLD}${reference_file}${C_RESET}"
      return 1
    fi

    if [[ ! -e "${target}" ]]; then
      print -P "${C_ERR}Error:${C_RESET} Target does not exist: ${C_BOLD}${target}${C_RESET}"
      return 1
    fi
  }

  chmodchown::build_flags() {
    # chown: recursive allowed
    chown_flags=( --reference="${reference_file}" )

    if (( recursive )); then
      chown_flags+=(--recursive)
    fi

    # chmod: never recursive
    chmod_flags=( --reference="${reference_file}" )

    if (( verbose )) || [[ -n "${VERBOSE}" ]]; then
      chown_flags+=(--verbose)
      chmod_flags+=(--verbose)
    fi
  }

  chmodchown::run() {
    print -P "${C_OK}→${C_RESET} Requesting sudo authentication…"
    sudo --reset-timestamp || return 1

    print -P "${C_OK}→${C_RESET} Applying ownership to ${C_BOLD}${target}${C_RESET}"
    sudo chown "${chown_flags[@]}" "${target}" || return 1

    print -P "${C_OK}→${C_RESET} Applying permissions to ${C_BOLD}${target}${C_RESET}"
    sudo chmod "${chmod_flags[@]}" "${target}"
  }

  # -------------------------------
  # state
  # -------------------------------
  local reference_file target
  local verbose recursive
  local -a chown_flags chmod_flags

  # -------------------------------
  # execution flow
  # -------------------------------
  chmodchown::parse_opts "$@" || return
  chmodchown::validate        || return
  chmodchown::build_flags     || return
  chmodchown::run
}
