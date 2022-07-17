symmetric-ctrl-z () {
  local usage=(
    "Use CTRL-z to bring background processes back to the foreground"
  )
  [[ $1 == "-h" ]] && printf "%s\n" $usage && return
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N symmetric-ctrl-z
bindkey '^Z' symmetric-ctrl-z
