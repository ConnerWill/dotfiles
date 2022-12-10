# ------------------------------------------------------------------------------
# Description
# ------------------------------------------------------------------------------
# 'cat $(' will be inserted before the command and ')' will be inserted
#  after the command when defined hotkey is pressed
#
#   After sourcing this file, run these commands to bind a hotkey:
#     bindkey -M emacs '\es' wrapwhich-command-line
#     bindkey -M vicmd '\es' wrapwhich-command-line
#     bindkey -M viins '\es' wrapwhich-command-line
#
#   ^  = [Ctrl]
#   \e = [Esc]
#   [  = [Alt]
#
#   Default hotkeys are set to: [Esc] s
#         ('[Esc]' then 's')
# ------------------------------------------------------------------------------
# Author
# ------------------------------------------------------------------------------
# * ConnerWill <github.com/ConnerWill>
# ------------------------------------------------------------------------------

__sudo-replace-buffer() {
  local old=$1 new=$2 space=${2:+ }
  if [[ ${#LBUFFER} -le ${#old} ]]; then
    RBUFFER="${space}${BUFFER#$old }"
    LBUFFER="${new}"
  else
    LBUFFER="${new}${space}${LBUFFER#$old }"
  fi
}

wrapwhich-command-line() {
  # If line is empty, get the last run command from history
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  # Save beginning space
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  # If $EDITOR is not set, just toggle the sudo prefix on and off
  if [[ -z "$EDITOR" ]]; then
    case "$BUFFER" in
      sudoedit\ *) __sudo-replace-buffer "sudoedit" "" ;;
      sudo\ *) __sudo-replace-buffer "sudo" "" ;;
      *) LBUFFER="sudo $LBUFFER" ;;
    esac
  else
    # Check if the typed command is really an alias to $EDITOR

    # Get the first part of the typed command
    local cmd="${${(Az)BUFFER}[1]}"
    # Get the first part of the alias of the same name as $cmd, or $cmd if no alias matches
    local realcmd="${${(Az)aliases[$cmd]}[1]:-$cmd}"
    # Get the first part of the $EDITOR command ($EDITOR may have arguments after it)
    local editorcmd="${${(Az)EDITOR}[1]}"

    # Note: ${var:c} makes a $PATH search and expands $var to the full path
    # The if condition is met when:
    # - $realcmd is '$EDITOR'
    # - $realcmd is "cmd" and $EDITOR is "cmd"
    # - $realcmd is "cmd" and $EDITOR is "cmd --with --arguments"
    # - $realcmd is "/path/to/cmd" and $EDITOR is "cmd"
    # - $realcmd is "/path/to/cmd" and $EDITOR is "/path/to/cmd"
    # or
    # - $realcmd is "cmd" and $EDITOR is "cmd"
    # - $realcmd is "cmd" and $EDITOR is "/path/to/cmd"
    # or
    # - $realcmd is "cmd" and $EDITOR is /alternative/path/to/cmd that appears in $PATH

    #shellcheck disable=1072,1036,1027,1073,1009
    if [[ "$realcmd" = (\$EDITOR|$editorcmd|${editorcmd:c}) \
     || "${realcmd:c}" = ($editorcmd|${editorcmd:c}) ]]     \
     || builtin which -a "$realcmd" | command grep -Fx -q "$editorcmd"; then
      editorcmd="$cmd" # replace $editorcmd with the typed command so it matches below
    fi

    # Check for editor commands in the typed command and replace accordingly
    case "$BUFFER" in
        $editorcmd\ *) __sudo-replace-buffer "$editorcmd" "sudoedit" ;;
        \$EDITOR\ *)   __sudo-replace-buffer '$EDITOR' "sudoedit"    ;;
        sudoedit\ *)   __sudo-replace-buffer "sudoedit" "$EDITOR"    ;;
        sudo\ *)       __sudo-replace-buffer "sudo" ""               ;;
        *)             LBUFFER="sudo $LBUFFER"                       ;;
    esac
  fi

  # Preserve beginning space
  LBUFFER="${WHITESPACE}${LBUFFER}"

  # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
  zle redisplay
}

zle -N wrapwhich-command-line

## Defined shortcut keys: [Esc] [Esc]
#bindkey -M emacs '\e\e' wrapwhich-command-line
#bindkey -M vicmd '\e\e' wrapwhich-command-line
#bindkey -M viins '\e\e' wrapwhich-command-line

# Defined shortcut keys: [Esc] s
bindkey -M emacs '\es' wrapwhich-command-line
bindkey -M vicmd '\es' wrapwhich-command-line
bindkey -M viins '\es' wrapwhich-command-line
