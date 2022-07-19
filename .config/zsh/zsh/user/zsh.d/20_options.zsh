# shellcheck disable=2148
##############################
##          OPTIONS         ##
##############################
setopt APPEND_CREATE        ##
#setopt AUTO_CD             ## If a command is issued that can't be executed as a normal command, and the command is the name of a di‐ rectory,  perform  the  cd  command  to  that  directory.  This option is only applicable if the option SHIN_STDIN is set, i.e. if commands are being read from standard input.  The option is designed for in‐ teractive use; it is recommended that cd be used explicitly in scripts to avoid ambiguity.
setopt AUTO_CONTINUE        ##
setopt AUTO_PUSHD           ##
setopt CDABLE_VARS          ##
setopt CHECK_JOBS           ##
setopt CHECK_RUNNING_JOBS   ##
setopt COMPLETE_IN_WORD     ##
setopt C_BASES              ##
#setopt CHASE_DOTS          ## Resolve symbolic links to their true values when changing directory.
setopt DEBUG_BEFORE_CMD     ##
setopt GLOB_COMPLETE        ##
setopt GLOB_DOTS            ##
setopt GLOB_DOTS            ##
setopt INTERACTIVECOMMENTS  ##
setopt INTERACTIVE_COMMENTS ##
setopt LIST_AMBIGUOUS       ##
setopt LIST_TYPES           ##
setopt LIST_TYPES           ##
setopt LONG_LIST_JOBS       ##
setopt LONG_LIST_JOBS       ##
setopt MARK_DIRS            ##
setopt MARK_DIRS            ##
setopt MENUCOMPLETE         ##
setopt MONITOR              ##
setopt MONITOR              ##
setopt NOTIFY               ##
setopt NOTIFY               ##
setopt NO_CLOBBER           ##
setopt NUMERIC_GLOB_SORT    ##
setopt OCTAL_ZEROES         ##
setopt PRINT_EXIT_VALUE     ##
setopt RM_STAR_WAIT         ##
setopt TRANSIENT_RPROMPT    ##
setopt VI                   ##
setopt VI                   ##
#setopt WARN_CREATE_GLOBAL  ##
setopt ZLE                  ##

# history.zsh - http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY          # append to history file
setopt EXTENDED_HISTORY        # write the history file in the ':start:elapsed;command' format
setopt NO_HIST_BEEP            # don't beep when attempting to access a missing history entry
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
setopt NO_SHARE_HISTORY        # don't share history between all sessions

# This also has the effect of CHASE_DOTS,
#
#   ( i.e. a `..' path segment will be treated as referring 
#     to the physical parent, even if the preceding path
#     segment is a symbolic link. )
###################################################################
### Show configured ZSH options {{{
# [[ -f "$ZSH_OPTIONS_DIR/show-zsh-option-status.zsh" ]] \
  # && source "$ZSH_OPTIONS_DIR/show-zsh-option-status.zsh"
###}}}
###################################################################
###################################################################


