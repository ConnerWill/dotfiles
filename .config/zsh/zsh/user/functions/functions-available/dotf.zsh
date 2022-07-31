#shellcheck disable=1072,1073
(){
  [[ -z "${DOTFILES}" ]] && DOTFILES="${HOME}/.dotfiles"
  if [[ -d "${DOTFILES}" ]]; then
    export DOTFILES
    # No arguments: `git status` With arguments: acts like `git`
    dotf() {
      if [[ ${1} == "add" ]]; then

      elif [[ ${1} == "help" ]]; then
        printf "dotf help : enter help msg here\n"
      elif [[ ${1} == "add-all" ]]; then
         $(command -v git) --git-dir=$DOTFILES --work-tree=$HOME diff --name-only | xargs -I{} sh -c "$(command -v git) --git-dir=$DOTFILES --work-tree=$HOME add -v $HOME/{}"
      else
        if [[ $# -gt 0 ]]; then
          $(command -v git) --git-dir=${DOTFILES} --work-tree=${HOME} "$@"
        else
          $(command -v git) --git-dir=${DOTFILES} --work-tree=${HOME} status
        fi
      fi
    }
  else
    unset DOTFILES
    unfunction dotf
  fi
}
