#### View all README-like files in current directory in pager

g(){
  _G_ERRORMSG(){
    local -i ERRORNUM ORIGSTATUS
    local INPUTFILE OUTPUTMSG
    ERRORNUM=$1 ORIGSTATUS=$2 INPUTFILE="${3}"
    [[ -z "$ERRORNUM"   ]] && OUTPUTMSG="UNKNOWN ERROR running script"
    [[ "$ERRORNUM" == 1 ]] && OUTPUTMSG="ERROR: 'rich' is not installed or in PATH\n\tInstall rich using pipx install rich"
    [[ "$ERRORNUM" == 2 ]] && OUTPUTMSG="ERROR: No file provided"
    [[ "$ERRORNUM" == 3 ]] && OUTPUTMSG="ERROR: Cannot find file"
    [[ "$ERRORNUM" == 4 ]] && OUTPUTMSG="ERROR: 4"
    [[ "$ERRORNUM" == 5 ]] && OUTPUTMSG="ERROR: 5"
    printf "\n\e[0;1;38;5;196m%s\n%s\e[0m\n" $ORIGSTATUS "${OUTPUTMSG}"
   return $ORIGSTATUS
  }

  _viewmarkdown_rich(){
    INPUTFILE="${*}"
    RICHTHEME="dracula"
    [[ -z "$RICHTHEME" ]] && RICHTHEME="one-dark"
     rich                                 \
        --markdown --theme "${RICHTHEME}" \
        --padding 1,5,1,5 --panel rounded \
        --line-numbers                    \
        --center --text-full      \
       "${INPUTFILE}"
# --pager
# --hyperlinks
  }

  _viewmarkdown_glow(){
    INPUTFILE="${*}"
    [[ -z "$RICHTHEME" ]] && RICHTHEME="one-dark"
    glow "${INPUTFILE}"
  }

  local INPUTFILE RENDERER

  INPUTFILE="${*}"
  RENDERER="rich" #glow,rich

  [[ "${1}" == "rich" ]] && RENDERER="rich"
  [[ "${1}" == "glow" ]] && RENDERER="glow"
  [[ -z "${commands[$RENDERER]}" ]] && _G_ERRORMSG 1 $? && return 1
  # [[ -z "$INPUTFILE"        ]] && INPUTFILE="-h"
  # [[ ! -f "$INPUTFILE"      ]] && _G_ERRORMSG 3 $? "${INPUTFILE}" && return 1

  _viewmarkdown_$RENDERER "${INPUTFILE[@]}"
  # _viewmarkdown_$RENDERER "${INPUTFILE}"

  unfunction _G_ERRORMSG _viewmarkdown_rich _viewmarkdown_glow
}



#3alias g="_render_rich_markdown"
#alias md="_render_rich_markdown"
#echo "\n'g' sourced\n\nUsage:\n\t$  g <file>\n"

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
