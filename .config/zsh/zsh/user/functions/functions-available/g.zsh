
#### View all README-like files in current directory in pager

## Will need to add this
#    emulate -L zsh
#    setopt extendedglob
#    local files
#    files=(./(#i)*(read*me|lue*m(in|)ut|lies*mich)*(NDr^/=p%))
#    if (($#files)) ; then
#      $PAGER $files
#    else
#      print 'No README files.'
#    fi







funciton g(){

  local RICHTHEME="dracula"
  # local RICHTHEME="rrt"
  # local RICHTHEME="vim"
  # local RICHTHEME="stata-dark"
  # local RICHTHEME="one-dark"

  [[ -z "$RICHTHEME" ]] \
    && local RICHTHEME="one-dark"
  
  local INPUTFILE="$1"
  [[ -z "$INPUTFILE" ]] \
    && INPUTFILE=$(realpath $(find $(pwd) -name 'README.md')) 

 # echo "$INPUTFILE"

  [[ ! -f "$INPUTFILE" ]] \
    && _G_ERRORMSG 3 "$INPUTFILE"

  rich \
    --markdown \
      --theme "$RICHTHEME" \
        --padding 1,5,1,5 \
        --panel rounded \
          --hyperlinks \
          --line-numbers \
          --center \
          --text-full \
          --pager \
    "$INPUTFILE"
}

function _G_ERRORMSG(){

  local ERRORNUM="$1"
  local INPUTFILE="$2"
  
  [[ -z "$ERRORNUM" ]] \
    && local OUTPUTMSG="UNKNOWN ERROR running script"

  [[ "$ERRORNUM" == 1 ]] \
    && local OUTPUTMSG="ERROR: 'rich' is not installed or in PATH\n\tInstall rich using pipx install rich"

  [[ "$ERRORNUM" == 2 ]] \
    && local OUTPUTMSG="ERROR: No file provided"

  [[ "$ERRORNUM" == 3 ]] \
    && local OUTPUTMSG="ERROR: Cannot find file"

  [[ "$ERRORNUM" == 4 ]] \
    && local OUTPUTMSG="ERROR: 4"

  [[ "$ERRORNUM" == 5 ]] \
    && local OUTPUTMSG="ERROR: 5"

  echo -e "\n$OUTPUTMSG\n"
#  return

}

#3alias g="_render_rich_markdown"
#alias md="_render_rich_markdown"
#echo "\n'g' sourced\n\nUsage:\n\t$  g <file>\n"





