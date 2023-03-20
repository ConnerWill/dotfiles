#shellcheck disable=2148,2317

g(){

###{{{ SETUP

  local INPUTFILE OUTPUTMSG RENDERER

###}}} SETUP

###{{{ PRINT ERROR MSG

  _G_ERRORMSG(){
    local INPUTFILE OUTPUTMSG RENDERER ERRORTXT ORIGSTATUS
    local -i ERRORNUM
    declare -A g_colors

    ERRORNUM=$1
    ORIGSTATUS="${2}"
    INPUTFILE="${3}"

###{{{ COLOR ARRAY

    if [[ -z ${NO_COLOR} ]]; then
      g_colors[reset]='\e[0m'
      g_colors[Reset]='\e[0m'
      g_colors[Bold]='\e[1m'
      g_colors[Italic]='\e[3m'
      g_colors[Underline]='\e[4m'
      g_colors[Black]='\e[30m'
      g_colors[Gray]='\e[38;5;245m'
      g_colors[DarkGray]='\e[38;5;8m'
      g_colors[White]='\e[38;5;15m'
      g_colors[Red]='\e[38;5;196m'
      g_colors[Green]='\e[38;5;46m'
      g_colors[Yellow]='\e[38;5;190m'
      g_colors[Blue]='\e[38;5;33m'
      g_colors[Purple]='\e[38;5;93m'
      g_colors[Magenta]='\e[38;5;201m'
      g_colors[Cyan]='\e[38;5;87m'
      g_colors[BG_Black]='\e[30m'
      g_colors[BG_Gray]='\e[48;5;245m'
      g_colors[BG_DarkGray]='\e[48;5;8m'
      g_colors[BG_White]='\e[48;5;15m'
      g_colors[BG_Red]='\e[48;5;196m'
      g_colors[BG_Green]='\e[48;5;46m'
      g_colors[BG_Yellow]='\e[48;5;190m'
      g_colors[BG_Blue]='\e[48;5;33m'
      g_colors[BG_Purple]='\e[48;5;93m'
      g_colors[BG_Magenta]='\e[48;5;201m'
      g_colors[BG_Cyan]='\e[48;5;87m'
    fi

###}}} COLOR ARRAY

    ERRORTXT="${g_colors[BG_Red]}${g_colors[White]}${g_colors[Bold]}  ERROR  ${g_colors[reset]}: "
    WARNTXT="${g_colors[BG_Yellow]}${g_colors[Black]}${g_colors[Bold]} WARNING ${g_colors[reset]}: "

    [[ -z "$ERRORNUM"   ]] && OUTPUTMSG="${ERRORTXT}${g_colors[Red]}UNKNOWN ERROR running script${g_colors[reset]}"
    [[ "$ERRORNUM" == 1 ]] && OUTPUTMSG="${ERRORTXT}${g_colors[Red]}'rich' is not installed or in PATH\n\tInstall rich using pipx install rich${g_colors[reset]}"
    [[ "$ERRORNUM" == 2 ]] && OUTPUTMSG="${WARNTXT}${g_colors[Yellow]}No file provided${g_colors[reset]}:"
    [[ "$ERRORNUM" == 3 ]] && OUTPUTMSG="${ERRORTXT}${g_colors[Red]}Cannot find file${g_colors[reset]}:"
    [[ "$ERRORNUM" == 4 ]] && OUTPUTMSG="${WARNTXT}${g_colors[Blue]}Error code: 4${g_colors[reset]}:"
    [[ "$ERRORNUM" == 5 ]] && OUTPUTMSG="${WARNTXT}${g_colors[Cyan]}Error code: 5${g_colors[reset]}:"

    #shellcheck disable=2059
    printf "${OUTPUTMSG}\t%s\n" "${ORIGSTATUS}"
    return
  }

###}}} PRINT ERROR MSG

###{{{ RENDER FUNCTIONS

###{{{ RICH

  _viewmarkdown_rich(){
    local INPUTFILE RICHTHEME

    INPUTFILE="${*}"
    [[ -z "$RICHTHEME" ]] && RICHTHEME="dracula" #one-dark
     rich                      \
        --markdown             \
        --theme "${RICHTHEME}" \
        --padding 1,5,1,5      \
        --panel rounded        \
        --line-numbers         \
        --pager                \
        --hyperlinks           \
        --text-full            \
      "${INPUTFILE}"
  }

###}}} RICH

###{{{ GLOW

  _viewmarkdown_glow(){
    local INPUTFILE GLOWTHEME

    INPUTFILE="${*}"
    [[ -z "$GLOWTHEME" ]] && GLOWTHEME="one-dark"
    glow "${INPUTFILE}"
  }

###}}} GLOW

###}}} RENDER FUNCTIONS

###{{{ MAIN

  ## Default renderer [glow/rich] (Default: rich)
  ##
  ##   Optionally, you can specify the render by passing the render before the files
  ##   e.g.
  ##
  ##     $ g glow README.md
  ##
  ##     $ g rich README.md
  RENDERER="${RENDERER:-"rich"}"

  if   [[ "${1}" == "rich" ]]; then RENDERER="rich"; shift
  elif [[ "${1}" == "glow" ]]; then RENDERER="glow"; shift
  fi

  INPUTFILE="${*}"

  ## If INPUTFILE is empty, check if README.md is in cwd, if so, set it to that
  if [[ -z "${INPUTFILE}" ]]; then
    INPUTFILE="${PWD}/README.md"
    _G_ERRORMSG 2 "Using ${INPUTFILE}"
  fi

  if [[ ! -e "${INPUTFILE}" ]]; then
    _G_ERRORMSG 3 "${INPUTFILE}"
    return 1
  fi

  [[ -z "${commands[${RENDERER}]}" ]] && _G_ERRORMSG 1 $? && return 1

  _viewmarkdown_${RENDERER} "${INPUTFILE[@]}"

###}}} MAIN

###{{{ CLEANUP

  unfunction           \
    _G_ERRORMSG        \
    _viewmarkdown_rich \
    _viewmarkdown_glow

###}}} CLEANUP

}
