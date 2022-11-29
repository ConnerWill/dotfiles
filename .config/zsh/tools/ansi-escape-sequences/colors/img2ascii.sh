#!/usr/bin/env bash

# Image viewer for terminals that support true colors.
# Copyright (C) 2014  Egmont Koblinger
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.



color_black='\x1b[38;5;0m'
color_white='\x1b[38;5;15m'
color_gray='\x1b[38;5;7m'
color_darkgray='\x1b[38;5;8m'
color_red='\x1b[38;5;196m'
color_yellow='\x1b[38;5;190m'
color_blue='\x1b[38;5;33m'
color_green='\x1b[38;5;46m'
color_cyan='\x1b[38;5;87m'
color_purple='\x1b[38;5;93m'
color_magenta='\x1b[38;5;201m'
color_bold='\x1b[1m'
color_italic='\x1b[3m'
color_underline='\x1b[4m'
color_reset='\x1b[0m'

PROG="$(basename $0)"

function img2ascii_help(){
  printf "$(cat <<ENDHELP
  ${color_bold}${color_underline}${color_blue}NAME:${color_reset}

    ${color_bold}${color_green}$PROG${color_reset}


  ${color_bold}${color_underline}${color_blue}DESCRIPTION:${color_reset}

    ${color_italic}${color_white}Convert an image to ASCII characters and display it in the terminal${color_reset}


  ${color_bold}${color_underline}${color_blue}USAGE:${color_reset}

      ${color_bold}${color_green}$PROG${color_reset} ${color_gray}[-format]${color_reset} ${color_yellow}imagefile${color_reset}

      ${color_bold}${color_green}$PROG${color_reset} ${color_gray}[-h|--help|help]${color_reset}


  ${color_bold}${color_underline}${color_blue}OPTIONS:${color_reset}


    ${color_blue}FORMAT OPTIONS:${color_reset}

      ${color_gray}-colon4${color_reset}, ${color_gray}-official${color_reset}, ${color_gray}-dejure${color_reset}
          Official format [default] (ESC[38:2::R:G:Bm)

      ${color_gray}-colon3${color_reset}, ${color_gray}-wrong${color_reset}
          Misinterpreted format (ESC[38:2:R:G:Bm)

      ${color_gray}-semicolon${color_reset}, ${color_gray}-common${color_reset}, ${color_gray}-defacto${color_reset}
          Commonly used format (ESC[38;2;R;G;Bm)


    ${color_blue}META OPTIONS:${color_reset}

      ${color_gray}-h${color_reset},${color_gray}--help${color_reset},${color_gray}help${color_reset}               Show this help menu


  ${color_bold}${color_underline}${color_blue}EXAMPLES:${color_reset}

    ${color_italic}Display ${color_yellow}'~/pictures/image.png'${color_reset}${color_italic} in the terminal${color_reset}

      $ ${color_bold}${color_green}$PROG${color_reset} ${color_yellow}~/pictures/image.png${color_reset}



.
ENDHELP
)\n"
}

sep1=':'
sep2='::'
if [ "$1" = "-h" -o "$1" = "--help" -o "$1" = "help" ]; then
  img2ascii_help
  exit
elif [ "$1" = "-colon4" -o "$1" = "-official" -o "$1" = "-dejure" ]; then
  shift
elif [ "$1" = "-colon3" -o "$1" = "-wrong" ]; then
  sep2=':'
  shift
elif [ "$1" = "-semicolon" -o "$1" = "-common" -o "$1" = "-defacto" ]; then
  sep1=';'
  sep2=';'
  shift
fi

if [ $# != 1 -o "${1:0:1}" = "-" ]; then
  img2ascii_help
  exit
elif [ -z $(type -p convert) ]; then
  echo 'Please install ImageMagick to run this script.' >&2
  exit 1
fi

# This is so that "upper" is still visible after exiting the while loop.
shopt -s lastpipe

COLUMNS=$(tput cols)

declare -a upper lower
upper=()
lower=()

convert -thumbnail ${COLUMNS}x -define txt:compliance=SVG "$1" txt:- |
while IFS=',:() ' read col row dummy red green blue rest; do
  if [ "$col" = "#" ]; then
    continue
  fi

  if [ $((row%2)) = 0 ]; then
    upper[$col]="$red$sep1$green$sep1$blue"
  else
    lower[$col]="$red$sep1$green$sep1$blue"
  fi

  # After reading every second image row, print them out.
  if [ $((row%2)) = 1 -a $col = $((COLUMNS-1)) ]; then
    i=0
    while [ $i -lt $COLUMNS ]; do
      echo -ne "\\e[38${sep1}2${sep2}${upper[$i]};48${sep1}2${sep2}${lower[$i]}m▀"
      i=$((i+1))
    done
    # \e[K is useful when you resize the terminal while this script is still running.
    echo -e "\\e[0m\e[K"
    upper=()
    d=()
  fi
done

# Print the last half line, if required.
if [ "${upper[0]}" != "" ]; then
  i=0
  while [ $i -lt $COLUMNS ]; do
    echo -ne "\\e[38${sep1}2${sep2}${upper[$i]}m▀"
    i=$((i+1))
  done
  echo -e "\\e[0m\e[K"
fi
