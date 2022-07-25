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
setopt INTERACTIVECOMMENTS  ##
setopt INTERACTIVE_COMMENTS ##
setopt LIST_AMBIGUOUS       ##
setopt LIST_TYPES           ##
setopt LONG_LIST_JOBS       ##
setopt MARK_DIRS            ##
setopt MENUCOMPLETE         ##
setopt MONITOR              ##
setopt NOTIFY               ##
setopt NO_CLOBBER           ##
setopt NUMERIC_GLOB_SORT    ##
setopt OCTAL_ZEROES         ##
setopt PRINT_EXIT_VALUE     ##
setopt RM_STAR_WAIT         ##
setopt TRANSIENT_RPROMPT    ##
setopt VI                   ##
# setopt WARN_CREATE_GLOBAL  ##
setopt ZLE                  ##

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


