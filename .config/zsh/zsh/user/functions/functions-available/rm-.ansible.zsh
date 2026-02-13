# Remove nested ".ansible" directories safely.
# - Prefers `fd` if available, otherwise falls back to `find`.
# - Handles paths with spaces/newlines (no xargs).
# - Defaults to dry-run (prints what it *would* remove).
# - Use -f to actually delete; -y to skip confirmations; -q to be quieter.
rm-.ansible() {
  emulate -L zsh
  setopt pipefail
  setopt localoptions no_nomatch
  setopt extendedglob

  local do_delete=0
  local assume_yes=0
  local quiet=0
  local root="."

  # Parse args
  while (( $# )); do
    case "$1" in
      -f|--force)    do_delete=1 ;;
      -y|--yes)      assume_yes=1 ;;
      -q|--quiet)    quiet=1 ;;
      -h|--help)
        cat <<EOF
Usage: rm-.ansible [options] [path]

Find and remove nested '.ansible' directories. (mindepth: 2)

Options:
  -f, --force   Actually delete (default is dry-run)
  -y, --yes     Do not prompt for confirmation
  -q, --quiet   Reduce output
  -h, --help    Show help

Examples:
  rm-.ansible             # dry-run under current dir
  rm-.ansible -f          # delete under current dir
  rm-.ansible -f ~/repo   # delete under ~/repo

EOF
        return 0
        ;;
      --) shift; break ;;
      -*) printf 'rm-.ansible: unknown option: %s\n' "$1" >&2; return 2 ;;
      *)  root="$1" ;;
    esac
    shift
  done

  if [[ ! -d "${root}" ]]; then
    printf 'rm-.ansible: root is not a directory: %s\n' "${root}" >&2
    return 2
  fi

  local -a targets=()

  if command -v fd >/dev/null 2>&1; then
    # Use NUL-delimited output so weird filenames are safe.
    local t
    while IFS= read -r -d '' t; do
      targets+=("${t}")
    done < <(
      fd --color=never --hidden --type d --min-depth 2 --max-depth 64 \
         --glob '.ansible' --print0 -- "${root}"
    )
  else
    # Portable-ish fallback.
    local t
    while IFS= read -r -d '' t; do
      targets+=("${t}")
    done < <(
      find "${root}" -mindepth 2 -type d -name '.ansible' -print0 2>/dev/null
    )
  fi

  if (( ${#targets} == 0 )); then
    (( quiet )) || printf '%s\n' "No nested .ansible directories found under: ${root}"
    return 0
  fi

  if (( quiet == 0 )); then
    printf '%s\n' "Found ${#targets} directory(s):"
    local p
    for p in "${targets[@]}"; do
      printf '  %s\n' "${p}"
    done
  fi

  if (( do_delete == 0 )); then
    (( quiet )) || printf '%s\n' "Dry-run only. Re-run with -f to delete."
    return 0
  fi

  if (( assume_yes == 0 )); then
    printf '%s' "Delete these ${#targets} directory(s)? [y/N] "
    local reply
    IFS= read -r reply
    [[ "${reply:l}" == "y" || "${reply:l}" == "yes" ]] || {
      (( quiet )) || printf '%s\n' "Aborted."
      return 1
    }
  fi

  local rc=0
  local p
  for p in "${targets[@]}"; do
    if (( quiet )); then
      rm -rf -- "${p}" || rc=1
    else
      rm -rfv -- "${p}" || rc=1
    fi
  done

  return "${rc}"
}
