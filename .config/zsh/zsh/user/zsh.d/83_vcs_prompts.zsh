# shellcheck disable=2148,2016,2182,1087,2154

#timelogging_start "83"

### [=========================================]
### [ ---------------- PROMPT --------------- ]
### [=========================================]
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

### [===============================]
### [ ------- SETUP PROMPT -------- ]
### [===============================]
### {{{ SETUP PROMPT
autoload -U promptinit
promptinit
setopt prompt_subst
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
### SETUP PROMPT }}}

### [===============================]
### [ ---------- PROMPT ----------- ]
### [===============================]
### {{{ STANDARD PROMPT
unset RPS1
  PROMPT_OPEN_BRACKETS='%F{51}%B[%b%f'
 PROMPT_CLOSE_BRACKETS='%F{51}%B]%b%f'
        PROMPTUSERNAME='%F{99}%n%f'
        PROMPTHOSTNAME='%F{8}%m%f'
        PROMPTATSYMBOL='%F{201}@%f'
       PROMPTDELIMITER=$'%{\e[$((color=$((30+$RANDOM % 8))))m%}:%{\e[00m%} '

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
 "Android"    "  "
 "wsl"        "  "
 "Freebsd"    "  "
 "Openbsd"    " 🐡 "
 "Darwin"     "  "
 "other"      "@"
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


if [[ "${DISTRO}" == "Android" ]]; then
 #clear; for i in $(seq 100 -10 0); do ~/battery.zsh $i && sleep 0.5 && clear; done
  function _rprompt_termux_battery(){
    export RPS1 TERMUX_BATTERY_STATUS TERMUX_BATTERY_PERCENTAGE
    typeset -A battery_icon_array
    typeset -A battery_charging_icon_array
    typeset -A battery_horizontal_icon_array

    #shellcheck disable=2190,2034
    # Vertical battery
    battery_icon_array=(
      "100" ""
      "90"  ""
      "80"  ""
      "70"  ""
      "60"  ""
      "50"  ""
      "40"  ""
      "30"  ""
      "20"  ""
      "10"  ""
      "0"   ""
    )

    #shellcheck disable=2190,2034
    # Vertical Charging battery
    battery_charging_icon_array=(
      "100" ""
      "90"  ""
      "80"  ""
      "60"  ""
      "40"  ""
      "30"  ""
      "20"  ""
      "10"  ""
    )

    #shellcheck disable=2190,2034
    # horizontal battery
    battery_horizontal_icon_array=(
      "100" ""
      "75"  ""
      "50"  ""
      "25"  ""
      "0"   ""
    )


    #TERMUX_BATTERY_STATUS="$(termux-battery-status)"
    #TERMUX_BATTERY_PERCENTAGE="$(echo "${TERMUX_BATTERY_STATUS}" | grep 'percentage' | cut --delimiter=':' -f2)"

    TERMUX_BATTERY_PERCENTAGE="${*}"

    BATT_ICON="${battery_charging_icon_array[$TERMUX_BATTERY_PERCENTAGE]}"
    printf "Batt: %s\n" "${BATT_ICON}"

   }; _rprompt_termux_battery "${@}"
fi

## CHECK TERMINAL SUPPORTS 256 colors, if not, load zshmodule "zsh/nearcolor"
## The zsh/nearcolor module replaces colours specified as hex triplets with the nearest
## colour in the 88 or 256 colour palettes that are widely used by terminal emulators.
autoload -U promptinit ; promptinit
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
setopt PROMPT_SUBST

PROMPT_OPEN_BRACKETS='%F{51}%B[%b%f'
PROMPT_CLOSE_BRACKETS='%F{51}%B]%b%f'
PROMPTHOSTNAME='%F{99}%m%f'
PROMPTUSERNAME='%F{99}%n%f'
PROMPTPATH='%F{66}%40<..<%~%<<'
PROMPTDELIMITER=$'%{\e[$((color=$((30+$RANDOM % 8))))m%}:%{\e[00m%} ' # Random color delimiter ':'








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
### STANDARD PROMPT }}}


### [=========================================]
### [ ---------- EXIT CODE PROMPT ----------- ]
### [=========================================]
### {{{ EXIT CODE PROMPT
setopt prompt_subst

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
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
# ------------------------------------------------------------------
### EXIT CODE PROMPT }}}

function _prompt_set_git(){
  setopt PROMPT_SUBST
  autoload -Uz vcs_info
  zstyle ':vcs_info:*'              disable bzr cdv darcs mtn svk tla
  zstyle ':vcs_info:*'              formats       '%f%F{190}:%f%F{5}(%f%F{15}%r%f%F{5})%f'
  zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat  '%b%F{1}:%F{3}%r'
  precmd () {
    vcs_info
  }
}; _prompt_set_git

function gitstatus(){

  local \
    branch              \
    closebracket        \
    color               \
    color_reset         \
    commit_diffs        \
    dash                \
    deleted             \
    icon_branch         \
    icon_commits_ahead  \
    icon_commits_behind \
    icon_deleted        \
    icon_modified       \
    icon_staged         \
    icon_untracked      \
    modified            \
    openbracket         \
    output              \
    remote              \
    staged              \
    true_output         \
    untracked

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

    [[ -n "$remote" ]] \
        && git_local_remote_diffs "$branch" "$remote" \
        && commit_diffs="$REPLY"

    git_determine_color $((modified + staged + deleted + untracked))
    color="${REPLY}"

     (( modified > 0 )) &&  modified="${icon_modified}${modified}"
       (( staged > 0 )) &&    staged="${icon_staged}${staged}"
      (( deleted > 0 )) &&   deleted="${icon_deleted}${deleted}"
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
        typeset -g REPLY=$'%F{196}%B'
    else
        typeset -g REPLY=$'%F{46}'
    fi
}

#shellcheck disable=2016
_VCS_INFO_PROMPT='${vcs_info_msg_0_}$(gitstatus -i)'
       # shellcheck disable=2154,2034
       GITPROMPT="{$vcs_info_msg_0_}"
# ------------------------------------------------------------------
### GIT PROMPT }}}

### [===============================]
### [ ---------- PROMPT ----------- ]
### [===============================]


function replacehostnameinprompt(){
## Replace 'localhost' with a different "hostname" in the prompt
  local newhostname
  newhostname="termux"
  [[ $(uname -n) == "archlinux" && $(whoami) == "u0_a119" ]] && PROMPTHOSTNAME='%F{99}$newhostname%f'
  export PROMPTHOSTNAME
}; replacehostnameinprompt; unset -f replacehostnameinprompt

function backup_prompt_incase_of_failure(){
  ## Set a prompt in case of failure
  printf "\e[0;1;38;5;196mError whilst loading prompt :,(\t\e[0;1;38;5;8mUsing a default prompt instead ;)\n"
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

define_combine_prompt \
  && unset -f define_combine_prompt \
  || backup_prompt_incase_of_failure
unset -f backup_prompt_incase_of_failure


#timelogging_end 83






## cool prompt features 
# The first step is to configure the appearance of the prompt in its compact form. Let’s assume we have a variable, $_vbe_prompt_compact set to 1 when we want a compact prompt. We use the following function to define the prompt appearance:
#
# _vbe_prompt () {
#     local retval=$?
#
#     # When compact, just time + prompt sign
#     if (( $_vbe_prompt_compact )); then
#         # Current time (with timezone for remote hosts)
#         _vbe_prompt_segment cyan default "%D{%H:%M${SSH_TTY+ %Z}}"
#         # Hostname for remote hosts
#         [[ $SSH_TTY ]] && \
#             _vbe_prompt_segment black magenta "%B%M%b"
#         # Status of the last command
#         if (( $retval )); then
#             _vbe_prompt_segment red default ${PRCH[reta]}
#         else
#             _vbe_prompt_segment green cyan ${PRCH[ok]}
#         fi
#         # End of prompt
#         _vbe_prompt_end
#         return
#     fi
#
#     # Regular prompt with many information
#     # […]
# }
# setopt prompt_subst
# PS1='$(_vbe_prompt) '
# Update (2021-05)
#
# The following part has been rewritten to be more robust. The code is stolen from Powerlevel10k’s issue #888. See the comments for more details.
#
# Our next step is to redraw the prompt after accepting a command. We wrap Zsh line editor into a function:
#
# _vbe-zle-line-init() {
#     [[ $CONTEXT == start ]] || return 0
#
#     # Start regular line editor
#     (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[1]
#     zle .recursive-edit
#     local -i ret=$?
#     (( $+zle_bracketed_paste )) && print -r -n - $zle_bracketed_paste[2]
#
#     # If we received EOT, we exit the shell
#     if [[ $ret == 0 && $KEYS == $'\4' ]]; then
#         _vbe_prompt_compact=1
#         zle .reset-prompt
#         exit
#     fi
#
#     # Line edition is over. Shorten the current prompt.
#     _vbe_prompt_compact=1
#     zle .reset-prompt
#     unset _vbe_prompt_compact
#
#     if (( ret )); then
#         # Ctrl-C
#         zle .send-break
#     else
#         # Enter
#         zle .accept-line
#     fi
#     return ret
# }
# zle -N zle-line-init _vbe-zle-line-init
# That’s all!
#
# One downside of using the powerline fonts is that it messes with copy/paste. As I am using tmux, I use the following snippet to work around this issue and use only standard Unicode characters when copying from the terminal:
#
# bind-key -T copy-mode M-w \
#   send -X copy-pipe-and-cancel "sed 's/.*/%/g' | xclip -i -selection clipboard" \;\
#   display-message "Selection saved to clipboard!"
# Copying and pasting the text from the screenshot above yields the following text:
#
# ssh eizo.luffy.cx
# Linux eizo 4.19.0-16-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64
# Last login: Fri Apr 23 14:20:39 2021 from 2a01:cb00:3f:b02:9db6:efa4:d85:7f9f
# uname -a
# Linux eizo 4.19.0-16-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64 GNU/Linux
#
# Connection to eizo.luffy.cx closed.
# git status
# On branch article/zsh-transient
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#         ../../media/images/zsh-compact-prompt@2x.jpg
#
# nothing added to commit but untracked files present (use "git add" to track)
# We have to manually enable bracketed paste because Zsh does it after zle-line-init. ↩︎












