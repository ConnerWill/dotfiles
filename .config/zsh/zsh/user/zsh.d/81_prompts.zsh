### [=========================================]
### [ ---------------- PROMPT --------------- ]
### [=========================================]
## CHECK TERMINAL SUPPORTS 256 colors, if not, load zshmodule "zsh/nearcolor"
## The zsh/nearcolor module replaces colours specified as hex triplets with the nearest 
## colour in the 88 or 256 colour palettes that are widely used by terminal emulators.
autoload -U promptinit ; promptinit
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
setopt PROMPT_SUBST

### ZSH PROMPTS
PROMPT_OPEN_BRACKETS='%F{51}%B[%b%f'
PROMPT_CLOSE_BRACKETS='%F{51}%B]%b%f'
PROMPTHOSTNAME='%F{99}%m%f'
PROMPTUSERNAME='%F{99}%n%f'
PROMPTPATH='%F{66}%40<..<%~%<<'
PROMPTDELIMITER=$'%{\e[$((color=$((30+$RANDOM % 8))))m%}:%{\e[00m%} ' # Random color delimiter ':'

function _rprompt_set_ssh(){
  ### SET RIGHT PROMPT TO DISPLAY VALUE OF '$SSH_CLIENT' IF CONNECTED OVER SSH
  if [[ "$SSH_CLIENT" = *.* || "$REMOTEHOST" = *.* ]]; then
    setopt TRANSIENT_RPROMPT
    local RPROMPT_SSH_COLOR RPROMPT_SSH_COLOR_RESET RPROMPT_SSH
    RPROMPT_SSH_COLOR='%F{237}'
    RPROMPT_SSH_COLOR_RESET='%f'
    RPROMPT_SSH='${RPROMPT_SSH_COLOR}${SSH_CLIENT}${RPROMPT_SSH_COLOR_RESET}'
    RPROMPT='${RPROMPT_SSH}'
    RPS1='${RPROMPT}'
    export RPROMPT RPS1
  fi
}
_rprompt_set_ssh

### [===============================]
### [ --------- GIT PROMPT -------- ]
### [===============================]
#   ### USE 'vcs_info_printsys' TO LIST VCS BACKENDS
# function _prompt_set_git(){
#   setopt PROMPT_SUBST ;             autoload -Uz vcs_info
#   zstyle ':vcs_info:*'              disable bzr cdv darcs mtn svk tla
#   zstyle ':vcs_info:*'              actionformats '%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f%r '
#   zstyle ':vcs_info:*'              formats       '%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
#   zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat  '%b%F{1}:%F{3}%r'
#   precmd () { vcs_info }
# }
# _prompt_set_git
# _VCS_INFO_PROMPT='${vcs_info_msg_0_}'
# GITPROMPT="$vcs_info_msg_0_"
#
# PROMPT_FULL="$PROMPT_OPEN_BRACKETS$PROMPTUSERNAME$PROMPT_CLOSE_BRACKETS$PROMPT_OPEN_BRACKETS$PROMPTPATH$PROMPT_CLOSE_BRACKETS$_VCS_INFO_PROMPT$PROMPTDELIMITER"
# export PS1="$PROMPT_FULL"
# export PROMPT="$PROMPT_FULL"
#

### VCS PROMPT OPTIONS ### {{{

#       %s     The VCS in use (git, hg, svn, etc.).
#       %b     Information about the current branch.
#       %a     An identifier that describes the action. Only makes sense in actionformats.
#       %i     The current revision number or identifier. For hg the hgrevformat style may be used to customize the output.
#       %c     The string from the stagedstr style if there are staged changes in the repository.
#       %u     The string from the unstagedstr style if there are unstaged changes in the repository.
#       %R     The base directory of the repository.
#       %r     The repository name. If %R is /foo/bar/repoXY, %r is repoXY.
#       %S     A subdirectory within a repository. If $PWD is /foo/bar/repoXY/beer/tasty, %S is beer/tasty.
#       %m     A "misc" replacement. It is at the discretion of the backend to decide what this replacement expands to.
#       %Q     Quilt  series  information.  When quilt is used (either in `addon' mode or as a `standalone' backend), this expando is set to quilt series' patch-format string.  The set-patch-format hook and

##  In branchformat these replacements are done:
#       %b     The branch name.
#       %r     The current revision number or the hgrevformat style for hg.

##  In hgrevformat these replacements are done:
#       %r     The current local revision number.
#       %h     The current global revision identifier.
#
##  In patch-format and nopatch-format these replacements are done:
#       %p     The name of the top-most applied patch; may be overridden by the applied-string hook.
#       %u     The number of unapplied patches; may be overridden by the unapplied-string hook.
#       %n     The number of applied patches.
#       %c     The number of unapplied patches.
#       %a     The number of all patches (%a = %n + %c).
#       %g     The names of active mq guards (hg backend).

## source "$ZDOTDIR/themes-prompts/DEMOPROMPT.zsh"
#### ADD SECTION TO CHECK IF VERBOSE PRINT IS ON, THEN RUN COMMAND BELOW:
    #   echo "Loading: $(basename $ZSH_HIGHLIGHTING_PLUGIN)"
### No Hostname in Prompt
##########################
    #   user ~/Documents %
    #   $USERNAME ~/$PWD %
    #   {magenta}$USERNAME {white}~/$PWD {blue}%

#function _zsh_prompt_gitstatus(){
#    local git_prompt_path="/usr/share/gitstatus/gitstatus.prompt.zsh"
#    [[ -f "$gitstatus_prompt_path" ]] && source "$gitstatus_prompt_path"
#}
#_zsh_prompt_gitstatus
#export PROMPT='%F{51}%B[%b%f%B%F{99}%n%f%b%F{51}%B]%b%f%F{51}%B[%b%f%F{66}%40<..<%~%<<%F{51}%B]%b%f%u${vcs_info_msg_0_}%B%F{76}:%b%f '
#export PROMPT='%F{51}%B[%b%f%B%F{99}%n%f%b%F{51}%B]%b%f%F{51}%B[%b%f%F{66}%40<..<%~%<<%F{51}%B]%b%f%u%f%B%F{76}:%b%f '
#PROMPT_FULL="$PROMPT_OPEN_BRACKETS$PROMPTHOSTNAME$PROMPT_CLOSE_BRACKETS$PROMPT_OPEN_BRACKETS$PROMPTUSERNAME$PROMPT_CLOSE_BRACKETS$PROMPT_OPEN_BRACKETS$PROMPTPATH$PROMPT_CLOSE_BRACKETS$PROMPTDELIMITER"
#export PROMPT='%F{51}%B[%b%f%B%F{99}%n%f%b%F{51}%B]%b%f%F{51}%B[%b%f%F{66}%40<..<%~%<<%F{51}%B]%b%f%u${vcs_info_msg_0_}%B%F{76}:%b%f '
#echo "🌑              🌑"

### }}}
