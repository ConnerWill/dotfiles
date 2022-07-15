### Export this path
# export ZSH_OPTIONS_DIR="$ZDOTDIR/options"

################################
##          OPTIONS
################################
setopt VI
setopt INTERACTIVECOMMENTS                ## COMMENTS
setopt GLOB_DOTS                ## COMMENTS
setopt NUMERIC_GLOB_SORT
setopt MENUCOMPLETE                ## COMMENTS
setopt NO_CLOBBER
setopt APPEND_CREATE
setopt LIST_TYPES
setopt MARK_DIRS
setopt RM_STAR_WAIT
setopt MONITOR
setopt NOTIFY
setopt TRANSIENT_RPROMPT
setopt PRINT_EXIT_VALUE
setopt CHECK_JOBS
setopt CHECK_RUNNING_JOBS
setopt LONG_LIST_JOBS
setopt AUTO_PUSHD
setopt CDABLE_VARS
setopt COMPLETE_IN_WORD
setopt GLOB_COMPLETE
setopt LIST_AMBIGUOUS
setopt LIST_TYPES
setopt GLOB_DOTS
setopt MARK_DIRS
setopt EXTENDED_HISTORY
setopt INTERACTIVE_COMMENTS
setopt AUTO_CONTINUE
setopt LONG_LIST_JOBS
setopt MONITOR
setopt NOTIFY
setopt C_BASES
setopt OCTAL_ZEROES
setopt DEBUG_BEFORE_CMD
setopt VI
setopt ZLE
# setopt WARN_CREATE_GLOBAL
# setopt AUTO_CD
# history.zsh - http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt append_history          # append to history file
setopt extended_history        # write the history file in the ':start:elapsed;command' format
setopt no_hist_beep            # don't beep when attempting to access a missing history entry
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups       # don't display a previously found event
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt hist_verify             # don't execute immediately upon history expansion
setopt inc_append_history      # write to the history file immediately, not when the shell exits
setopt no_share_history        # don't share history between all sessions

# $HISTFILE belongs in the data home, not with the configs
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh-history/history"
[[ ! -f "$HISTFILE" ]] \
  && mkdir -p "$HISTFILE:h" \
  && touch "$HISTFILE"

# you can set $SAVEHIST and $HISTSIZE to anything greater than the ZSH defaults
# (1000 and 2000 respectively), but if not we make them way bigger.
[[ $SAVEHIST -gt 1000 ]] || SAVEHIST=20000
[[ $HISTSIZE -gt 2000 ]] || HISTSIZE=100000

# make the history command more useful
alias history="fc -li"

### Show configured ZSH options
# [[ -f "$ZSH_OPTIONS_DIR/show-zsh-option-status.zsh" ]] \
  # && source "$ZSH_OPTIONS_DIR/show-zsh-option-status.zsh"
###################################################################
###################################################################
###################################################################
#                Resolve symbolic links to their true values when changing directory.  This also has  the
#              effect of CHASE_DOTS, i.e. a `..' path segment will be treated as referring to the phys‐
#              ical parent, even if the preceding path segment is a symbolic link.

