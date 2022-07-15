####################################################
#                                                  #
# Maintainer: Matheus Teixeira <me@mteixeira.me>   #
# Website: http://mteixeira.me                     #
# Github: https://github.com/mtxr/zsh-change-case  #
#                                                  #
####################################################

_mtxr-change-case () {
  local ORIG_CASE=$1
  local DEST_CASE=$2
  local WLEFTCURSOR="${LBUFFER/* /}"
  local WRIGHTCURSOR="${RBUFFER/ */}"
  local CURRENTWORD="${WLEFTCURSOR}${WRIGHTCURSOR}"
  local BEFOREWORD="${LBUFFER:0:($(( $CURSOR - $#WLEFTCURSOR)))}"
  local AFTERWORD="${RBUFFER:($#WRIGHTCURSOR)}"

  CURRENTWORD=$(echo "$CURRENTWORD" | tr "[:$ORIG_CASE:]" "[:$DEST_CASE:]")
  LBUFFER="${BEFOREWORD}${CURRENTWORD}"
  RBUFFER="${AFTERWORD}"
  zle redisplay
}

_mtxr-to-upper () {
  zle _mtxr-change-case -- 'lower' 'upper'
}

_mtxr-to-lower () {
  zle _mtxr-change-case -- 'upper' 'lower'
}
#
zle -N _mtxr-change-case
zle -N _mtxr-to-upper
zle -N _mtxr-to-lower

# suggested default bind keys

bindkey -r '^K'   # to remove [Ctrl+K] binding if needed
bindkey '^K^U' _mtxr-to-upper
bindkey '^K^L' _mtxr-to-lower
