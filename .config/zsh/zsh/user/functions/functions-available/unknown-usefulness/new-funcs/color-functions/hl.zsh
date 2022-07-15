# -*- shell-script -*-

# Taken from:
# https://dev.0x50.de/projects/ftzsh/repository/revisions/master/entry/functions/hl




function hl(){


  if ! [[ -x ${commands[highlight]} ]]; then
      printf 'hl: Could not find `highlight'\'' binary!\n'
      return 1
  fi

  local context file format lang suffix syntax theme o
  local -i nopager=0
  local -a pager hl_opts
  local -A opt syntaxmap

  while [[ $1 == -* ]]; do
      case $1 in
      (-c|--cat|--no-pager)
          nopager=1
          shift
          ;;
      (-F|--format)
          opt[format]=$2
          shift
          shift
          ;;
      (-h|--help)
          shift
          ;;
      (-u|--usage)
          printf '\e[0;1;38;5;12mUSAGE:'
          printf '\t\e[0;38;5;15m%s [OPTION(s)] <file(s)>\e[0m\n' "$0"
          return 0
          ;;
      (-l|--list)
          (   printf 'available languages (syntax parameter):\n\n' ;
              highlight --list-langs ; ) | less -SM
          return 0
          ;;
      (-P|--pager)
          opt[pager]=$2
          shift
          shift
          ;;
      (-s|--syntax)
          opt[syntax]=$2
          shift
          shift
          ;;
      (-t|--themes)
          (   printf 'available themes (style parameter):\n\n' ;
              highlight --list-themes ; ) | less -SM
          return 0
          ;;
      (-T|--theme)
          opt[theme]=$2
          shift
          shift
          ;;
      (*)
          printf '\e[0;1;38;5;15mhl: \e[0;38;5;9mUnknown option\e[0;38;5;11m `%s'\''\e[0m\n' $1
          return 1
          ;;
      esac
  done

  local COLOR_TITLE='\e[38;5;12m'
  local COLOR_OPTION='\e[38;5;245m'
  local COLOR_DESCRIPTION='\e[38;5;12m'


  if (( ${#argv} < 1 )) ; then
      printf '\e[0;1;38;5;12mNAME:\n'
      printf '\t\e[0;38;5;15m%s\n' "$0"
      printf '\e[0;1;38;5;12mUSAGE:\n'
      printf '\t\e[0;38;5;15m%s [OPTION(s)] <file(s)>\n\n' "$0"
      printf '\e[0;1;38;5;12mOPTIONS:\n'
      printf '\t\e[0;38;5;245m-l --list\n'
      printf '\t\e[0;38;5;245m-t, --themes\n'
      printf '\t\e[0;38;5;245m-s, --syntax\n'
      printf '\t\e[0;38;5;245m-c, --no-pager (--cat)\n'
      printf '\t\e[0;38;5;245m-u, --usage\n'
      printf '\t\e[0;38;5;245m-h, --help\n'
      printf '\e[0m\n'
      (( ${#argv} > 2 )) && printf '  Too many arguments.\n'
      return 1
  fi


  syntaxmap=(
      scm lisp
  )

  for file in "$@"; do
      suffix=${file:e}
      context=":functions:hl:$OSTYPE:$TERM:$suffix"
      hl_opts=()
      syntax=''

      if (( ${+opt[format]} )); then
          format=${opt[format]}
      else
          if ! zstyle -a $context format format; then
              case $TERM in
              ((screen|xterm)-256color)
                  format=xterm256
                  ;;
              (*)
                  format=ansi
                  ;;
              esac
          fi
      fi

      if (( ${+opt[theme]} )); then
          theme=${opt[theme]}
      else
          zstyle -s $context theme theme || theme=solarized-dark
      fi

      if (( nopager )); then
          pager=cat
      elif (( ${+opt[pager]} )); then
          pager=${(z)opt[pager]}
      else
          zstyle -a $context pager pager || pager=( less -Mr )
      fi

      if (( ${+opt[syntax]} )); then
          syntax=${opt[syntax]}
      else
          if ! zstyle -s $context syntax syntax; then
              (( ${+syntaxmap[$suffix]} )) && syntax=${syntaxmap[$suffix]}
          fi
      fi
      [[ -n $syntax ]] && hl_opts=( --syntax=$syntax )

      highlight --out-format=$format "${hl_opts[@]}" --style=$theme $file \
          | "${pager[@]}"
  done

  return 0

}
