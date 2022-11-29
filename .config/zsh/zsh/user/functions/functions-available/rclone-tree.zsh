function rclone-tree(){
  local rcloneRemote depth rcloneRemoteV inputrcloneRemote verifyrcloneRemotelist
  [[ -z ${commands[rclone]} ]] \
    && printf "Cannot find command 'rclone'\n" \
    && return 1

  rcloneRemote="${1}"

  [[ -n $2 ]] && depth=$2 || depth=3


  _rclone_tree_help(){ cat <<RCLONETREEHELP

USAGE:

  rclone-tree [remote name] [recursion depth]


OPTIONS:

  -h, --help       Show this help menu

RCLONETREEHELP
}
  if [[ $1 == "-h" ]] || [[ $1 == "--help" ]] || [[ $2 == "-h" ]] || [[ $2 == "--help" ]]; then
    _rclone_tree_help
    return
  fi

  if [[ -z "${rcloneRemote}" ]]; then
    printf "\x1B[0;38;5;190mNo remote specified...\x1B[0m\t\x1B[0;3;38;5;8mFinding one...\t\n"
    rcloneRemoteV="$(rclone listremotes | head -n 1 | sed -e 's/:$//g')"

    if [[ -z "${rcloneRemoteV}" ]]; then
      printf "\x1B[0;1;38;5;196mUnable to find rclone remote\x1B[0m\t:(\n"
      printf "\x1B[0;38;5;15mYou may need to configure a remote\nTry running this command:\n\n\trclone config\n\n\x1B[0m"
      return 1

    else
      printf "\x1B[0;38;5;15mFound rclone remote:\t\x1B[0;1;4;38;5;46m%s\n" "${rcloneRemoteV}"
    fi
  else
      inputrcloneRemote="$(echo "${rcloneRemote}" | head -n 1 | sed -e 's/:$//g')"
      verifyrcloneRemotelist="$(rclone listremotes)"

      for foundremote in ${verifyrcloneRemotelist[@]}; do
        foundremote_item=$(echo "${foundremote}" | head -n 1 | sed -e 's/:$//g')
        [[ "${inputrcloneRemote}" == "${foundremote_item}" ]] \
          && rcloneRemoteV="${foundremote_item}" \
          && break
      done
      [[ -z "${rcloneRemoteV}" ]] && printf "\x1B[0;1;38;5;196mNot a valid rclone remote:\x1B[0m\t%s\n" "${rcloneRemote}" && return 1

      printf "\x1B[0;38;5;15mVerified rclone remote:\t\x1B[0;1;4;38;5;46m%s\n" "${rcloneRemoteV}"
      printf "\x1B[0;38;5;15mUsing rclone remote:\t\x1B[0;1;4;38;5;46m%s\n" "${rcloneRemoteV}"

  fi
  printf "\x1B[0;38;5;15mGenerating rclone tree on remote: \x1B[0;1;4;38;5;46m%s\x1B[0;38;5;15m ...\x1B[0m " "${rcloneRemoteV}"
  printf "\x1B[0;3;38;5;8mRecursing %s levels\x1B[0m\n" "${depth}"
  rclone tree                 \
    --max-depth "${depth}"    \
    --links                   \
    --modtime                 \
    --size                    \
    --protections             \
    --sort-modtime            \
    --sort-reverse            \
    --progress-terminal-title \
    --color                   \
    "${rcloneRemoteV}:"
}
