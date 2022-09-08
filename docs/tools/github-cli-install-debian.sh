#!/bin/env bash

set -e

GITHUB_CLONE_NAME="github_cli"
BUILD_DIR_NAME="build-github"
BUILD_DIR="/tmp/${BUILD_DIR_NAME}"
GITHUB_BUILD_DIR="${BUILD_DIR}/${GITHUB_CLONE_NAME}"
PRE_PWD=$(pwd)


function import_key(){
  printf "\n\n\e[0;38;5;201m\t\tIMPORTING KEYn\n"
  if command -v git >/dev/null 2>&1; then
    if curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg; then
      sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
      printf "\e[0m"
      return 0
    else
      printf "\e[0;1;38;5;196mUnable to import key\t\e[0;3;38;5;93m\e[0m\n"
      return 1
    fi
  fi
  printf "\e[0m"
}

function add_repo(){
  printf "\n\n\e[0;38;5;21m\t\tAdding repo\n\n"
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  printf "\e[0m"
}

function clean_exit(){
  printf "\e[0;38;5;190m"
  echo "BYE"
  cd "${PRE_PWD}" \
    || printf "\e[0;1;38;5;196mCould move to directory:\t\e[0;3;38;5;93m%s\e[0m\n" "${PRE_PWD}"
  printf "\e[0m"
}

function install_github_cli(){
  printf "\e[0;38;5;21m"
  sudo apt-get update
  printf "\e[0;38;5;190m"
  sudo apt-get install --yes gh || return 1
  printf "\e[0m\n"
}

trap "clean_exit" 1,2,3,6
import_key
add_repo
install_github_cli
clean_exit

trap -
