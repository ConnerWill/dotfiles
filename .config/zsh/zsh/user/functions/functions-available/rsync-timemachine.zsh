

rsync-timemachine(){
  emulate -L zsh
  setopt errreturn
  local includes_file excludes_file backup_target backup_destination rsync_get_flags DRY_RUN
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
    || return 1

  timemachine_extra_flags=''
  rsync_flags=(
    --rsync-path="${rsync_path}"
    --include=/etc
    --include=/home
    --include=/home/dampsock
    --include-from="${includes_file:?}"
    --exclude-from="${excludes_file:?}"
  )

  [[ -n "${DRY_RUN}" ]] && rsync_flags+=( --dry-run )
  [[ -n "${rsync-get-flags}" ]]                               \
    || unset timemachine_extra_flags
    # && timemachine_extra_flags+=() \

  #sudo --reset-timestamp
  sudo --validate

  sudo --preserve-env                                         \
                      rsync-tmbackup                          \
                        --rsync-append-flags "${rsync_flags}" \
                        "${backup_target}"                    \
                        "${backup_destination}"

   # "${timemachine_extra_flags}"            \
}
