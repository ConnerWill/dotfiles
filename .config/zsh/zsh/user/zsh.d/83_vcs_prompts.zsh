# shellcheck disable=2148,2016,2182,1087,2154

### [===============================]
### [ --------- ZSH PROMPT -------- ]
### [===============================]
###{{{ about
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
###}}} about

### [===============================]
### [ ------- SETUP PROMPT -------- ]
### [===============================]
### {{{ SETUP PROMPT
## CHECK TERMINAL SUPPORTS 256 colors, if not, load zshmodule "zsh/nearcolor"
## The zsh/nearcolor module replaces colours specified as hex triplets with the nearest
## colour in the 88 or 256 colour palettes that are widely used by terminal emulators.
autoload -U promptinit ; promptinit
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
setopt PROMPT_SUBST

### SETUP PROMPT }}}

### [===============================]
### [ ---------- PROMPT ----------- ]
### [===============================]
### {{{ STANDARD PROMPT
# PROMPTATSYMBOL='%F{201}@%f'
# PROMPTHOSTNAME='%F{8}%m%f'
# PROMPTHOSTNAME='%F{99}%M%f'
# PROMPTPATH='%F{66}%40<..<%~%<<'
# PROMPTUSERNAME='%F{99}%n%f'
# PROMPT_CLOSE_BRACKETS='%F{51}%B]%b%f'
# PROMPT_OPEN_BRACKETS='%F{51}%B[%b%f'

## PROMPT COLORS
##   color are ANSI color numbers
PROMPT_COLOR_ATSYMBOL="${PROMPT_COLOR_ATSYMBOL:-201}"
PROMPT_COLOR_HOSTNAME="${PROMPT_COLOR_HOSTNAME:-99}"
PROMPT_COLOR_PATH="${PROMPT_COLOR_PATH:-60}"
PROMPT_COLOR_USERNAME="${PROMPT_COLOR_USERNAME:-99}"
PROMPT_COLOR_BRACKETS="${PROMPT_COLOR_BRACKETS:-51}"

PROMPT_RAINBOW_DELIMITER="${PROMPT_RAINBOW_DELIMITER:-true}"

export PROMPT_COLOR_ATSYMBOL PROMPT_COLOR_HOSTNAME PROMPT_COLOR_PATH PROMPT_COLOR_USERNAME PROMPT_COLOR_BRACKETS PROMPT_RAINBOW_DELIMITER

PROMPTATSYMBOL="%F{${PROMPT_COLOR_ATSYMBOL}}@%f"
PROMPTHOSTNAME="%F{${PROMPT_COLOR_HOSTNAME}}%M%f"
PROMPTPATH="%F{${PROMPT_COLOR_PATH}}%40<..<%~%<<"
PROMPTUSERNAME="%F{${PROMPT_COLOR_USERNAME}}%n%f"
PROMPT_CLOSE_BRACKETS="%F{${PROMPT_COLOR_BRACKETS}}%B]%b%f"
PROMPT_OPEN_BRACKETS="%F{${PROMPT_COLOR_BRACKETS}}%B[%b%f"

if [[ "${PROMPT_RAINBOW_DELIMITER}" == "true" ]]; then
  [[ -o PROMPT_SUBST ]] \
    && PROMPTDELIMITER=$'%{\e[$((color=$((30+$RANDOM % 8))))m%}:%{\e[00m%} ' \
    || PROMPTDELIMITER=': ' # Random color delimiter ':'
else
  PROMPTDELIMITER=": "
fi

### STANDARD PROMPT }}}

### [===============================]
### [ --------- RPROMPT ----------- ]
### [===============================]
###{{{ SSH
unset RPS1
function _rprompt_set_ssh(){
  if [[ "$SSH_CLIENT" = *.* || "$REMOTEHOST" = *.* ]]; then
    setopt TRANSIENT_RPROMPT
    local RPROMPT_SSH_COLOR RPROMPT_SSH_COLOR_RESET RPROMPT_SSH
    RPROMPT_SSH_COLOR='%F{237}'
    RPROMPT_SSH_COLOR_RESET='%f'
    RPROMPT_SSH="${RPROMPT_SSH_COLOR}${SSH_CLIENT}${RPROMPT_SSH_COLOR_RESET}"
    RPROMPT="${RPROMPT_SSH}"
    RPS1="${RPS1} ${RPROMPT}"
    export RPROMPT RPS1
  fi
}
_rprompt_set_ssh

## If connected via ssh, show hostname, otherwise only show username.
# if [[ -z "${SSH_CLIENT}" ]]; then
  # unset PROMPTATSYMBOL PROMPTHOSTNAME
# else
# fi

###}}} SSH

### [===============================]
### [ ----- EXIT CODE PROMPT ------ ]
### [===============================]
### {{{ EXIT CODE PROMPT
if [[ -o PROMPT_SUBST ]]; then
  function check_last_exit_code() {
    local LAST_EXIT_CODE
    LAST_EXIT_CODE=$?
    if [[ $LAST_EXIT_CODE -ne 0 ]]; then
      EXIT_CODE_PROMPT=' '
      EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
      EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
      EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
      export EXIT_CODE_PROMPT
    else
      unset EXIT_CODE_PROMPT
    fi
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd check_last_exit_code
fi
# ------------------------------------------------------------------
### EXIT CODE PROMPT }}}

### [===============================]
### [ -------- GIT PROMPT --------- ]
### [===============================]
###{{{ GIT PROMPT
if [[ -o PROMPT_SUBST ]]; then
  function _prompt_set_git(){
    setopt PROMPT_SUBST
    autoload -Uz vcs_info
    zstyle ':vcs_info:*'              disable bzr cdv darcs mtn svk tla
    zstyle ':vcs_info:*'              formats       '%f%F{190}:%f%F{5}(%f%F{15}%r%f%F{5})%f'
    zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat  '%b%F{1}:%F{3}%r'
    precmd(){ vcs_info; }
  }; _prompt_set_git

  function gitstatus(){
    local                                                \
      branch closebracket color color_reset commit_diffs \
      dash deleted icon_branch icon_commits_ahead        \
      icon_commits_behind icon_deleted icon_modified     \
      icon_staged icon_untracked modified openbracket    \
      output remote staged true_output untracked

    if is_in_git_repository; then
      unset PROMPT_PATH PROMPTPATH
      typeset -g PROMPT_PATH PROMPTPATH
    else
      typeset -g PROMPTPATH='%F{66}%40<..<%~%<<'
      return 1
    fi

    icon_commits_behind="⋄"
    icon_commits_ahead="⋆"
    icon_branch=""
    icon_modified="⊕${modified}"
    icon_staged="⥉${staged}"
    icon_deleted="⊝${deleted}"
    icon_untracked="⊙${untracked}"
    openbracket="%f%F{5}[%f"
    closebracket="%f%F{5}]%f"
    dash="%f%F{190}-%f"
    color_reset="%f%b%u%k"

    parse_git_status
    modified="${STATUS[1]}"
    staged="${STATUS[2]}"
    deleted="${STATUS[3]}"
    untracked="${STATUS[4]}"
    unset STATUS

    git_grab_current_branch; branch="${REPLY}"
    git_grab_remote_branch ; remote="${REPLY}"

    [[ -n "$remote" ]] && git_local_remote_diffs "$branch" "$remote" && commit_diffs="$REPLY"

    git_determine_color $((modified + staged + deleted + untracked))
    color="${REPLY}"

    (( modified > 0  )) &&  modified="${icon_modified}${modified}"
    (( staged > 0    )) &&    staged="${icon_staged}${staged}"
    (( deleted > 0   )) &&   deleted="${icon_deleted}${deleted}"
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

    [[ "$1" == "-i" ]] && true_output+=""

    true_output+=$'%F{default}'; echo "${true_output}"
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
    git status --porcelain=v1 \
      | while IFS= read -r status_line; do
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
    STATUS=(
      "${modified}"
      "${staged}"
      "${deleted}"
      "${untracked}"
    )
    return 0
  }

  ###
  # Look at how many commits a local branch is ahead/behind of remote branch
  # Arguments:    $1 local branch
  #               $2 remote branch
  ###
  function git_local_remote_diffs(){
    local local_branch remote_branch differences commits_ahead commits_behind ahead behind result

    local_branch="$1"
    remote_branch="$2"

    differences="$(git rev-list --left-right --count ${local_branch}...${remote_branch})"
    commits_ahead=$(echo -n "${differences}" | awk '{print $1}')
    commits_behind=$(echo -n "${differences}" | awk '{print $2}')
    ahead=""
    behind=""
    result=""

    (( commits_ahead > 0  )) && ahead="${icon_commits_ahead}${commits_ahead}"
    (( commits_behind > 0 )) && behind="${icon_commits_behind}${commits_behind}"

    [[ -n "${ahead}" ]] && result="${ahead}"
    [[ -n "${behind}" ]] && result="${behind}"
    typeset -g REPLY="${result}"
  }

  ###
  # If there is anything that changed from the past commit, return yellow.
  # Otherwise, green.
  # Arguments:    list of how many things changed
  ###
  function git_determine_color(){
    if (( $1 > 0 )); then
      typeset -g REPLY=$'%F{196}%B'
    else
      typeset -g REPLY=$'%F{46}'
    fi
  }

  #shellcheck disable=2016
  _VCS_INFO_PROMPT='${vcs_info_msg_0_}$(gitstatus -i)'
  # shellcheck disable=2154,2034
  GITPROMPT="{$vcs_info_msg_0_}"
fi
# ------------------------------------------------------------------
###}}} GIT PROMPT

### [===============================]
### [ ------- OTHER PROMPT -------- ]
### [===============================]
###{{{ PROMPT ICONS
typeset -A distro_logos
typeset -A distro_logo_color
#shellcheck disable=2190,2034
distro_logos=(
 "Arch"       "  "
 "Manjaro"    "  "
 "Gentoo"     "  "
 "Debian"     "  "
 "Raspbian"   "  "
 "Linuxmint"  "  "
 "Ubuntu"     "  "
 "Android"     ""
 "wsl"        "  "
 "Freebsd"    "  "
 "Openbsd"    " 🐡 "
 "Darwin"     "  "
 "other"       "@"
)

#shellcheck disable=2190,2034
distro_logo_color=(
 "Arch"       39
 "Manjaro"    10
 "Gentoo"     141
 "Debian"     196
 "Raspbian"   196
 "Linuxmint"  85
 "Ubuntu"     208
 "Android"    10
 "wsl"        255
 "Freebsd"    196
 "Openbsd"    190
 "Darwin"     255
 "other"      201
)

[[ -z "${DISTRO}" ]] && DISTRO="other"
PROMPTATSYMBOL='%F{$distro_logo_color[$DISTRO]}$distro_logos[$DISTRO]%f'

###}}} PROMPT ICONS

###{{{ Replace hostname and username in prompt
function replacehostnameinprompt(){
  export PROMPTUSERNAME PROMPTHOSTNAME PROMPTATSYMBOL

## android
  [[ \
   (( "${DISTRO}" == "Android" || "$(uname -n)" == "android" )) \
     && $(whoami) == "u0_a119" \
  ]] \
      && PROMPTHOSTNAME='' \
      && unset PROMPTUSERNAME #\

## archdesk
  [[ \
     $(uname -n) == "archdesk"  \
    && $(whoami) == "dampsock" \
  ]] \
      && unset PROMPTHOSTNAME && unset PROMPTATSYMBOL

## archbox
  [[ \
     $(uname -n) == "archbox"  \
    && $(whoami) == "dampsock" \
  ]] \
      && unset PROMPTUSERNAME #&& unset PROMPTHOSTNAME

  [[ $(uname -n) == "connerwill.com" ]] \
	  && local randcolor1=$(shuf --input-range=1-235 --head-count=1) \
	  && local randcolor2=$(( 255 - randcolor1 )) \
	  && PROMPTHOSTNAME="%F{$randcolor1}%M%f" \
	  && PROMPTUSERNAME="%F{$(date +'%H')$(shuf --input-range=0-9 --head-count=1)}%n%f"
	  #&& PROMPTUSERNAME="%F{$randcolor2}%n%f"

  [[ $(uname -n) == "dampsock.com" ]] \
	  && local randcolor1=$(shuf --input-range=1-235 --head-count=1) \
	  && local randcolor2=$(shuf --input-range=1-235 --head-count=1) \
	  && local randcolor3=$(shuf --input-range=1-235 --head-count=1) \
	  && PROMPTHOSTNAME="%F{$randcolor1}%M%f" \
	  && PROMPTUSERNAME="%F{$randcolor2}%n%f" \
    && PROMPT_CLOSE_BRACKETS="%F{$randcolor3}%B]%b%f" \
    && PROMPT_OPEN_BRACKETS="%F{$randcolor3}%B[%b%f"
	  #&& PROMPTUSERNAME="%F{$randcolor2}%n%f"

## rpi
  [[ \
     $(whoami) == "pi" \
  ]] \
      && PROMPTATSYMBOL='%F{$distro_logo_color[Raspbian]}$distro_logos[Raspbian]%f'

}; replacehostnameinprompt; unset -f replacehostnameinprompt
###}}} Replace hostname and username in prompt

###{{{ Prompt: PLAN B
function backup_prompt_incase_of_failure(){
  ## Set a prompt in case of failure
  printf "\e[0;1;38;5;196mError whilst loading prompt :,(\t\e[0;1;38;5;8mUsing a default prompt instead ;)\n"
  #shellcheck disable=2078,2057,2050
  if [[ autoload -Uz promptinit && promptinit ]] && [[ autoload -Uz colors && colors ]]; then
    return 0
  else
    if prompt fire blue magenta blue black green cyan || prompt adam2; then
      return 0
    else
      printf "\e[0;1;38;5;196m The backup prompt failed to load ... >:(\e[0;1;38;5;201m\n\n\tWell... you are on your own now, buddy :0\n"
      PROMPT='%F{196}(╯°□°）╯︵ ┻━┻%f %F{93}[>:%f ' \
      RPROMPT='%F{87}(⌐■_■)%f  %F{46}¯\_(ツ)_/¯%f'
      export PROMPT RPROMPT
    fi
  fi
}
###}}} Prompt: PLAN B

### [===============================]
### [ ------ COMBINE PROMPT ------- ]
### [===============================]
###{{{ Create PROMPT
function define_combine_prompt(){
  ## 'Stich' all parts of the PS1 (prompt) together
  export PROMPT PS1
  PROMPT_EXIT_CODE='$EXIT_CODE_PROMPT'
  PROMPT_USER_HOST="$PROMPT_OPEN_BRACKETS$PROMPTUSERNAME$PROMPTATSYMBOL$PROMPTHOSTNAME$PROMPT_CLOSE_BRACKETS"
  PROMPT_PATH="$PROMPT_OPEN_BRACKETS$PROMPTPATH$PROMPT_CLOSE_BRACKETS"
  PROMPT_USER_HOST_PATH="$PROMPT_USER_HOST$PROMPT_PATH"
  PROMPT_FULL="$PROMPT_EXIT_CODE$PROMPT_USER_HOST_PATH$_VCS_INFO_PROMPT$PROMPTDELIMITER"
  PROMPT="$PROMPT_FULL"
  PS1="$PROMPT_FULL"
}
define_combine_prompt || backup_prompt_incase_of_failure
unset -f define_combine_prompt
unset -f backup_prompt_incase_of_failure

unset \
  EXIT_CODE_PROMPT PROMPT_EXIT_CODE            \
  PROMPTUSERNAME PROMPTATSYMBOL PROMPTHOSTNAME \
  PROMPTPATH PROMPT_PATH                       \
  PROMPT_USER_HOST PROMPT_USER_HOST_PATH       \
  PROMPTDELIMITER                              \
  PROMPT_CLOSE_BRACKETS PROMPT_OPEN_BRACKETS   \
  PROMPT_FULL

###}}} Create PROMPT
