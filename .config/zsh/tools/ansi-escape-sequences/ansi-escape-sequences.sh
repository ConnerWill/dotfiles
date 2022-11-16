#!/bin/env bash
#######################################
#         ANSI ESCAPE SEQUENCES
######################################
###
###  CURSOR / LINES
###
#
#    \e[?7l        ## Disable line wrap.
#    \e[?25l       ## Hide Cursor
#    \e[?25h       ## Restore Cursor
#    \e[1A         ## Move curser up 1 line
#    \e[2K         ## Clear line
#    \r            ## Move cursor to beginning of line
#    \e[2K         ## Clear line
#    \r            ## Move cursor to beginning of line
#
#
###
###  COLORS
###
#



printf "[0;1;4;38;5;201m]8;;https://connerwill.comconnerwill.sh]8;;[0m\n"
#
# ]8;;https://connerwill.comconnerwill.sh]8;;
# [0;1;4;38;5;201m
# #
#
#
#
#
#
e='echo -en'                                     # shortened echo command variable
   ESC=$( $e "\033")                             # variable containing escaped value
 CLEAR(){ $e "\033c";}                           # clear screen
 CIVIS(){ $e "\033[?25l";}                       # hide cursor
 CNORM(){ $e "\033[?12l\033[?25h";}              # show cursor
  TPUT(){ $e "\033[${1};${2}H";}                 # terminal put (x and y position)
COLPUT(){ $e "\033[${1}G";}                      # put text in the same line as the specified column
  MARK(){ $e "\033[7m";}                         # select current line text
UNMARK(){ $e "\033[27m";}                        # normalize current line text
  DRAW(){ $e "\033%@";echo -en "\033(0";}        # switch to 'garbage' mode to be able to draw
 WRITE(){ $e "\033(B";}                          # return to normal (reset)
  BLUE(){ $e "\033c\033[0;1m\033[37;44m\033[J";} # clear screen, set background to blue and font to white


## embeded hyperlink

#```shell

#]8;;file://archdesk/home/dampsock/.config/zsh/tools/ansi-escape-sequences/ansi-escape-sequences.shansi-escape-sequences.sh]8;;
