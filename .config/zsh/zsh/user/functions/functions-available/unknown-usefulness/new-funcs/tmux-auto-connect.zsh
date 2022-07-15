# this will start new tmux session if you connect remotely; if you want
# to suppress it, just use "TERM=screen ssh user@host" and reset your
# $TERM back to xterm, or launch screen/tmux on local host.
# If we're already in screen or not on ssh connection (local access),
# don't run the rest of the code (shell is secure)
if [[ "$TERM" != "screen" ]] && [[ -n "$SSH_CONNECTION" ]]; then
    if `which tmux`; then
        if tmux -q has-session -t $tmux_session 2> /dev/null ; then
            tmux -q attach-session -t $tmux_session
        else
            tmux -q new-session -s $tmux_session
        fi
    fi
fi
