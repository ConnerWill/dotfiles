#shellcheck disable=2148,2296,2059

function draw_entire_line(){
  while [[ $# -gt 0 ]]; do
      case "$1" in
          -h|--help)
              cat << EOF
USAGE:

  $ draw_entire_line 5 "\e[0;38;5;198m"
        ^            ^             ^
    function     Linestyle       Color


EXAMPLES:

  Replace current prompt with a blue bar

   $ draw_entire_line 6 "^[[1A^[[2K^[[1A^[[2K\e[0;38;5;33m"

   $ for i in $(seq 1 255); do draw_entire_line 4 "^[[1A^[[2K\r\e[0;38;5;${i}m"; sleep 0.1; done

   $ for i in $(seq 1 255); do draw_entire_line 4 "\n^[[1A^[[2K\e[0;38;5;${i}m"; sleep 0.1; done

   $ for i in $(seq 0 16); do draw_entire_line 6 "\e[?25l\n^[[1A^[[2K\e[0;38;5;${i}m"; sleep 0.05; done; printf "\e[?25h"

   $ printf "\e[?25h" ## Restore cursor


LINES:

  Default: ─

EOF
              return 0
              ;;
      esac
      shift
  done

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
