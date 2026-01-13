# shellcheck disable=1072,2148

repo-root(){
  local root
  if ! root=$(git rev-parse --show-toplevel 2>/dev/null); then
    print -u2 -P "%F{red}Warning%f: not inside a git repository"
    return 1
  fi
  print -- "$root"
}

