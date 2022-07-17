



function man2html(){

  local MANSEARCH="$1"
  [[ -z "$MANSEARCH" ]] \
    && _man2ERROR 1 "No Search Query ..." \
#      || return 1
  
  man --html=cat "$MANSEARCH" 
#    || _man2ERROR \
#      || return 1
  


  #manpage-pacman.conf.md && g manpage-pacman.conf.md
}

function man2md(){

  local MANSEARCH="$1"
  [[ -z "$MANSEARCH" ]] \
    && _man2ERROR 1 "No Search Query ..." \
#      || return 1
  
  local HTML2TEXT=$(which html2text)
  man --html=cat "$MANSEARCH" \
    | ${HTML2TEXT} \
      # _man2ERROR #      && return 1
  

  #manpage-pacman.conf.md && g manpage-pacman.conf.md
}

function man2pdf(){

  local MANSEARCH="$1"
  [[ -z "$MANSEARCH" ]] \
    && printf "No Search Query ..." \
      && return 1
  
  local HTML2TEXT=$(which html2text)
  man --html=cat "$MANSEARCH" \
    | ${HTML2TEXT}

  #manpage-pacman.conf.md && g manpage-pacman.conf.md
}

function _man2ERROR (){
  local ERRORACTION="$1"
  local ERRORMSG="$2"

  [[ -z "$ERRORMSG" ]] \
    && printf "Unknown Error\n" \
      && return 1

  [[ "$ERRORACTION" -eq 0 ]] \
    && printf "Unknown Error\n" \
      && return 0

  [[ "$ERRORACTION" -eq 1 ]] \
    && printf "No Search Query ..." \
      && return 1
}
function man2pdf(){

    local MANSEARCH="$1" && man -t "$MANSEARCH" | ps2pdf - "$HOME/Documents/$MANSEARCH-man-page.pdf" && echo "$HOME/Documents/$MANSEARCH-man-page-pdf"

    }

# function man2pdf(){local MANSEARCH="$1" && man -t "$MANSEARCH" | ps2pdf - "~/Documents/$MANSEARCH-man-page.pdf" && echo "$HOME/Documents/$MANSEARCH-man-page-pdf"}
# function man2pdf(){local MANSEARCH="$1" && man -t "$MANSEARCH" | ps2pdf - "~/Documents/$MANSEARCH-man-page.pdf" && echo "$HOME/Documents/$MANSEARCH-man-page-pdf"}
# function man2pdf(){local MANSEARCH="$1" && man -t "$1" | ps2pdf - "~/Documents/$1-man-page.pdf" && echo "$HOME/Documents/$MANSEARCH-man-page-pdf"}


