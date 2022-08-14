

rsync-timemachine(){
  emulate -L zsh
  setopt errreturn
  setopt errexit
  local includes_file excludes_file backup_target backup_destination rsync_get_flags DRY_RUN errorcode
  local -a rsync_flags
  local -a timemachine_extra_flags
    # --rsync-get-flags
     # rsync_get_flags=${rsync_get_flags:-}
             # DRY_RUN=${DRY_RUN:-true}



             rsync_path='"$(command -v sudo)" "$(command -v rsync)"'
       excludes_file="${HOME}/.rsync-tmbackup/excludes.txt"
       includes_file="${HOME}/.rsync-tmbackup/includes.txt"

       backup_target="${1:-/home}"
  backup_destination="${2:-/backup/archdesk-backups/2022}"

  [[ -e "${excludes_file}" ]]                                 \
    || printf "Cannot find excludes file at %s" "${excludes_file}" \
    || exit 1

  timemachine_extra_flags=''
  rsync_flags=(
    --rsync-path="${rsync_path:?}"
    --include=/etc
    --include="${HOME:?}"
    --include-from="${includes_file:?}"
    --exclude-from="${excludes_file:?}"
  )

mountpoint "${backup_destination}" \
      || printf "\e[0;1;2;3;38;5;255;48;5;196m  FUCK  \e[0;38;5;190m  Error: destination is not mounted \e[0;38;5;201m :( \e[0;1;38;5;196m!\e[0m\n" \
      || return 1

  [[ -n "${DRY_RUN}" ]] && rsync_flags+=( --dry-run )
  printf "\n\e[0;38;5;93mDo you want to backup \e[0;38;5;190m'%s'\e[0;38;5;93mto\e[0;38;5;201m '%s'\e[0m\n" "$(print -lO "${backup_target[@]}")" "${backup_destination}"
  printf "\e[0;38;5;93mPress 'y' To Start Backup\e[0m: "
  read -s -r -t 10 start_backup_yes
  if [[ "${start_backup_yes}" == "y" ]]; then
    printf "\n\e[0;38;5;33mRunning backup \e[0;38;5;190m\t :) \e[0m\n"

  [[ -n "${rsync-get-flags}" ]]                               \
    || unset timemachine_extra_flags
    # && timemachine_extra_flags+=() \

  #sudo --reset-timestamp
  sudo --validate || echo "u no sudo" || return 1

  sudo --preserve-env                                         \
                      rsync-tmbackup                          \
                        --rsync-append-flags "${rsync_flags}" \
                        "${backup_target}"                    \
                        "${backup_destination}"               \
      && printf "\e[0;38;5;82myayyyy \e[0;38;5;87m You did it \e[0m\n" \
      && errorcode=0 \
      &&  sleep 5 \
      || printf "\e[0;1;2;3;38;5;255;48;5;196m  FUCK  \e[0;38;5;190m  Error: Failed to backup \e[0;38;5;201m :( \e[0;1;38;5;196m!\e[0m\n" \
      || errorcode=1
  else
    printf "\n\e[0;2;38;5;93m k ... '\e[0;2;38;5;87m bye...\e[0m\n"
  fi
  printf "\n\e[0;2;38;5;46mExiting ...\e[0m\n"
  sleep 1
  tput rmcup
  return $errorcode


  # printf "\n"
  # printf "\t\e[0;38;5;33mName   :\t\e[0;38;5;190m%s\e[0m\n" "${KeyName}"
  # printf "\t\e[0;38;5;33mPath   :\t\e[0;38;5;190m%s\e[0m\n" "${keyPath}"
  # printf "\t\e[0;38;5;33mComment:\t\e[0;38;5;190m%s\e[0m\n" "${cleanedKeyName}"
  # printf "\t\e[0;38;5;33mType   :\t\e[0;38;5;190m%s\e[0m\n" "${keyType}"
  # printf "\t\e[0;38;5;33mBits   :\t\e[0;38;5;190m%s\e[0m\n" "${keyBits}"
  # printf "\n"
  #

   # "${timemachine_extra_flags}"            \
}
