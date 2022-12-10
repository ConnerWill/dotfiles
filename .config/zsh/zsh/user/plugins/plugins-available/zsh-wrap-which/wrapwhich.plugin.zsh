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

wrapwhich-command-line() {
  [[ -z $BUFFER ]] && zle up-history
  if [[ -n "$OLDBUFFER" ]]; then
    BUFFER="$OLDBUFFER"
    CURSOR=$OLDCURSOR
    unset OLDCURSOR OLDBUFFER
    # zle -U i
  else
    OLDBUFFER=$BUFFER
    OLDCURSOR=$CURSOR
    BUFFER=" \$(which ${BUFFER})"
    CURSOR=0
    # zle -U i
  fi
  # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
  zle redisplay
}
zle -N wrapwhich-command-line
# Defined shortcut keys: [Esc|Alt] w
bindkey -r '^[w'
bindkey -r '\ew'
bindkey -M vicmd '\ew' wrapwhich-command-line
bindkey -M emacs '\ew' wrapwhich-command-line
bindkey -M viins '\ew' wrapwhich-command-line
