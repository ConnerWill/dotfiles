# No arguments: `git status`
# With arguments: acts like `git`
gi() {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status
  fi
}

# compdef gi=git
