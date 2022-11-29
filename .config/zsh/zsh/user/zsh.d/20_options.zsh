# shellcheck disable=2148



##############################
##          OPTIONS         ##
##############################
setopt APPEND_CREATE
setopt APPEND_HISTORY         ## append to history file
setopt AUTO_CD              ## If a command is issued that can't be executed as a normal command, and the command is the name of a di‐ rectory,  perform  the  cd  command  to  that  directory.  This option is only applicable if the option SHIN_STDIN is set, i.e. if commands are being read from standard input.  The option is designed for in‐ teractive use; it is recommended that cd be used explicitly in scripts to avoid ambiguity.
setopt AUTO_CONTINUE
setopt AUTO_PUSHD
setopt CDABLE_VARS
setopt CHECK_JOBS
setopt CHECK_RUNNING_JOBS
setopt COMPLETE_IN_WORD
setopt C_BASES
#setopt CHASE_DOTS           ## Resolve symbolic links to their true values when changing directory.
setopt DEBUG_BEFORE_CMD
setopt EXTENDED_HISTORY       ## write the history file in the ':start:elapsed;command' format
setopt GLOB_COMPLETE
setopt GLOB_DOTS
setopt HIST_EXPIRE_DUPS_FIRST ## expire a duplicate event first when trimming history
# setopt HIST_FIND_NO_DUPS      ## don't display a previously found event
# setopt HIST_IGNORE_ALL_DUPS   ## delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_DUPS       ## don't record an event that was just recorded again
setopt HIST_IGNORE_SPACE      ## don't record an event starting with a space
# setopt HIST_NO_STORE          ## don't store history commands
# setopt HIST_REDUCE_BLANKS     ## remove superfluous blanks from each command line being added to the history list
# setopt HIST_SAVE_NO_DUPS      ## don't write a duplicate event to the history file
setopt HIST_VERIFY            ## don't execute immediately upon history expansion
setopt INC_APPEND_HISTORY     ## write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY          ## Share history between all sessions
setopt INTERACTIVECOMMENTS
setopt INTERACTIVE_COMMENTS
setopt LIST_AMBIGUOUS
setopt LIST_TYPES
setopt LONG_LIST_JOBS
setopt MARK_DIRS
setopt MENUCOMPLETE
setopt MONITOR
setopt NOTIFY
setopt NO_CLOBBER
setopt NO_HIST_BEEP           ## don't beep when attempting to access a missing history entry
setopt NO_HUP
setopt NUMERIC_GLOB_SORT
setopt OCTAL_ZEROES
setopt PRINT_EXIT_VALUE
#setopt PUSHD_IGNORE_DUPS
setopt RM_STAR_WAIT
setopt TRANSIENT_RPROMPT
setopt VI
# setopt WARN_CREATE_GLOBAL
setopt ZLE
