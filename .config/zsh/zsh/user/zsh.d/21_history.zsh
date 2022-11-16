


# $HISTFILE belongs in the data home, not with the configs
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh-history/history"
[[ ! -f "$HISTFILE" ]] && mkdir -p "$HISTFILE:h" && touch "$HISTFILE"

SAVEHIST=20000
HISTSIZE=100000
export SAVEHIST HISTSIZE

# history.zsh - http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt APPEND_HISTORY          # append to history file
setopt EXTENDED_HISTORY        # write the history file in the ':start:elapsed;command' format
setopt HIST_EXPIRE_DUPS_FIRST  # expire a duplicate event first when trimming history
setopt HIST_FIND_NO_DUPS       # don't display a previously found event
setopt HIST_IGNORE_ALL_DUPS    # delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_DUPS        # don't record an event that was just recorded again
setopt HIST_IGNORE_SPACE       # don't record an event starting with a space
setopt HIST_NO_STORE           # don't store history commands
setopt HIST_REDUCE_BLANKS      # remove superfluous blanks from each command line being added to the history list
setopt HIST_SAVE_NO_DUPS       # don't write a duplicate event to the history file
setopt HIST_VERIFY             # don't execute immediately upon history expansion
setopt INC_APPEND_HISTORY      # write to the history file immediately, not when the shell exits
setopt NO_HIST_BEEP            # don't beep when attempting to access a missing history entry
# setopt NO_SHARE_HISTORY        # don't share history between all sessions
setopt SHARE_HISTORY           # Share history between all sessions

# make the history command more useful
alias history="fc -li"


