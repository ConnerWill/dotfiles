#!/bin/env bash

set -e

NEOVIM_GIT_URL="https://github.com/neovim/neovim"
CHECKOUT_BRANCH="stable"
NEOVIM_CLONE_NAME="neovim"
BUILD_DIR_NAME="build"
BUILD_DIR="/tmp/${BUILD_DIR_NAME}"
NEOVIM_BUILD_DIR="${BUILD_DIR}/${NEOVIM_CLONE_NAME}"
PRE_PWD=$(pwd)

#typeset -a NEOVIM_DEPENDENCIES
#NEOVIM_DEPENDENCIES='ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen'

function mkcd_build_dir(){
  # local BUILD_DIR_NAME BUILD_DIR INPUT
  # INPUT="${*}" #; [[ -z "${INPUT}" ]] && printf "\nNo Input\n" && return 1
  [[ -z "${BUILD_DIR}" ]] \
    && printf "\e[0;1;38;5;196mBUILD_DIR not defined\t\e[0;3;38;5;93m:(\e[0m\n" \
    && return 1
  [[ -d "${BUILD_DIR}" ]] \
    && printf "\e[0;1;38;5;196mBUILD_DIR already exists\t\e[0;3;38;5;93m:(\e[0m\n" \
    && return 1
  if mkdir -p "${BUILD_DIR}" >/dev/null 2>&1; then
    printf "\e[0;1;38;5;46mCreated directory:\t\e[0;3;38;5;93m%s\e[0m\n" "${BUILD_DIR}"
    cd "${BUILD_DIR}" \
      || printf "\e[0;1;38;5;196mCould not move to directory:\t\e[0;3;38;5;93m%s\e[0m\n" "${BUILD_DIR_NAME}" \
      || return 1
  else
    printf "\e[0;1;38;5;196mUnable to create directory\t\e[0;3;38;5;93m%s\e[0m\n" "${BUILD_DIR}"; return 1
  fi
}

function clone_neovim(){
  printf "\n\n\e[0;38;5;201m\t\tCLONING\n\n"
  if command -v git >/dev/null 2>&1; then
    if git clone "${NEOVIM_GIT_URL}" "${NEOVIM_BUILD_DIR}"; then
      printf "\e[0m"
      return 0
    else
      printf "\e[0;1;38;5;196mUnable to clone respository:\t\e[0;3;38;5;93m%s\e[0m\n" "${NEOVIM_CLONE_NAME}"
      return 1
    fi
  fi
  printf "\e[0m"
}

function cd_neovim_build_dir(){
  [[ -z "${NEOVIM_BUILD_DIR}" ]] \
    && printf "\e[0;1;38;5;196mNEOVIM_BUILD_DIR not defined\t\e[0;3;38;5;93m:(\e[0m\n" \
    && return 1
  cd "${NEOVIM_BUILD_DIR}" \
    || printf "\e[0;1;38;5;196mCould not move to directory:\t\e[0;3;38;5;93m%s\e[0m\n" "${NEOVIM_BUILD_DIR}" \
    || return 1
  printf "\e[0m"
}

function clean_exit(){
  cd "${PRE_PWD}" \
    || printf "\e[0;1;38;5;196mCould move to directory:\t\e[0;3;38;5;93m%s\e[0m\n" "${PRE_PWD}"
  printf "\e[0;38;5;190m"
  rm -fr "${BUILD_DIR}" \
    || printf "\e[0;1;38;5;196mCould not remove directory:\t\e[0;3;38;5;93m%s\e[0m\n" "${BUILD_DIR}"
  printf "\e[0m"
}

function install_depends(){
  printf "\e[0;38;5;21m"
  sudo apt-get update
  printf "\e[0;38;5;190m"
  sudo apt-get install --yes ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen || return 1
  printf "\e[0m\n"
}

function install_neovim(){
  printf "\e[0;38;5;201m "
  git checkout "${CHECKOUT_BRANCH}"     || return 1 && printf "\e[0;38;5;87m"
  make CMAKE_BUILD_TYPE=RelWithDebInfo  || return 1 && printf "\e[0;38;5;46m"
  sudo make install                     || return 1
  printf "\e[0m\n"
}

install_depends
trap "clean_exit" 1,2,3,6
mkcd_build_dir
clone_neovim
cd_neovim_build_dir
install_neovim
clean_exit
