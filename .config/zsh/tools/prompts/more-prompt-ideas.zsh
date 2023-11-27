###{{{ Android
if [[ "${DISTRO}" == "Android" ]]; then
 #clear; for i in $(seq 100 -10 0); do ~/battery.zsh $i && sleep 0.5 && clear; done
  function _rprompt_termux_battery(){
    export RPS1 TERMUX_BATTERY_STATUS TERMUX_BATTERY_PERCENTAGE TERMUX_BATTERY_PERCENTAGE_short
    typeset -Ag battery_icon_array
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


    TERMUX_BATTERY_STATUS="$(termux-battery-status)"
    #shellcheck disable=2082
    TERMUX_BATTERY_PERCENTAGE="${$(echo "${TERMUX_BATTERY_STATUS}" | grep 'percentage' | cut --delimiter=':' -f2)}"
    TERMUX_BATTERY_PERCENTAGE_short="${TERMUX_BATTERY_STATUS[2]}"

    #TERMUX_BATTERY_PERCENTAGE="${*}"

    BATT_ICON="${battery_charging_icon_array[${TERMUX_BATTERY_PERCENTAGE_short}]}"
    # printf "Batt: %s\n" "${BATT_ICON}"
    printf "\e[?25l"
    for i in "${battery_icon_array[@]}"; do
      printf "\e[2K\r%s" "${i}"; sleep 0.01
    done
    printf "\e[?25h"

   }
   #_rprompt_termux_battery "${@}"
fi

###}}} Android

###{{{ Other: (commented out)
###############################################################

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

###}}} Other: (commented out)
