## Split '$fpath' with new lines
function fpathnewlines(){
  print -l ${fpath}
}

## Split '$FPATH' with new lines
function pathnewlines(){
  [[ -n "$ZSH_VERSION" ]] && print -l ${path}
  [[ -n "$BASH_VERSION" ]] && echo "${PATH//:/$'\n'}"
}
