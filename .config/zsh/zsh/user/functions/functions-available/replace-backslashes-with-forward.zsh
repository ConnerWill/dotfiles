#shellcheck disable=2148

function replace-backslashes-with-forward(){
  print -r "${*}" | sed -e 's/\\/\//g' -e 's/^/\//'
}


# C:\Users\conner.will\AppData\Roaming\Notepad++\plugins
