#!/bin/bash

rm -rfv        \
  "${NVIMDIR}" \
  "${ZDOTDIR}" \
  "${HOME}/.config/{tmux,zsh-new,zsh-temp,nvim,Xresources}"

[[ -z "${DOTFILES}" ]] \
  && export DOTFILES="${HOME}/.dotfiles"

if [[ -d "${DOTFILES}" ]];then
  alias dotfiles="git --git-dir=${DOTFILES} --work-tree=${HOME}"
  alias dotf="git --git-dir=${DOTFILES} --work-tree=${HOME}"
else
  dotfiles_git_repo_url="https://github.com/ConnerWill/dotfiles"

  git                          \
    clone                      \
    --bare                     \
    --verbose                  \
    --progress                 \
    "${dotfiles_git_repo_url}" \
    "${DOTFILES}"

  git                          \
    --git-dir="${DOTFILES}"    \
    --work-tree="${HOME}"      \
    config                     \
      --local                  \
        status.showUntrackedFiles no

  alias dotfiles="git --git-dir=${DOTFILES} --work-tree=${HOME}"
  alias dotf="git --git-dir=${DOTFILES} --work-tree=${HOME}"

fi




