#shellcheck disable=2148
# Implements: OSC 8 <URL> ST <Link-text> OSC 8 ST
# Prints a terminal-clickable hyperlink
# See: https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda
#
# @Params
# $1: The hyperlink URL
# $2: The optional hyperlink text (defaults to URL)
#
# @Outputs
# The terminal-clickable hyperlink
hyperlink(){

  _hyperlink_help(){
    printf "$(cat <<HYPERLINKHELP
NAME:

  \e]8;;https://github.com/ConnerWill/dotfiles\e\\\\\e[1;3;4;38;5;46mhyperlink\e[0m\e]8;;\e\\


DESCRIPTION:

  Implements '\e]8;;https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda\e\\OSC 8 <URL> ST <Link-text> OSC 8 ST\e]8;;\e\\'
  which prints a terminal-clickable hyperlink

  If no [text] was used, it will by default use the <URL>
  as the display text which is clickable


USAGE:

  \e]8;;https://github.com/ConnerWill/dotfiles\e\\hyperlink\e]8;;\e\\ <URL> [text]


OPTIONS:

  -h, --help          Show this help menu
  -p, --plain-text    Do not encode hyperlink, print plain text (does not accept input)


EXAMPLE:

  Embed a hyperlink to connerwill.com in the text 'MY WEBSITE'

    $  \e]8;;https://github.com/ConnerWill/dotfiles\e\\hyperlink\e]8;;\e\\ "https://connerwill.com" "MY WEBSITE"



  Embed a hyperlink to \e]8;;https://dampsock.com\e\\dampsock.com\e]8;;\e\\ with no text (Defaults to URL)

    $  \e]8;;https://github.com/ConnerWill/dotfiles\e\\hyperlink\e]8;;\e\\ "https://dampsock.com"


MORE INFO:

  \e]8;;https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda\e\\\\\e[1;3;4;38;5;33m[CLICK]\e[0m Hyperlinks_in_Terminal_Emulators.md \e[1;3;4;38;5;33m[CLICK]\e[0m\e]8;;\e\\

  https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda

HYPERLINKHELP
    )\n\n"
  }

  ## Check if help flags are passed
  if   [[ "${1}" == "-h" ]] || [[ "${1}" == "--help" ]]; then
    _hyperlink_help
  elif [[ "${2}" == "-h" ]] || [[ "${2}" == "--help" ]]; then
    _hyperlink_help
  elif [[ "${2}" == "-p" ]] || [[ "${1}" == "--plain-text" ]] || [[ "${2}" == "-p" ]] || [[ "${2}" == "--plain-text" ]]; then
    ## Print plain text hyperlink escape sequence
    printf "\e[0;1;3;4;38;5;15mPlain\e[0;38;5;196m:\e[0m\n"
    print -R 'printf "\e]8;;URL\e\\TEXT\e]8;;\e\\\\\n"'
    printf "\n\n\e[0;1;3;4;38;5;15mColored\e[0;38;5;196m:\e[0m\n"
    print -R 'printf "\e]8;;URL\e\\\\\e[0;48;5;93;38;5;51mTEXT\e[0m\e]8;;\e\\\\\n"'
    printf "\n\n\e[0;1;3;4;38;5;15mItalic, Underlined, Bold, and Colored\e[0;38;5;196m:\e[0m\n"
    print -R 'printf "\e]8;;URL\e\\\\\e[0;1;3;4;48;5;87;38;5;201m TEXT \e[0m\e]8;;\e\\\\\n"'
  else
    ## Print embeded hyperlink
    printf '\e]8;;%s\e\\%s\e]8;;\e\\\n' "$1" "${2:-$1}"
  fi
  unset -f _hyperlink_help
}
##END







# ]8;;https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda\Hyperlinks_in_Terminal_Emulators.md [CLICK]]8;;\

# hl=$(
#   hyperlink \
#     https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda \
#     'OSC 8 <URL> ST <Link-text> OSC 8 ST'
# )
#
# printf 'Demo of the %s sequence\nto make hyperlinks clickable in terminal:\n\n' \
#   "$hl"
#
# hyperlink https://www.example.com/ 'Example link'
# printf \\n
# hyperlink https://www.example.com/
# printf \\n
