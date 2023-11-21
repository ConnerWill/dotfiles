#shellcheck disable=2148,2296,2059

function draw_entire_line(){
  if [[ "${1}" == "-h" ]] || [[ "${1}" == "--help" ]]; then
    cat << EOF
USAGE:

  $ draw_entire_line 5 "\e[0;38;5;198m"
        ^            ^             ^
    function     Linestyle       Color


EXAMPLES:

  Draw a double line

   $  draw_entire_line 2


LINES:

  Default : ─
  1       : ─
  2       : ═
  3       : ═
  4       : ─
  5       : ▂
  6       : ▄
  7       : ▀
  8       : ─
  9       : ─
  10      : #

EOF
  fi

  ## Index of which line type to use (1-10)
  LINECHAR="${1}"
  ## Color of the linee
  colorline="${2}"
  ## Default line
  solidline="${(mr:$COLUMNS::─:)}"

  [[ "${LINECHAR}" -eq 1  ]] && solidline="${(mr:$COLUMNS::─:)}"
  [[ "${LINECHAR}" -eq 2  ]] && solidline="${(mr:$COLUMNS::═:)}"
  [[ "${LINECHAR}" -eq 3  ]] && solidline="${(mr:$COLUMNS::═:)}"
  [[ "${LINECHAR}" -eq 4  ]] && solidline="${(mr:$COLUMNS::─:)}"
  [[ "${LINECHAR}" -eq 5  ]] && solidline="${(mr:$COLUMNS::▂:)}"
  [[ "${LINECHAR}" -eq 6  ]] && solidline="${(mr:$COLUMNS::▄:)}"
  [[ "${LINECHAR}" -eq 7  ]] && solidline="${(mr:$COLUMNS::▀:)}"
  [[ "${LINECHAR}" -eq 8  ]] && solidline="${(mr:$COLUMNS::─:)}"
  [[ "${LINECHAR}" -eq 9  ]] && solidline="${(mr:$COLUMNS::─:)}"
  [[ "${LINECHAR}" -eq 10 ]] && solidline="${(mr:$COLUMNS::#:)}"

  printf "${colorline}${solidline}\e[0m"
}
