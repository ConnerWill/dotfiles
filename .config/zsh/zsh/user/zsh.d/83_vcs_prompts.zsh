# shellcheck disable=2148,2016,2182
### [=========================================]
### [ ---------------- PROMPT --------------- ]
### [=========================================]
### ???{{{
# ------------------------------------------------------------------
# # Parent dir of highlighting plugin dir
# ZSH_HIGHLIGHTING_PLUGIN_DIR="$ZSH_CUSTOM_PROMPTS_THEMES_DIR/highlighting/highlighting-plugins"
# # Parent dir and name of highlighting plugin
# ZSH_HIGHLIGHTING_PLUGIN_NAME="fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
# # Combine path to highlighting plugin (you can also replace this with the full path to plugin
# ZSH_HIGHLIGHTING_PLUGIN="$ZSH_HIGHLIGHTING_PLUGIN_DIR/$ZSH_HIGHLIGHTING_PLUGIN_NAME"
#### CHECK TERMINAL SUPPORTS 256 colors, if not, load zshmodule "zsh/nearcolor"
 #   The zsh/nearcolor module replaces colours specified as
 #   hex triplets with the nearest colour in the 88 or 256 colour
 #   palettes that are widely used by terminal emulators.
 #echo "🌑              🌑"
# ------------------------------------------------------------------
### }}}

### [===============================]
### [ ------- SETUP PROMPT -------- ]
### [===============================]
### {{{ SETUP PROMPT
# ------------------------------------------------------------------
autoload -U promptinit
promptinit
setopt prompt_subst
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
# ------------------------------------------------------------------
### SETUP PROMPT }}}

### [===============================]
### [ ---------- PROMPT ----------- ]
### [===============================]
### {{{ STANDARD PROMPT
# ------------------------------------------------------------------
  PROMPT_OPEN_BRACKETS='%F{51}%B[%b%f'
 PROMPT_CLOSE_BRACKETS='%F{51}%B]%b%f'
        PROMPTUSERNAME='%F{99}%n%f'
        # PROMPTATSYMBOL='%F{201}@%f'
        # PROMPTHOSTNAME='%F{99}%m%f'

      PROMPTDELIMITER=$'%{\e[$((color=$((30+$RANDOM % 8))))m%}:%{\e[00m%} '
# ------------------------------------------------------------------
### STANDARD PROMPT }}}


### [=========================================]
### [ ---------- EXIT CODE PROMPT ----------- ]
### [=========================================]
### {{{ EXIT CODE PROMPT
# ------------------------------------------------------------------
setopt prompt_subst

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    # shellcheck disable=2148,2016,2182,1087,2154
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    # shellcheck disable=2148,2016,2182,1087,2154
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    # shellcheck disable=2148,2016,2182,1087,2154
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    export EXIT_CODE_PROMPT
  else
    unset EXIT_CODE_PROMPT
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd check_last_exit_code
# ------------------------------------------------------------------
### EXIT CODE PROMPT }}}

# set RPROMT directly. Will override other functions where it gets set
# add-zsh-hook chpwd check_last_exit_code

### [===============================]
### [ --------- GIT PROMPT -------- ]
### [===============================]
### {{{ GIT PROMPT
##--------------------------------------------------
### {{{ GIT PROMPT DOCUMENTATION/REFERENCE
##--------------------------------------------------
## VCS PROMPT OPTIONS ###
#     %s     The VCS in use (git, hg, svn, etc.).
#     %b     Information about the current branch.
#     %a     An identifier that describes the action. Only makes sense in actionformats.
#     %i     The current revision number or identifier. For hg the hgrevformat style may be used to customize the output.
#     %c     The string from the stagedstr style if there are staged changes in the repository.
#     %u     The string from the unstagedstr style if there are unstaged changes in the repository.
#     %R     The base directory of the repository.
#     %r     The repository name. If %R is /foo/bar/repoXY, %r is repoXY.
#     %S     A subdirectory within a repository. If $PWD is /foo/bar/repoXY/beer/tasty, %S is beer/tasty.
#     %m     A "misc" replacement. It is at the discretion of the backend to decide what this replacement expands to.
#     %Q     Quilt  series  information.  When quilt is used (either in `addon' mode or as a `standalone' backend), this expando is set to quilt series' patch-format string.  The set-patch-format hook and
# In branchformat these replacements are done:
#     %b     The branch name.
#     %r     The current revision number or the hgrevformat style for hg.
# In hgrevformat these replacements are done:
#     %r     The current local revision number.
#     %h     The current global revision identifier.
# In patch-format and nopatch-format these replacements are done:
#     %p     The name of the top-most applied patch; may be overridden by the applied-string hook.
#     %u     The number of unapplied patches; may be overridden by the unapplied-string hook.
#     %n     The number of applied patches.
#     %c     The number of unapplied patches.
#     %a     The number of all patches (%a = %n + %c).
#     %g     The names of active mq guards (hg backend).
##--------------------------------------------------
### }}} GIT PROMPT DOCUMENTATION/REFERENCE
##--------------------------------------------------
### Shows state of the Versioning Control System (e.g. Git, Subversion, Mercurial ------------------------------------------------------------------

function _prompt_set_git(){
  setopt PROMPT_SUBST
  # is_in_git_repository && PROMPTPATH='' || return 1
  autoload -Uz vcs_info
  zstyle ':vcs_info:*'              disable bzr cdv darcs mtn svk tla
  # zstyle ':vcs_info:*'              actionformats '%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f%r'
  #zstyle ':vcs_info:*'              formats       '%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f'
  zstyle ':vcs_info:*'              formats       '%f%F{190}:%f%F{5}(%f%F{15}%r%f%F{5})%f'
 zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat  '%b%F{1}:%F{3}%r'
  precmd () {
    vcs_info
  }
}
_prompt_set_git
#


###
# Print a formatted gitstatus prompt to stdout
# Options:  -i  add a whitespace at the end, if the output isn't empty
###
function gitstatus(){
  if is_in_git_repository; then
  unset PROMPT_PATH
  unset PROMPTPATH
  typeset -g PROMPTPATH
  typeset -g PROMPT_PATH
  else
    typeset -g PROMPTPATH='%F{66}%40<..<%~%<<'
    return 1
  fi
  # PROMPTPATH='%F{66}%40<..<%~%<<'
  local \
    icon_commits_behind="↓" \
     icon_commits_ahead="↓" \
            icon_branch="" \
          icon_modified="${modified}" \
            icon_staged="${staged}"   \
           icon_deleted="${deleted}"  \
         icon_untracked="﬒${untracked}"
      openbracket="%f%F{5}[%f" \
      closebracket="%f%F{5}]%f" \
      dash="%f%F{190}-%f" \
      color_reset="%f%b%u%k"
            # icon_branch="" \
  local \
       commit_diffs \
        true_output \
          untracked \
           modified \
            deleted \
             staged \
             branch \
             remote \
             output \
              color \

    parse_git_status
    modified="${STATUS[1]}"
    staged="${STATUS[2]}"
    deleted="${STATUS[3]}"
    untracked="${STATUS[4]}"
    unset STATUS

    git_grab_current_branch
    branch="${REPLY}"

    git_grab_remote_branch
    remote="${REPLY}"

    [[ -n "$remote" ]] \
        && git_local_remote_diffs "$branch" "$remote" \
        && commit_diffs="$REPLY"

    git_determine_color $((modified + staged + deleted + untracked))
    color="${REPLY}"

    (( modified > 0 ))  && modified="${icon_modified}${modified}"
    (( staged > 0 ))    && staged="${icon_staged}${staged}"
    (( deleted > 0 ))   && deleted="${icon_deleted}${deleted}"
    (( untracked > 0 )) && untracked="${icon_untracked}${untracked}"

      output="${dash}"
      output+="${openbracket}"
       output+="${color}"
      output+="${icon_branch}${branch}"
      output+="${commit_diffs}"
      output+="${modified}"
      output+="${staged}"
      output+="${deleted}"
      output+="${untracked}"
      output+="${color_reset}${closebracket}"
 true_output="${output//[ \t]*$/}" # remove trailing whitespace
 # true_output="$(sed 's/[ \t]*$//' <<<"${output}")" # remove trailing whitespace

    if [[ "$1" == "-i" ]]; then
        true_output+=""
    fi

    true_output+=$'%F{default}'
    echo "${true_output}"
    unset REPLY
}

###
# Check if we're in a git repository
# Arguments:    none
# Returns:      0 if in a git repo, 1 otherwise
###
function is_in_git_repository(){
    git rev-parse --git-dir &>/dev/null || return 1
}

###
# Return current branch we're on
# Arguments:    none
###
function git_grab_current_branch(){
  typeset -g REPLY
  REPLY="$(git branch --show-current)"
}

###
# Return remote branch that the local one is tracking
# Arguemnts: none
###
function git_grab_remote_branch(){
    local symbolic_ref
    typeset -g REPLY
    symbolic_ref="$(git symbolic-ref -q HEAD)"
    REPLY="$(git for-each-ref --format='%(upstream:short)' "${symbolic_ref}")"
}

###
# Find how many things have changed since last git commit
# Arguments:    none
###
function parse_git_status(){
  git status --porcelain=v1 | while IFS= read -r status_line; do
      case "$status_line" in
          ' M '*)
              ((modified++))
              ;;
          'A  '*|'M '*)
              ((staged++))
              ;;
          'D  '*|' D '*)
              ((deleted++))
              ;;
          '?? '*)
              ((untracked++))
              ;;
          'MM '*|'AM '*)
              ((staged++))
              ((modified++))
              ;;
          'R '*)
              ((staged++))
              ((deleted++))
              ;;
      esac
  done
  typeset -g STATUS
  STATUS=("${modified}" "${staged}" "${deleted}" "${untracked}")
  return 0
}

###
# Look at how many commits a local branch is ahead/behind of remote branch
# Arguments:    $1 local branch
#               $2 remote branch
###
function git_local_remote_diffs(){
  local            \
    local_branch   \
    remote_branch  \
    differences    \
    commits_ahead  \
    commits_behind \
    ahead          \
    behind         \
    result         \

      local_branch="$1"
     remote_branch="$2"

       differences="$(git rev-list --left-right --count ${local_branch}...${remote_branch})"
     commits_ahead=$(echo -n "${differences}" | awk '{print $1}')
    commits_behind=$(echo -n "${differences}" | awk '{print $2}')
             ahead=""
            behind=""
            result=""

    (( $commits_ahead > 0 )) \
        && ahead="${icon_commits_ahead}${commits_ahead}"
    (( $commits_behind > 0 )) \
        && behind="${icon_commits_behind}${commits_behind}"

    if [[ -n "${ahead}" ]]; then
        result="${ahead}"
    fi

    if [[ -n "${behind}" ]]; then
        result="${behind}"
    fi

    typeset -g REPLY="${result}"
}

###
# If there is anything that changed from the past commit, return yellow.
# Otherwise, green.
# Arguments:    list of how many things changed
###
function git_determine_color(){
    if (( $1 > 0 )); then
        typeset -g REPLY=$'%F{2}%B'
    else
        typeset -g REPLY=$'%F{green}'
    fi
}

#shellcheck disable=2016
_VCS_INFO_PROMPT='${vcs_info_msg_0_}$(gitstatus -i)'
       # shellcheck disable=2154,2034
       GITPROMPT="{$vcs_info_msg_0_}"





# ------------------------------------------------------------------
### GIT PROMPT }}}


### [===============================]
### [ ------ KUBECTL PROMPT ------- ]
### [===============================]
### {{{ KUBECTL PROMPT
# ------------------------------------------------------------------
## Uncomment to enable kubectl prompt
#KUBECTL_PROMPT_ENABLE=true
if [[ -n "${KUBECTL_PROMPT_ENABLE}" ]]; then
  function kubectl_prompt_setup(){
    command -v kube_ps1 >/dev/null 2>&1 || return 1
  ###{{{ kubctl_ps1 Docs
  # The default settings can be overridden in ~/.bashrc or ~/.zshrc by setting
  # the following environment variables:
  ###}}}
  ###{{{ kubectl_ps1 Env Vars
  # KUBE_PS1_BINARY 	kubectl 	Default Kubernetes binary
  # KUBE_PS1_NS_ENABLE 	true 	Display the namespace. If set to false, this will also disable KUBE_PS1_DIVIDER
  # KUBE_PS1_PREFIX 	( 	Prompt opening character
  # KUBE_PS1_SYMBOL_ENABLE 	true 	Display the prompt Symbol. If set to false, this will also disable KUBE_PS1_SEPARATOR
  # KUBE_PS1_SYMBOL_PADDING 	false 	Adds a space (padding) after the symbol to prevent clobbering prompt characters
  # KUBE_PS1_SYMBOL_DEFAULT 	⎈ 	Default prompt symbol. Unicode \u2388
  # KUBE_PS1_SYMBOL_USE_IMG 	false 	☸️ , Unicode \u2638 as the prompt symbol
  # KUBE_PS1_SEPARATOR 	| 	Separator between symbol and context name
  # KUBE_PS1_DIVIDER 	: 	Separator between context and namespace
  # KUBE_PS1_SUFFIX 	) 	Prompt closing character
  # KUBE_PS1_CLUSTER_FUNCTION 	No default, must be user supplied 	Function to customize how cluster is displayed
  # KUBE_PS1_NAMESPACE_FUNCTION 	No default, must be user supplied 	Function to customize how namespace is displayed
  # KUBE_PS1_PREFIX_COLOR 	null 	Set default color of the prompt prefix
  # KUBE_PS1_SYMBOL_COLOR 	blue 	Set default color of the Kubernetes symbol
  # KUBE_PS1_CTX_COLOR 	red 	Set default color of the context
  # KUBE_PS1_SUFFIX_COLOR 	null 	Set default color of the prompt suffix
  # KUBE_PS1_NS_COLOR 	cyan 	Set default color of the namespace
  # KUBE_PS1_BG_COLOR 	null 	Set default color of the prompt background
  ###}}}
  }
  command -v kubectl >/dev/null 2>&1 && kubectl_prompt_setup
fi
# ------------------------------------------------------------------
### KUBECTL PROMPT }}}i


### [===============================]
### [ ---------- PROMPT ----------- ]
### [===============================]
### {{{ PUT IT ALL TOGETHER
# ------------------------------------------------------------------
function define_combine_prompt(){
  # [[ -n "${GITPROMPT}" ]] && PROMPTPATH='$(gitstatus -i)'
  # if is_in_git_repository; then
  # unset PROMPT_PATH
  # unset PROMPTPATH
  # else
  #   PROMPTPATH='%F{66}%40<..<%~%<<'
  # fi



      PROMPT_USER_HOST="$PROMPT_OPEN_BRACKETS$PROMPTUSERNAME$PROMPTATSYMBOL$PROMPTHOSTNAME$PROMPT_CLOSE_BRACKETS"
      PROMPT_USER_HOST="$PROMPT_OPEN_BRACKETS$PROMPTUSERNAME$PROMPT_CLOSE_BRACKETS"
           PROMPT_PATH="$PROMPT_OPEN_BRACKETS$PROMPTPATH$PROMPT_CLOSE_BRACKETS"
 PROMPT_USER_HOST_PATH="$PROMPT_USER_HOST$PROMPT_PATH"
 PROMPT_EXIT_CODE='$EXIT_CODE_PROMPT'

           PROMPT_FULL="$PROMPT_EXIT_CODE$PROMPT_USER_HOST_PATH$_VCS_INFO_PROMPT$PROMPTDELIMITER"
  PROMPT="$PROMPT_FULL"
     PS1="$PROMPT_FULL"
    export PROMPT PS1
}
if define_combine_prompt; then
  unfunction define_combine_prompt
else
  printf "\e[0;1;38;5;196mError whilst loading prompt :,(\t\e[0;1;38;5;8mUsing a default prompt instead ;)\n"
    if autoload -Uz promptinit && promptinit; then
      if autoload -Uz colors && colors; then
        prompt fire blue magenta blue black green cyan
      else
        prompt adam2
      fi
    else
      printf "\e[0;1;38;5;196m The backup prompt failed to load ... >:(\e[0;1;38;5;201m\n\n\tWell... you are on your own now, buddy :0\n" \
      export PROMPT='%F{196}(╯°□°）╯︵ ┻━┻%f %F{93}[>:%f ' \
      export RPROMPT='%F{87}(⌐■_■)%f  %F{46}¯\_(ツ)_/¯%f'
    fi
fi




# ------------------------------------------------------------------
# ------------------------------------------------------------------
### PUT IT ALL TOGETHER }}}

#######################################################
#######################################################
### {{{ DISABLED VCS PROMPTS
### {{{ Previous vcs prompt
## function _prompt_set_git(){
##   autoload -Uz vcs_info ; setopt PROMPT_SUBST
##   zstyle ':vcs_info:*'             disable bzr cdv darcs mtn svk tla ### USE 'vcs_info_printsys' TO LIST VCS BACKENDS
##   zstyle ':vcs_info:*'             actionformats '%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f%r '
##   zstyle ':vcs_info:*'                   formats '%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
##   zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
##   precmd () { vcs_info }
## }
## _prompt_set_git
### }}}
### DISABLED VCS PROMPTS ### {{{
# zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f%r '
# PROMPT_FULL="$PROMPT_OPEN_BRACKETS$PROMPTUSERNAME$PROMPT_CLOSE_BRACKETS$PROMPT_OPEN_BRACKETS$PROMPTPATH$NEW_GIT_PROMPT$PROMPT_CLOSE_BRACKETS$PROMPTDELIMITER"
# PS1="$PROMPT_FULL"
# PROMPT="$PROMPT_FULL" # }
# # function _prompt_set_git(){
#   autoload -Uz vcs_info
#   setopt PROMPT_SUBST
#   ### USE 'vcs_info_printsys' TO LIST VCS BACKENDS
#   # zstyle ':vcs_info:*' action    formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f%r '
#   zstyle ':vcs_info:*'            disable bzr cdv darcs mtn svk tla
#   zstyle ':vcs_info:*'            enable git svn hg
#   zstyle ':vcs_info:*'           check-for-changes true
#   zstyle ':vcs_info:*'               actionformats '%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f%r '
#   zstyle ':vcs_info:*'                    formats  '%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
#   zstyle ':vcs_info:*'                  stagedstr  '%F{green}●%f'
#   zstyle ':vcs_info:*'                unstagedstr  '%F{yellow}●%f'
#   zstyle ':vcs_info:(git):*'         patch-format  '%F{46}%B%n%b%f'
#   zstyle ':vcs_info:(git):*'       nopatch-format  '%F{196}%B%c%b%f'
#   zstyle ':vcs_info:(sv[nk]|bzr):*' branch format  '%b%F{1}:%F{3}%r'
#   zstyle ':vcs_info:(sv[nk]|bzr):*' branch format  '%b%F{red}:%f%F{yellow}%r%f'
#   precmd(){
#     [[ -z "$(git ls-files --other --exclude-standard 2> /dev/null)" ]] \
#       && export PROMPTPATH="" \
#       && unset PROMPTPATH \
#       && zstyle ':vcs_info:*' formats '%b%c%u%' \
#       || zstyle ':vcs_info:*' formats '%b%c%u%F{red}●%f' \
#       || unset PROMPTPATH \
#       || export PROMPTPATH=""
#       vcs_info
#   } # precmd () { vcs_info }
# }
# ### Detects the VCS and shows the appropriate sign
# function prompt_char {
#     git branch >/dev/null 2>/dev/null && echo '±' && return
#     hg root >/dev/null 2>/dev/null && echo '☿' && return
#     svn info >/dev/null 2>/dev/null && echo '⚡' && return
#     #echo '%#'
# }
#
# ### Needed for a pretty prompt
# setopt prompt_subst # Enables additional prompt extentions
# autoload -U colors && colors    # Enables colours
#
# ### My default prompt
# CURRENT_PTY_PROMPT='%F{yellow}%y%f'
# NEW_GIT_PROMPT='${vcs_info_msg_0_}%(!.%F{red}$(prompt_char)%f.$(prompt_char))%{$reset_color%}'
#
# ### My prompt for loops
# PROMPT2='{%_}  '
#
# ### My prompt for selections
# PROMPT3='{ … }  '
#
# ### So far I don't use "setopt xtrace", so I don't need this prompt
# #PROMPT4=''
# #
# # PROMPT_FULL="$PROMPT_OPEN_BRACKETS$PROMPTUSERNAME$PROMPT_CLOSE_BRACKETS$PROMPT_OPEN_BRACKETS$PROMPTPATH$PROMPT_CLOSE_BRACKETS$_VCS_INFO_PROMPT$NEW_GIT_PROMPT$PROMPTDELIMITER"
# # PS1="$PROMPT_FULL"
# # PROMPT="$PROMPT_FULL" # }
# #
# _prompt_set_git
# _VCS_INFO_PROMPT='${vcs_info_msg_0_}'
# GITPROMPT="$vcs_info_msg_0_"
#
# PROMPT_FULL="$PROMPT_OPEN_BRACKETS$PROMPTUSERNAME$PROMPT_CLOSE_BRACKETS$PROMPT_OPEN_BRACKETS$PROMPTPATH$PROMPT_CLOSE_BRACKETS$_VCS_INFO_PROMPT$PROMPTDELIMITER"
# export PS1="$PROMPT_FULL" ; export PROMPT="$PROMPT_FULL"
# VCS PROMPT OPTIONS ###
#     %s     The VCS in use (git, hg, svn, etc.).
#     %b     Information about the current branch.
#     %a     An identifier that describes the action. Only makes sense in actionformats.
#     %i     The current revision number or identifier. For hg the hgrevformat style may be used to customize the output.
#     %c     The string from the stagedstr style if there are staged changes in the repository.
#     %u     The string from the unstagedstr style if there are unstaged changes in the repository.
#     %R     The base directory of the repository.
#     %r     The repository name. If %R is /foo/bar/repoXY, %r is repoXY.
#     %S     A subdirectory within a repository. If $PWD is /foo/bar/repoXY/beer/tasty, %S is beer/tasty.
#     %m     A "misc" replacement. It is at the discretion of the backend to decide what this replacement expands to.
#     %Q     Quilt  series  information.  When quilt is used (either in `addon' mode or as a `standalone' backend), this expando is set to quilt series' patch-format string.  The set-patch-format hook and
# In branchformat these replacements are done:
#     %b     The branch name.
#     %r     The current revision number or the hgrevformat style for hg.
# In hgrevformat these replacements are done:
#     %r     The current local revision number.
#     %h     The current global revision identifier.
# In patch-format and nopatch-format these replacements are done:
#     %p     The name of the top-most applied patch; may be overridden by the applied-string hook.
#     %u     The number of unapplied patches; may be overridden by the unapplied-string hook.
#     %n     The number of applied patches.
#     %c     The number of unapplied patches.
#     %a     The number of all patches (%a = %n + %c).
#     %g     The names of active mq guards (hg backend).
##--------------------------------------------------
### Shows state of the Versioning Control System (e.g. Git, Subversion, Mercurial

##--------------------------------------------------
## Example: Start gitstatusd, send it a request, wait for response and print it.
##
##   source ~/gitstatus/gitstatus.plugin.zsh
##   gitstatus_start MY
##   gitstatus_query -d $PWD MY
##   typeset -m 'VCS_STATUS_*'
##
## Output:
##
##   VCS_STATUS_ACTION=''
##   VCS_STATUS_COMMIT=c000eddcff0fb38df2d0137efe24d9d2d900f209
##   VCS_STATUS_COMMITS_AHEAD=0
##   VCS_STATUS_COMMITS_BEHIND=0
##   VCS_STATUS_COMMIT_ENCODING=''
##   VCS_STATUS_COMMIT_SUMMARY='pull upstream changes from gitstatus'
##   VCS_STATUS_HAS_CONFLICTED=0
##   VCS_STATUS_HAS_STAGED=0
##   VCS_STATUS_HAS_UNSTAGED=1
##   VCS_STATUS_HAS_UNTRACKED=1
##   VCS_STATUS_INDEX_SIZE=33
##   VCS_STATUS_LOCAL_BRANCH=master
##   VCS_STATUS_NUM_ASSUME_UNCHANGED=0
##   VCS_STATUS_NUM_CONFLICTED=0
##   VCS_STATUS_NUM_STAGED=0
##   VCS_STATUS_NUM_UNSTAGED=1
##   VCS_STATUS_NUM_SKIP_WORKTREE=0
##   VCS_STATUS_NUM_STAGED_NEW=0
##   VCS_STATUS_NUM_STAGED_DELETED=0
##   VCS_STATUS_NUM_UNSTAGED_DELETED=0
##   VCS_STATUS_NUM_UNTRACKED=1
##   VCS_STATUS_PUSH_COMMITS_AHEAD=0
##   VCS_STATUS_PUSH_COMMITS_BEHIND=0
##   VCS_STATUS_PUSH_REMOTE_NAME=''
##   VCS_STATUS_PUSH_REMOTE_URL=''
##   VCS_STATUS_REMOTE_BRANCH=master
##   VCS_STATUS_REMOTE_NAME=origin
##   VCS_STATUS_REMOTE_URL=git@github.com:romkatv/powerlevel10k.git
##   VCS_STATUS_RESULT=ok-sync
##   VCS_STATUS_STASHES=0
##   VCS_STATUS_TAG=''
##   VCS_STATUS_WORKDIR=/home/romka/powerlevel10k
#
#[[ -o 'interactive' ]] || 'return'
#
## Temporarily change options.
#'builtin' 'local' '-a' '_gitstatus_opts'
#[[ ! -o 'aliases'         ]] || _gitstatus_opts+=('aliases')
#[[ ! -o 'sh_glob'         ]] || _gitstatus_opts+=('sh_glob')
#[[ ! -o 'no_brace_expand' ]] || _gitstatus_opts+=('no_brace_expand')
#'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'
#
#autoload -Uz add-zsh-hook        || return
#zmodload zsh/datetime zsh/system || return
#zmodload -F zsh/files b:zf_rm    || return
#
#typeset -g _gitstatus_plugin_dir"${1:-}"="${${(%):-%x}:A:h}"
#
## Retrives status of a git repo from a directory under its working tree.
##
### Usage: gitstatus_query [OPTION]... NAME
##
##   -d STR    Directory to query. Defaults to the current directory. Has no effect if GIT_DIR
##             is set.
##   -c STR    Callback function to call once the results are available. Called only after
##             gitstatus_query returns 0 with VCS_STATUS_RESULT=tout.
##   -t FLOAT  Timeout in seconds. Negative value means infinity. Will block for at most this long.
##             If no results are available by then: if -c isn't specified, will return 1; otherwise
##             will set VCS_STATUS_RESULT=tout and return 0.
##   -p        Don't compute anything that requires reading Git index. If this option is used,
##             the following parameters will be 0: VCS_STATUS_INDEX_SIZE,
##             VCS_STATUS_{NUM,HAS}_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED}.
##
## On success sets VCS_STATUS_RESULT to one of the following values:
##
##   tout         Timed out waiting for data; will call the user-specified callback later.
##   norepo-sync  The directory isn't a git repo.
##   ok-sync      The directory is a git repo.
##
## When the callback is called, VCS_STATUS_RESULT is set to one of the following values:
##
##   norepo-async  The directory isn't a git repo.
##   ok-async      The directory is a git repo.
##
## If VCS_STATUS_RESULT is ok-sync or ok-async, additional variables are set:
##
##   VCS_STATUS_WORKDIR              Git repo working directory. Not empty.
##   VCS_STATUS_COMMIT               Commit hash that HEAD is pointing to. Either 40 hex digits or
##                                   empty if there is no HEAD (empty repo).
##   VCS_STATUS_COMMIT_ENCODING      Encoding of the HEAD's commit message. Empty value means UTF-8.
##   VCS_STATUS_COMMIT_SUMMARY       The first paragraph of the HEAD's commit message as one line.
##   VCS_STATUS_LOCAL_BRANCH         Local branch name or empty if not on a branch.
##   VCS_STATUS_REMOTE_NAME          The remote name, e.g. "upstream" or "origin".
##   VCS_STATUS_REMOTE_BRANCH        Upstream branch name. Can be empty.
##   VCS_STATUS_REMOTE_URL           Remote URL. Can be empty.
##   VCS_STATUS_ACTION               Repository state, A.K.A. action. Can be empty.
##   VCS_STATUS_INDEX_SIZE           The number of files in the index.
##   VCS_STATUS_NUM_STAGED           The number of staged changes.
##   VCS_STATUS_NUM_CONFLICTED       The number of conflicted changes.
##   VCS_STATUS_NUM_UNSTAGED         The number of unstaged changes.
##   VCS_STATUS_NUM_UNTRACKED        The number of untracked files.
##   VCS_STATUS_HAS_STAGED           1 if there are staged changes, 0 otherwise.
##   VCS_STATUS_HAS_CONFLICTED       1 if there are conflicted changes, 0 otherwise.
##   VCS_STATUS_HAS_UNSTAGED         1 if there are unstaged changes, 0 if there aren't, -1 if
##                                   unknown.
##   VCS_STATUS_NUM_STAGED_NEW       The number of staged new files. Note that renamed files
##                                   are reported as deleted plus new.
##   VCS_STATUS_NUM_STAGED_DELETED   The number of staged deleted files. Note that renamed files
##                                   are reported as deleted plus new.
##   VCS_STATUS_NUM_UNSTAGED_DELETED The number of unstaged deleted files. Note that renamed files
##                                   are reported as deleted plus new.
##   VCS_STATUS_HAS_UNTRACKED        1 if there are untracked files, 0 if there aren't, -1 if
##                                   unknown.
##   VCS_STATUS_COMMITS_AHEAD        Number of commits the current branch is ahead of upstream.
##                                   Non-negative integer.
##   VCS_STATUS_COMMITS_BEHIND       Number of commits the current branch is behind upstream.
##                                   Non-negative integer.
##   VCS_STATUS_STASHES              Number of stashes. Non-negative integer.
##   VCS_STATUS_TAG                  The last tag (in lexicographical order) that points to the same
##                                   commit as HEAD.
##   VCS_STATUS_PUSH_REMOTE_NAME     The push remote name, e.g. "upstream" or "origin".
##   VCS_STATUS_PUSH_REMOTE_URL      Push remote URL. Can be empty.
##   VCS_STATUS_PUSH_COMMITS_AHEAD   Number of commits the current branch is ahead of push remote.
##                                   Non-negative integer.
##   VCS_STATUS_PUSH_COMMITS_BEHIND  Number of commits the current branch is behind push remote.
##                                   Non-negative integer.
##   VCS_STATUS_NUM_SKIP_WORKTREE    The number of files in the index with skip-worktree bit set.
##                                   Non-negative integer.
##   VCS_STATUS_NUM_ASSUME_UNCHANGED The number of files in the index with assume-unchanged bit set.
##                                   Non-negative integer.
##
## The point of reporting -1 via VCS_STATUS_HAS_* is to allow the command to skip scanning files in
## large repos. See -m flag of gitstatus_start.
##
## gitstatus_query returns an error if gitstatus_start hasn't been called in the same shell or
## the call had failed.
##
##       !!!!! WARNING: CONCURRENT CALLS WITH THE SAME NAME ARE NOT ALLOWED !!!!!
##
## It's illegal to call gitstatus_query if the last asynchronous call with the same NAME hasn't
## completed yet. If you need to issue concurrent requests, use different NAME arguments.
## function gitstatus_query"${1:-}"() {
#  emulate -L zsh -o no_aliases -o extended_glob -o typeset_silent
#
#  local fsuf=${${(%):-%N}#gitstatus_query}
#
#  unset VCS_STATUS_RESULT
#
#  local opt dir callback OPTARG
#  local -i no_diff OPTIND
#  local -F timeout=-1
#  while getopts ":d:c:t:p" opt; do
#    case $opt in
#      +p) no_diff=0;;
#      p)  no_diff=1;;
#      d)  dir=$OPTARG;;
#      c)  callback=$OPTARG;;
#      t)
#        if [[ $OPTARG != (|+|-)<->(|.<->)(|[eE](|-|+)<->) ]]; then
#          print -ru2 -- "gitstatus_query: invalid -t argument: $OPTARG"
#          return 1
#        fi
#        timeout=OPTARG
#      ;;
#      \?) print -ru2 -- "gitstatus_query: invalid option: $OPTARG"           ; return 1;;
#      :)  print -ru2 -- "gitstatus_query: missing required argument: $OPTARG"; return 1;;
#      *)  print -ru2 -- "gitstatus_query: invalid option: $opt"              ; return 1;;
#    esac
#  done
#
#  if (( OPTIND != ARGC )); then
#    print -ru2 -- "gitstatus_query: exactly one positional argument is required"
#    return 1
#  fi
#
#  local name=$*[OPTIND]
#  if [[ $name != [[:IDENT:]]## ]]; then
#    print -ru2 -- "gitstatus_query: invalid positional argument: $name"
#    return 1
#  fi
#
#  (( _GITSTATUS_STATE_$name == 2 )) || return
#
#  if [[ -z $GIT_DIR ]]; then
#    if [[ $dir != /* ]]; then
#      if [[ $PWD == /* && $PWD -ef . ]]; then
#        dir=$PWD/$dir
#      else
#        dir=${dir:a}
#      fi
#    fi
#  else
#    if [[ $GIT_DIR == /* ]]; then
#      dir=:$GIT_DIR
#    elif [[ $PWD == /* && $PWD -ef . ]]; then
#      dir=:$PWD/$GIT_DIR
#    else
#      dir=:${GIT_DIR:a}
#    fi
#  fi
#
#  if [[ $dir != (|:)/* ]]; then
#    typeset -g VCS_STATUS_RESULT=norepo-sync
#    _gitstatus_clear$fsuf
#    return 0
#  fi
#
#  local -i req_fd=${(P)${:-_GITSTATUS_REQ_FD_$name}}
#  local req_id=$EPOCHREALTIME
#  print -rnu $req_fd -- $req_id' '$callback$'\x1f'$dir$'\x1f'$no_diff$'\x1e' || return
#
#  (( ++_GITSTATUS_NUM_INFLIGHT_$name ))
#
#  if (( timeout == 0 )); then
#    typeset -g VCS_STATUS_RESULT=tout
#    _gitstatus_clear$fsuf
#  else
#    while true; do
#      _gitstatus_process_response$fsuf $name $timeout $req_id || return
#      [[ $VCS_STATUS_RESULT == *-async ]] || break
#    done
#  fi
#
#  [[ $VCS_STATUS_RESULT != tout || -n $callback ]]
#}
#
## If the last call to gitstatus_query timed out (VCS_STATUS_RESULT=tout), wait for the callback
## to be called. Otherwise do nothing.
##
## Usage: gitstatus_process_results [OPTION]... NAME
##
##   -t FLOAT  Timeout in seconds. Negative value means infinity. Will block for at most this long.
##
## Returns an error only when invoked with incorrect arguments and when gitstatusd isn't running or
## broken.
##
## If a callback gets called, VCS_STATUS_* parameters are set as in gitstatus_query.
## VCS_STATUS_RESULT is either norepo-async or ok-async.
#function gitstatus_process_results"${1:-}"() {
#  emulate -L zsh -o no_aliases -o extended_glob -o typeset_silent
#
#  local fsuf=${${(%):-%N}#gitstatus_process_results}
#
#  local opt OPTARG
#  local -i OPTIND
#  local -F timeout=-1
#  while getopts ":t:" opt; do
#    case $opt in
#      t)
#        if [[ $OPTARG != (|+|-)<->(|.<->)(|[eE](|-|+)<->) ]]; then
#          print -ru2 -- "gitstatus_process_results: invalid -t argument: $OPTARG"
#          return 1
#        fi
#        timeout=OPTARG
#      ;;
#      \?) print -ru2 -- "gitstatus_process_results: invalid option: $OPTARG"           ; return 1;;
#      :)  print -ru2 -- "gitstatus_process_results: missing required argument: $OPTARG"; return 1;;
#      *)  print -ru2 -- "gitstatus_process_results: invalid option: $opt"              ; return 1;;
#    esac
#  done
#
#  if (( OPTIND != ARGC )); then
#    print -ru2 -- "gitstatus_process_results: exactly one positional argument is required"
#    return 1
#  fi
#
#  local name=$*[OPTIND]
#  if [[ $name != [[:IDENT:]]## ]]; then
#    print -ru2 -- "gitstatus_process_results: invalid positional argument: $name"
#    return 1
#  fi
#
#  (( _GITSTATUS_STATE_$name == 2 )) || return
#
#  while (( _GITSTATUS_NUM_INFLIGHT_$name )); do
#    _gitstatus_process_response$fsuf $name $timeout '' || return
#    [[ $VCS_STATUS_RESULT == *-async ]] || break
#  done
#
#  return 0
#}
#
#function _gitstatus_clear"${1:-}"() {
#  unset VCS_STATUS_{WORKDIR,COMMIT,LOCAL_BRANCH,REMOTE_BRANCH,REMOTE_NAME,REMOTE_URL,ACTION,INDEX_SIZE,NUM_STAGED,NUM_UNSTAGED,NUM_CONFLICTED,NUM_UNTRACKED,HAS_STAGED,HAS_UNSTAGED,HAS_CONFLICTED,HAS_UNTRACKED,COMMITS_AHEAD,COMMITS_BEHIND,STASHES,TAG,NUM_UNSTAGED_DELETED,NUM_STAGED_NEW,NUM_STAGED_DELETED,PUSH_REMOTE_NAME,PUSH_REMOTE_URL,PUSH_COMMITS_AHEAD,PUSH_COMMITS_BEHIND,NUM_SKIP_WORKTREE,NUM_ASSUME_UNCHANGED}
#}
#
#function _gitstatus_process_response"${1:-}"() {
#  local name=$1 timeout req_id=$3 buf
#  local -i resp_fd=_GITSTATUS_RESP_FD_$name
#  local -i dirty_max_index_size=_GITSTATUS_DIRTY_MAX_INDEX_SIZE_$name
#
#  (( $2 >= 0 )) && timeout=-t$2 && [[ -t $resp_fd ]]
#  sysread $timeout -i $resp_fd 'buf[$#buf+1]' || {
#    if (( $? == 4 )); then
#      if [[ -n $req_id ]]; then
#        typeset -g VCS_STATUS_RESULT=tout
#        _gitstatus_clear$fsuf
#      fi
#      return 0
#    else
#      gitstatus_stop$fsuf $name
#      return 1
#    fi
#  }
#  while [[ $buf != *$'\x1e' ]]; do
#    if ! sysread -i $resp_fd 'buf[$#buf+1]'; then
#      gitstatus_stop$fsuf $name
#      return 1
#    fi
#  done
#
#  local s
#  for s in ${(ps:\x1e:)buf}; do
#    local -a resp=("${(@ps:\x1f:)s}")
#    if (( resp[2] )); then
#      if [[ $resp[1] == $req_id' '* ]]; then
#        typeset -g VCS_STATUS_RESULT=ok-sync
#      else
#        typeset -g VCS_STATUS_RESULT=ok-async
#      fi
#      for VCS_STATUS_WORKDIR              \
#          VCS_STATUS_COMMIT               \
#          VCS_STATUS_LOCAL_BRANCH         \
#          VCS_STATUS_REMOTE_BRANCH        \
#          VCS_STATUS_REMOTE_NAME          \
#          VCS_STATUS_REMOTE_URL           \
#          VCS_STATUS_ACTION               \
#          VCS_STATUS_INDEX_SIZE           \
#          VCS_STATUS_NUM_STAGED           \
#          VCS_STATUS_NUM_UNSTAGED         \
#          VCS_STATUS_NUM_CONFLICTED       \
#          VCS_STATUS_NUM_UNTRACKED        \
#          VCS_STATUS_COMMITS_AHEAD        \
#          VCS_STATUS_COMMITS_BEHIND       \
#          VCS_STATUS_STASHES              \
#          VCS_STATUS_TAG                  \
#          VCS_STATUS_NUM_UNSTAGED_DELETED \
#          VCS_STATUS_NUM_STAGED_NEW       \
#          VCS_STATUS_NUM_STAGED_DELETED   \
#          VCS_STATUS_PUSH_REMOTE_NAME     \
#          VCS_STATUS_PUSH_REMOTE_URL      \
#          VCS_STATUS_PUSH_COMMITS_AHEAD   \
#          VCS_STATUS_PUSH_COMMITS_BEHIND  \
#          VCS_STATUS_NUM_SKIP_WORKTREE    \
#          VCS_STATUS_NUM_ASSUME_UNCHANGED \
#          VCS_STATUS_COMMIT_ENCODING      \
#          VCS_STATUS_COMMIT_SUMMARY in "${(@)resp[3,29]}"; do
#      done
#      typeset -gi VCS_STATUS_{INDEX_SIZE,NUM_STAGED,NUM_UNSTAGED,NUM_CONFLICTED,NUM_UNTRACKED,COMMITS_AHEAD,COMMITS_BEHIND,STASHES,NUM_UNSTAGED_DELETED,NUM_STAGED_NEW,NUM_STAGED_DELETED,PUSH_COMMITS_AHEAD,PUSH_COMMITS_BEHIND,NUM_SKIP_WORKTREE,NUM_ASSUME_UNCHANGED}
#      typeset -gi VCS_STATUS_HAS_STAGED=$((VCS_STATUS_NUM_STAGED > 0))
#      if (( dirty_max_index_size >= 0 && VCS_STATUS_INDEX_SIZE > dirty_max_index_size )); then
#        typeset -gi                    \
#          VCS_STATUS_HAS_UNSTAGED=-1   \
#          VCS_STATUS_HAS_CONFLICTED=-1 \
#          VCS_STATUS_HAS_UNTRACKED=-1
#      else
#        typeset -gi                                                    \
#          VCS_STATUS_HAS_UNSTAGED=$((VCS_STATUS_NUM_UNSTAGED > 0))     \
#          VCS_STATUS_HAS_CONFLICTED=$((VCS_STATUS_NUM_CONFLICTED > 0)) \
#          VCS_STATUS_HAS_UNTRACKED=$((VCS_STATUS_NUM_UNTRACKED > 0))
#      fi
#    else
#      if [[ $resp[1] == $req_id' '* ]]; then
#        typeset -g VCS_STATUS_RESULT=norepo-sync
#      else
#        typeset -g VCS_STATUS_RESULT=norepo-async
#      fi
#      _gitstatus_clear$fsuf
#    fi
#    (( --_GITSTATUS_NUM_INFLIGHT_$name ))
#    [[ $VCS_STATUS_RESULT == *-async ]] && emulate zsh -c "${resp[1]#* }"
#  done
#
#  return 0
#}
#
#function _gitstatus_daemon"${1:-}"() {
#  local -i pipe_fd
#  exec 0<&- {pipe_fd}>&1 1>>$daemon_log 2>&1 || return
#  local pgid=$sysparams[pid]
#  [[ $pgid == <1-> ]] || return
#  builtin cd -q /     || return
#
#  {
#    {
#      trap '' PIPE
#
#      local uname_sm
#      uname_sm="${${(L)$(command uname -sm)}//ı/i}" || return
#      [[ $uname_sm == [^' ']##' '[^' ']## ]]        || return
#      local uname_s=${uname_sm% *}
#      local uname_m=${uname_sm#* }
#
#      if [[ $GITSTATUS_NUM_THREADS == <1-> ]]; then
#        args+=(-t $GITSTATUS_NUM_THREADS)
#      else
#        local cpus
#        if (( ! $+commands[sysctl] )) || [[ $uname_s == linux ]] ||
#            ! cpus="$(command sysctl -n hw.ncpu)"; then
#          if (( ! $+commands[getconf] )) || ! cpus="$(command getconf _NPROCESSORS_ONLN)"; then
#            cpus=8
#          fi
#        fi
#        args+=(-t $((cpus > 16 ? 32 : cpus > 0 ? 2 * cpus : 16)))
#      fi
#
#      command mkfifo -- $file_prefix.fifo   || return
#      print -rnu $pipe_fd -- ${(l:20:)pgid} || return
#      exec <$file_prefix.fifo               || return
#      zf_rm -- $file_prefix.fifo            || return
#
#      local _gitstatus_zsh_daemon _gitstatus_zsh_version _gitstatus_zsh_downloaded
#
#      function _gitstatus_set_daemon$fsuf() {
#        _gitstatus_zsh_daemon="$1"
#        _gitstatus_zsh_version="$2"
#        _gitstatus_zsh_downloaded="$3"
#      }
#
#      local gitstatus_plugin_dir_var=_gitstatus_plugin_dir$fsuf
#      local gitstatus_plugin_dir=${(P)gitstatus_plugin_dir_var}
#      builtin set -- -d $gitstatus_plugin_dir -s $uname_s -m $uname_m \
#        -p "printf '\\001' >&$pipe_fd" -e $pipe_fd -- _gitstatus_set_daemon$fsuf
#      [[ ${GITSTATUS_AUTO_INSTALL:-1} == (|-|+)<1-> ]] || builtin set -- -n "$@"
#      # builtin source $gitstatus_plugin_dir/install     || return
#      [[ -n $_gitstatus_zsh_daemon ]]                  || return
#      [[ -n $_gitstatus_zsh_version ]]                 || return
#      [[ $_gitstatus_zsh_downloaded == [01] ]]         || return
#
#      if (( UID == EUID )); then
#        local home=~
#      else
#        local user
#        user="$(command id -un)" || return
#        local home=${userdirs[$user]}
#        [[ -n $home ]] || return
#      fi
#
#      if [[ -x $_gitstatus_zsh_daemon ]]; then
#        HOME=$home $_gitstatus_zsh_daemon -G $_gitstatus_zsh_version "${(@)args}" >&$pipe_fd
#        local -i ret=$?
#        [[ $ret == (0|129|130|131|137|141|143|159) ]] && return ret
#      fi
#
#      (( ! _gitstatus_zsh_downloaded ))                || return
#      [[ ${GITSTATUS_AUTO_INSTALL:-1} == (|-|+)<1-> ]] || return
#      [[ $_gitstatus_zsh_daemon == \
#         ${GITSTATUS_CACHE_DIR:-${XDG_CACHE_HOME:-$HOME/.cache}/gitstatus}/* ]] || return
#
#      builtin set -- -f "$@"
#      _gitstatus_zsh_daemon=
#      _gitstatus_zsh_version=
#      _gitstatus_zsh_downloaded=
#      # builtin source $gitstatus_plugin_dir/install || return
#      [[ -n $_gitstatus_zsh_daemon ]]              || return
#      [[ -n $_gitstatus_zsh_version ]]             || return
#      [[ $_gitstatus_zsh_downloaded == 1 ]]        || return
#
#      HOME=$home $_gitstatus_zsh_daemon -G $_gitstatus_zsh_version "${(@)args}" >&$pipe_fd
#    } always {
#      local -i ret=$?
#      zf_rm -f -- $file_prefix.lock $file_prefix.fifo
#      kill -- -$pgid
#    }
#  } &!
#
#  (( lock_fd == -1 )) && return
#
#  {
#    if zsystem flock -- $file_prefix.lock && command sleep 5 && [[ -e $file_prefix.lock ]]; then
#      zf_rm -f -- $file_prefix.lock $file_prefix.fifo
#      kill -- -$pgid
#    fi
#  } &!
#}
#
## Starts gitstatusd in the background. Does nothing and succeeds if gitstatusd is already running.
##
## Usage: gitstatus_start [OPTION]... NAME
##
##   -t FLOAT  Fail the self-check on initialization if not getting a response from gitstatusd for
##             this this many seconds. Defaults to 5.
##
##   -s INT    Report at most this many staged changes; negative value means infinity.
##             Defaults to 1.
##
##   -u INT    Report at most this many unstaged changes; negative value means infinity.
##             Defaults to 1.
##
##   -c INT    Report at most this many conflicted changes; negative value means infinity.
##             Defaults to 1.
##
##   -d INT    Report at most this many untracked files; negative value means infinity.
##             Defaults to 1.
##
##   -m INT    Report -1 unstaged, untracked and conflicted if there are more than this many
##             files in the index. Negative value means infinity. Defaults to -1.
##
##   -e        Count files within untracked directories like `git status --untracked-files`.
##
##   -U        Unless this option is specified, report zero untracked files for repositories
##             with status.showUntrackedFiles = false.
##
##   -W        Unless this option is specified, report zero untracked files for repositories
##             with bash.showUntrackedFiles = false.
##
##   -D        Unless this option is specified, report zero staged, unstaged and conflicted
##             changes for repositories with bash.showDirtyState = false.
#function gitstatus_start"${1:-}"() {
#  emulate -L zsh -o no_aliases -o no_bg_nice -o extended_glob -o typeset_silent || return
#  print -rnu2 || return
#  local fsuf=${${(%):-%N}#gitstatus_start}
#  local opt OPTARG
#  local -i OPTIND
#  local -F timeout=5
#  local -i async=0
#  local -a args=()
#  local -i dirty_max_index_size=-1
#  while getopts ":t:s:u:c:d:m:eaUWD" opt; do
#    case $opt in
#      a)  async=1;;
#      +a) async=0;;
#      t)
#        if [[ $OPTARG != (|+)<->(|.<->)(|[eE](|-|+)<->) ]] || (( ${timeout::=OPTARG} <= 0 )); then
#          print -ru2 -- "gitstatus_start: invalid -t argument: $OPTARG"
#          return 1
#        fi
#      ;;
#      s|u|c|d|m)
#        if [[ $OPTARG != (|-|+)<-> ]]; then
#          print -ru2 -- "gitstatus_start: invalid -$opt argument: $OPTARG"
#          return 1
#        fi
#        args+=(-$opt $OPTARG)
#        [[ $opt == m ]] && dirty_max_index_size=OPTARG
#      ;;
#      e|U|W|D)    args+=-$opt;;
#      +(e|U|W|D)) args=(${(@)args:#-$opt});;
#      \?) print -ru2 -- "gitstatus_start: invalid option: $OPTARG"           ; return 1;;
#      :)  print -ru2 -- "gitstatus_start: missing required argument: $OPTARG"; return 1;;
#      *)  print -ru2 -- "gitstatus_start: invalid option: $opt"              ; return 1;;
#    esac
#  done
#  if (( OPTIND != ARGC )); then
#    print -ru2 -- "gitstatus_start: exactly one positional argument is required"
#    return 1
#  fi
#  local name=$*[OPTIND]
#  if [[ $name != [[:IDENT:]]## ]]; then
#    print -ru2 -- "gitstatus_start: invalid positional argument: $name"
#    return 1
#  fi
#  local -i lock_fd resp_fd stderr_fd
#  local file_prefix xtrace=/dev/null daemon_log=/dev/null culprit
#  {
#    if (( _GITSTATUS_STATE_$name )); then
#      (( async )) && return
#      (( _GITSTATUS_STATE_$name == 2 )) && return
#      lock_fd=_GITSTATUS_LOCK_FD_$name
#      resp_fd=_GITSTATUS_RESP_FD_$name
#      xtrace=${(P)${:-GITSTATUS_XTRACE_$name}}
#      daemon_log=${(P)${:-GITSTATUS_DAEMON_LOG_$name}}
#      file_prefix=${(P)${:-_GITSTATUS_FILE_PREFIX_$name}}
#    else
#      typeset -gi _GITSTATUS_START_COUNTER
#      local log_level=$GITSTATUS_LOG_LEVEL
#      local file_prefix=${${TMPDIR:-/tmp}:A}/gitstatus.$name.$EUID
#      file_prefix+=.$sysparams[pid].$EPOCHSECONDS.$((++_GITSTATUS_START_COUNTER))
#      (( GITSTATUS_ENABLE_LOGGING )) && : ${log_level:=INFO}
#      if [[ -n $log_level ]]; then
#        xtrace=$file_prefix.xtrace.log
#        daemon_log=$file_prefix.daemon.log
#      fi
#      args+=(-v ${log_level:-FATAL})
#      typeset -g GITSTATUS_XTRACE_$name=$xtrace
#      typeset -g GITSTATUS_DAEMON_LOG_$name=$daemon_log
#      typeset -g _GITSTATUS_FILE_PREFIX_$name=$file_prefix
#      typeset -gi _GITSTATUS_CLIENT_PID_$name="sysparams[pid]"
#      typeset -gi _GITSTATUS_DIRTY_MAX_INDEX_SIZE_$name=dirty_max_index_size
#    fi
#    () {
#      if [[ $xtrace != /dev/null && -o no_xtrace ]]; then
#        exec {stderr_fd}>&2 || return
#        exec 2>>$xtrace     || return
#        setopt xtrace
#      fi
#
#      setopt monitor || return
#
#      if (( ! _GITSTATUS_STATE_$name )); then
#        if [[ -r /proc/version && "$(</proc/version)" == *Microsoft* ]]; then
#          lock_fd=-1
#        else
#          print -rn >$file_prefix.lock               || return
#          zsystem flock -f lock_fd $file_prefix.lock || return
#          [[ $lock_fd == <1-> ]]                     || return
#        fi
#
#        typeset -gi _GITSTATUS_LOCK_FD_$name=lock_fd
#
#        if [[ $OSTYPE == cygwin* && -d /proc/self/fd ]]; then
#          # Work around bugs in Cygwin 32-bit.
#          #
#          # This hangs:
#          #
#          #   emulate -L zsh
#          #   () { exec {fd}< $1 } <(:)
#          #   =true  # hangs here
#          #
#          # This hangs:
#          #
#          #   sysopen -r -u fd <(:)
#          local -i fd
#          exec {fd}< <(_gitstatus_daemon$fsuf)                       || return
#          {
#            [[ -r /proc/self/fd/$fd ]]                               || return
#            sysopen -r -o cloexec -u resp_fd /proc/self/fd/$fd       || return
#          } always {
#            exec {fd} >&-                                            || return
#          }
#        else
#          sysopen -r -o cloexec -u resp_fd <(_gitstatus_daemon$fsuf) || return
#        fi
#
#        typeset -gi GITSTATUS_DAEMON_PID_$name="${sysparams[procsubstpid]:--1}"
#
#        [[ $resp_fd == <1-> ]] || return
#        typeset -gi _GITSTATUS_RESP_FD_$name=resp_fd
#        typeset -gi _GITSTATUS_STATE_$name=1
#      fi
#
#      if (( ! async )); then
#        (( _GITSTATUS_CLIENT_PID_$name == sysparams[pid] )) || return
#
#        local pgid
#        while (( $#pgid < 20 )); do
#          [[ -t $resp_fd ]]
#          sysread -s $((20 - $#pgid)) -t $timeout -i $resp_fd 'pgid[$#pgid+1]' || return
#        done
#        [[ $pgid == ' '#<1-> ]] || return
#        typeset -gi GITSTATUS_DAEMON_PID_$name=pgid
#
#        sysopen -w -o cloexec -u req_fd -- $file_prefix.fifo || return
#        [[ $req_fd == <1-> ]]                                || return
#        typeset -gi _GITSTATUS_REQ_FD_$name=req_fd
#
#        print -nru $req_fd -- $'}hello\x1f\x1e' || return
#        local expected=$'}hello\x1f0\x1e' actual
#        if (( $+functions[p10k] )) && [[ ! -t 1 && ! -t 0 ]]; then
#          local -F deadline='EPOCHREALTIME + 4'
#        else
#          local -F deadline='1'
#        fi
#        while true; do
#          [[ -t $resp_fd ]]
#          sysread -s 1 -t $timeout -i $resp_fd actual || return
#          [[ $expected == $actual* ]] && break
#          if [[ $actual != $'\1' ]]; then
#            [[ -t $resp_fd ]]
#            while sysread -t $timeout -i $resp_fd 'actual[$#actual+1]'; do
#              [[ -t $resp_fd ]]
#            done
#            culprit=$actual
#            return 1
#          fi
#          (( EPOCHREALTIME < deadline )) && continue
#          if (( deadline > 0 )); then
#            deadline=0
#            if (( stderr_fd )); then
#              unsetopt xtrace
#              exec 2>&$stderr_fd {stderr_fd}>&-
#              stderr_fd=0
#            fi
#            if (( $+functions[p10k] )); then
#              p10k clear-instant-prompt || return
#            fi
#            if [[ $name == POWERLEVEL9K ]]; then
#              local label=powerlevel10k
#            else
#              local label=gitstatus
#            fi
#            if [[ -t 2 ]]; then
#              local spinner=($'\b%3F-%f' $'\b%3F\\%f' $'\b%3F|%f' $'\b%3F/%f')
#              print -Prnu2 -- "[%3F$label%f] fetching %2Fgitstatusd%f ..  "
#            else
#              local spinner=('.')
#              print -rnu2 -- "[$label] fetching gitstatusd .."
#            fi
#          fi
#          print -Prnu2 -- $spinner[1]
#          spinner=($spinner[2,-1] $spinner[1])
#        done
#        if (( deadline == 0 )); then
#          if [[ -t 2 ]]; then
#            print -Pru2 -- $'\b[%2Fok%f]'
#          else
#            print -ru2 -- ' [ok]'
#          fi
#          if [[ $xtrace != /dev/null && -o no_xtrace ]]; then
#            exec {stderr_fd}>&2 || return
#            exec 2>>$xtrace     || return
#            setopt xtrace
#          fi
#        fi
#        while (( $#actual < $#expected )); do
#          [[ -t $resp_fd ]]
#          sysread -s $(($#expected - $#actual)) -t $timeout -i $resp_fd 'actual[$#actual+1]' || return
#        done
#        [[ $actual == $expected ]] || return
#
#        function _gitstatus_process_response_$name-$fsuf() {
#          emulate -L zsh -o no_aliases -o extended_glob -o typeset_silent
#          local pair=${${(%):-%N}#_gitstatus_process_response_}
#          local name=${pair%%-*}
#          local fsuf=${pair#*-}
#          [[ $name == POWERLEVEL9K && $fsuf == _p9k_ ]] && eval $__p9k_intro_base
#          if (( ARGC == 1 )); then
#            _gitstatus_process_response$fsuf $name 0 ''
#          else
#            gitstatus_stop$fsuf $name
#          fi
#        }
#        if ! zle -F $resp_fd _gitstatus_process_response_$name-$fsuf; then
#          unfunction _gitstatus_process_response_$name-$fsuf
#          return 1
#        fi
#
#        function _gitstatus_cleanup_$name-$fsuf() {
#          emulate -L zsh -o no_aliases -o extended_glob -o typeset_silent
#          local pair=${${(%):-%N}#_gitstatus_cleanup_}
#          local name=${pair%%-*}
#          local fsuf=${pair#*-}
#          (( _GITSTATUS_CLIENT_PID_$name == sysparams[pid] )) || return
#          gitstatus_stop$fsuf $name
#        }
#        if ! add-zsh-hook zshexit _gitstatus_cleanup_$name-$fsuf; then
#          unfunction _gitstatus_cleanup_$name-$fsuf
#          return 1
#        fi
#
#        if (( lock_fd != -1 )); then
#          zf_rm -- $file_prefix.lock || return
#          zsystem flock -u $lock_fd  || return
#        fi
#        unset _GITSTATUS_LOCK_FD_$name
#
#        typeset -gi _GITSTATUS_STATE_$name=2
#      fi
#    }
#  } always {
#    local -i err=$?
#    (( stderr_fd )) && exec 2>&$stderr_fd {stderr_fd}>&-
#    (( err == 0  )) && return
#
#    gitstatus_stop$fsuf $name
#
#    setopt prompt_percent no_prompt_subst no_prompt_bang
#    (( $+functions[p10k] )) && p10k clear-instant-prompt
#    print -ru2     -- ''
#    print -Pru2    -- '[%F{red}ERROR%f]: gitstatus failed to initialize.'
#    print -ru2     -- ''
#    if [[ -n $culprit ]]; then
#      print -ru2   -- $culprit
#      return err
#    fi
#    if [[ -s $xtrace ]]; then
#      print -ru2   -- ''
#      print -Pru2  -- "  Zsh log (%U${xtrace//\%/%%}%u):"
#      print -Pru2  -- '%F{yellow}'
#      print -lru2  -- "${(@)${(@f)$(<$xtrace)}/#/    }"
#      print -Pnru2 -- '%f'
#    fi
#    if [[ -s $daemon_log ]]; then
#      print -ru2   -- ''
#      print -Pru2  -- "  Daemon log (%U${daemon_log//\%/%%}%u):"
#      print -Pru2  -- '%F{yellow}'
#      print -lru2  -- "${(@)${(@f)$(<$daemon_log)}/#/    }"
#      print -Pnru2 -- '%f'
#    fi
#    if [[ $GITSTATUS_LOG_LEVEL == DEBUG ]]; then
#      print -ru2   -- ''
#      print -ru2   -- '  System information:'
#      print -Pru2  -- '%F{yellow}'
#      print -ru2   -- "    zsh:      $ZSH_VERSION"
#      print -ru2   -- "    uname -a: $(command uname -a)"
#      print -Pru2  -- '%f'
#      print -ru2   -- '  If you need help, open an issue and attach this whole error message to it:'
#      print -ru2   -- ''
#      print -Pru2  -- '    %Uhttps://github.com/romkatv/gitstatus/issues/new%u'
#    else
#      print -ru2   -- ''
#      local home=~
#      local zshrc=${${${(q)${ZDOTDIR:-~}}/#${(q)home}/'~'}//\%/%%}/.zshrc
#      print -Pru2  -- "  Add the following parameter to %U$zshrc%u for extra diagnostics on error:"
#      print -ru2   -- ''
#      print -Pru2  -- '    %BGITSTATUS_LOG_LEVEL=DEBUG%b'
#      print -ru2   -- ''
#      print -ru2   -- '  Restart Zsh to retry gitstatus initialization:'
#      print -ru2   -- ''
#      print -Pru2  -- '    %F{green}%Uexec%u zsh%f'
#    fi
#  }
#}
#
## Stops gitstatusd if it's running.
## Usage: gitstatus_stop NAME.
#function gitstatus_stop"${1:-}"() {
#  emulate -L zsh -o no_aliases -o extended_glob -o typeset_silent
#  local fsuf=${${(%):-%N}#gitstatus_stop}
#  if (( ARGC != 1 )); then
#    print -ru2 -- "gitstatus_stop: exactly one positional argument is required"
#    return 1
#  fi
#  local name=$1
#  if [[ $name != [[:IDENT:]]## ]]; then
#    print -ru2 -- "gitstatus_stop: invalid positional argument: $name"
#    return 1
#  fi
#  local state_var=_GITSTATUS_STATE_$name
#  local req_fd_var=_GITSTATUS_REQ_FD_$name
#  local resp_fd_var=_GITSTATUS_RESP_FD_$name
#  local lock_fd_var=_GITSTATUS_LOCK_FD_$name
#  local client_pid_var=_GITSTATUS_CLIENT_PID_$name
#  local daemon_pid_var=GITSTATUS_DAEMON_PID_$name
#  local inflight_var=_GITSTATUS_NUM_INFLIGHT_$name
#  local file_prefix_var=_GITSTATUS_FILE_PREFIX_$name
#  local dirty_max_index_size_var=_GITSTATUS_DIRTY_MAX_INDEX_SIZE_$name
#  local req_fd=${(P)req_fd_var}
#  local resp_fd=${(P)resp_fd_var}
#  local lock_fd=${(P)lock_fd_var}
#  local daemon_pid=${(P)daemon_pid_var}
#  local file_prefix=${(P)file_prefix_var}
#  local cleanup=_gitstatus_cleanup_$name-$fsuf
#  local process=_gitstatus_process_response_$name-$fsuf
#  if (( $+functions[$cleanup] )); then
#    add-zsh-hook -d zshexit $cleanup
#    unfunction -- $cleanup
#  fi
#  if (( $+functions[$process] )); then
#    [[ -n $resp_fd ]] && zle -F $resp_fd
#    unfunction -- $process
#  fi
#  [[ $daemon_pid  == <1-> ]] && kill -- -$daemon_pid 2>/dev/null
#  [[ $file_prefix == /*   ]] && zf_rm -f -- $file_prefix.lock $file_prefix.fifo
#  [[ $lock_fd     == <1-> ]] && zsystem flock -u $lock_fd
#  [[ $req_fd      == <1-> ]] && exec {req_fd}>&-
#  [[ $resp_fd     == <1-> ]] && exec {resp_fd}>&-
#  unset $state_var $req_fd_var $lock_fd_var $resp_fd_var $client_pid_var $daemon_pid_var
#  unset $inflight_var $file_prefix_var $dirty_max_index_size_var
#  unset VCS_STATUS_RESULT
#  _gitstatus_clear$fsuf
#}
#
## Usage: gitstatus_check NAME.
## Returns 0 if and only if `gitstatus_start NAME` has succeeded previously.
## If it returns non-zero, gitstatus_query NAME is guaranteed to return non-zero.
#function gitstatus_check"${1:-}"() {
#  emulate -L zsh -o no_aliases -o extended_glob -o typeset_silent
#  local fsuf=${${(%):-%N}#gitstatus_check}
#  if (( ARGC != 1 )); then
#    print -ru2 -- "gitstatus_check: exactly one positional argument is required"
#    return 1
#  fi
#  local name=$1
#  if [[ $name != [[:IDENT:]]## ]]; then
#    print -ru2 -- "gitstatus_check: invalid positional argument: $name"
#    return 1
#  fi
#  (( _GITSTATUS_STATE_$name == 2 ))
#}
#(( ${#_gitstatus_opts} )) && setopt ${_gitstatus_opts[@]}
#'builtin' 'unset' '_gitstatus_opts'
#
## Simple Zsh prompt with Git status.
#
## Source gitstatus.plugin.zsh from $GITSTATUS_DIR or from the same directory
## in which the current script resides if the variable isn't set.
## source "${GITSTATUS_DIR:-${${(%):-%x}:h}}/gitstatus.plugin.zsh" || return
#
## Sets GITSTATUS_PROMPT to reflect the state of the current git repository. Empty if not
## in a git repository. In addition, sets GITSTATUS_PROMPT_LEN to the number of columns
## $GITSTATUS_PROMPT will occupy when printed.
##
## Example:
##
##   GITSTATUS_PROMPT='master ⇣42⇡42 ⇠42⇢42 *42 merge ~42 +42 !42 ?42'
##   GITSTATUS_PROMPT_LEN=39
##
##   master  current branch
##      ⇣42  local branch is 42 commits behind the remote
##      ⇡42  local branch is 42 commits ahead of the remote
##      ⇠42  local branch is 42 commits behind the push remote
##      ⇢42  local branch is 42 commits ahead of the push remote
##      *42  42 stashes
##    merge  merge in progress
##      ~42  42 merge conflicts
##      +42  42 staged changes
##      !42  42 unstaged changes
##      ?42  42 untracked files
#function gitstatus_prompt_update() {
#  emulate -L zsh
#  typeset -g  GITSTATUS_PROMPT=''
#  typeset -gi GITSTATUS_PROMPT_LEN=0
#  # Call gitstatus_query synchronously. Note that gitstatus_query can also be called
#  # asynchronously; see documentation in gitstatus.plugin.zsh.
#  gitstatus_query 'MY'                  || return 1  # error
#  [[ $VCS_STATUS_RESULT == 'ok-sync' ]] || return 0  # not a git repo
#  local      clean='%76F'   # green foreground
#  local   modified='%178F'  # yellow foreground
#  local  untracked='%39F'   # blue foreground
#  local conflicted='%196F'  # red foreground
#  local p
#  local where  # branch name, tag or commit
#  if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
#     where=$VCS_STATUS_LOCAL_BRANCH
#elif [[ -n $VCS_STATUS_TAG ]]       ; then
#     p+='%f#'
#     where=$VCS_STATUS_TAG
#else
#     p+='%f@'
#     where=${VCS_STATUS_COMMIT[1,8]}
#  fi
#
#  (( $#where > 32 )) && where[13,-13]="…"  # truncate long branch names and tags
#  p+="${clean}${where//\%/%%}"             # escape %
#  (( VCS_STATUS_COMMITS_BEHIND      )) && p+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
#  (( VCS_STATUS_COMMITS_AHEAD          && !VCS_STATUS_COMMITS_BEHIND      )) && p+=" "
#  (( VCS_STATUS_COMMITS_AHEAD       )) && p+=" ${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
#  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"   # ⇠42 if behind the push remote.
#  (( VCS_STATUS_PUSH_COMMITS_AHEAD     && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" "
#  (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && p+=" ${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"    # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
#  (( VCS_STATUS_STASHES             )) && p+=" ${clean}*${VCS_STATUS_STASHES}"               # *42 if have stashes.
#  [[ -n $VCS_STATUS_ACTION          ]] && p+=" ${conflicted}${VCS_STATUS_ACTION}"            # 'merge' if the repo is in an unusual state.
#  (( VCS_STATUS_NUM_CONFLICTED      )) && p+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"   # ~42 if have merge conflicts.
#  (( VCS_STATUS_NUM_STAGED          )) && p+=" ${modified}+${VCS_STATUS_NUM_STAGED}"         # +42 if have staged changes.
#  (( VCS_STATUS_NUM_UNSTAGED        )) && p+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"       # !42 if have unstaged changes.
#  (( VCS_STATUS_NUM_UNTRACKED       )) && p+=" ${untracked}?${VCS_STATUS_NUM_UNTRACKED}"     # ?42 if have untracked files. It's really a question mark, your font isn't broken.
#
#  GITSTATUS_PROMPT="${p}%f"
#  # The length of GITSTATUS_PROMPT after removing %f and %F.
#  GITSTATUS_PROMPT_LEN="${(m)#${${GITSTATUS_PROMPT//\%\%/x}//\%(f|<->F)}}"
#}
#
## Start gitstatusd instance with name "MY". The same name is passed to
## gitstatus_query in gitstatus_prompt_update. The flags with -1 as values
## enable staged, unstaged, conflicted and untracked counters.
#gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
#
## On every prompt, fetch git status and set GITSTATUS_PROMPT.
#autoload -Uz add-zsh-hook
# add-zsh-hook precmd gitstatus_prompt_update
#
## Enable/disable the right prompt options.
#setopt no_prompt_bang prompt_percent prompt_subst
#
## Customize prompt. Put $GITSTATUS_PROMPT in it to reflect git status.
##
## Example:
##
##   user@host ~/projects/skynet master ⇡42
##   % █
##
## The current directory gets truncated from the left if the whole prompt doesn't fit on the line.
## PROMPT_FULL="$PROMPT_OPEN_BRACKETS$PROMPTUSERNAME$PROMPT_CLOSE_BRACKETS$PROMPT_OPEN_BRACKETS$PROMPTPATH$PROMPT_CLOSE_BRACKETS$_VCS_INFO_PROMPT$PROMPTDELIMITER"
## PS1="$PROMPT_FULL" PROMPT="$PROMPT_FULL" #PROMPT='%70F%n@%m%f # PROMPT+='%39F%$((-GITSTATUS_PROMPT_LEN-1))<…<%~%<<%f'



### }}}
### }}}
