## Split '$FPATH' with new lines
function fpathnewlines(){
  echo "${fpath//:/$'\n'}"
}
alias fpath-echo='fpathnewlines'
alias echo-fpath='fpathnewlines'

## Split '$FPATH' with new lines
function pathnewlines(){
  echo "${PATH//:/$'\n'}"
}
alias path-echo='pathnewlines'
alias echo-path='pathnewlines'


