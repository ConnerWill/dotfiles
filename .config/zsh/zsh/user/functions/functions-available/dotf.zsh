[[ -z "${DOTFILES}" ]] && DOTFILES="${HOME}/.dotfiles"
if [[ -d "${DOTFILES}" ]]; then
  export DOTFILES
  # No arguments: `git status` With arguments: acts like `git`
  dotf() {
    if [[ $# -gt 0 ]]; then
      $(command -v git) --git-dir=${DOTFILES} --work-tree=${HOME} "$@"
    else
      $(command -v git) --git-dir=${DOTFILES} --work-tree=${HOME} status
    fi
  }
  # compdef dotf=git
else
  unset DOTFILES
fi



