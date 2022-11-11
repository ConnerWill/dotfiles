#shellcheck disable=2034


### [=========================================]
### [ ---------------- PROMPT --------------- ]
### [=========================================]

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
    RPS1="${RPROMPT}"
    export RPROMPT RPS1
  fi
}
_rprompt_set_ssh


