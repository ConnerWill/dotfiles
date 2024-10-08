#shellcheck disable=2148

# # this will start new tmux session if you connect remotely; if you want
# # to suppress it, just use "TERM=screen ssh user@host" and reset your
# # $TERM back to xterm, or launch screen/tmux on local host.
# # If we're already in screen or not on ssh connection (local access),
# # don't run the rest of the code (shell is secure)
# if [[ "${TERM}" != "screen" ]] && [[ -n "${SSH_CONNECTION}" ]]; then
#   tmux_command="$(command -v tmux)"
#   if [[ -n "${tmux_command}" ]] ; then
#     if tmux -q has-session -t "${tmux_session}" 2> /dev/null; then
#       tmux -q attach-session -t "${tmux_session}"
#     else
#       tmux -q new-session -s "${tmux_session}"
#     fi
#   fi
# fi

## Check if SSH dir and files exist, otherwise this will show a warning for zcomp
[[ -d "${HOME}/.ssh" ]]             || mkdir "${HOME}/.ssh"
[[ -f "${HOME}/.ssh/known_hosts" ]] || touch "${HOME}/.ssh/known_hosts"
[[ -f "${HOME}/.ssh/config" ]]      || touch "${HOME}/.ssh/config"
