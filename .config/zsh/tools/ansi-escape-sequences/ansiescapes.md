
Search notes: [Unknown INPUT type]
****** ANSI escape sequences ******
ANSI Escape Sequences are instructions for consoles to position the cursor, change and set color and fonts and perform other operations.
These instructions are encoded in a series of characters whose first byte is the escape character (ASCII 27, octal \033, hex 0x1b).
Apparently, VT 100 influenced these instructions heavily.
***** Colors *****
**** 16 basic colors ****
There are eight colors, each of which is identified by a single digit:
0 black
1 red
2 green
3 yellow
4 blue
5 purple
6 cyan
7 white
Each of these colors has a high intensity variant, which brings the number of basic colors to 16 (and correspond to the values of the .NET[1] enum System.ConsoleColor[2]).
In order to create a color code, the color-digit needs to be prepended with one or two other digits (the dot represents the digit for the color):
3.  foreground / normal intensity
4.  background / normal intensity
9.  foreground / high intensity
10. background / high intensity
Thus, for example a high intensity (=9) red (=1) text is escaped like so:
\e[91m text \e[0m
**** Defining the RGB values for the 16 base colors ****
At least in conhost.exe[3], it's possible to define the RGB values for the 16 colors with \e]4;c;rgb:RR/GG/BB\x7. RR, GG and BB are the hex values for the RGB colors. c is the color number which is
being defined. Note the closing bracket ].
The following PowerShell script modifies the color palette according to solarized light:
function define-color {
   param (
      [int] $colorNumber,
      [int] $r,
      [int] $g,
      [int] $b
   )

   write-host ("$([char]27)]4;{0};rgb:{1:X2}/{2:X2}/{3:X2}$([char]7)" -f $colorNumber, $r, $g, $b)
}

define-color  0    0 39   49  // dark black
define-color  1  208 27   36  // dark red
define-color  2  114 137   5  // dark green
define-color  3  165 119   5  // dark yellow
define-color  4   32 117 199  // dark blue
define-color  5  198 27  110  // dark magenta
define-color  6   37 145 133  // dark cyan
define-color  7  233 226 203  // dark white

define-color  8    0 77  100  // bright black
define-color  9  189 54   18  // bright red
define-color 10   70 90   97  // bright green
define-color 11   82 103 111  // bright yellow
define-color 12  112 129 131  // bright blue
define-color 13   88 86  185  // bright magenta
define-color 14  129 144 143  // bright cyan
define-color 15  252 244 220  // bright white
Github respository ANSI-escape-sequences[4], path: /define-16-basic-colors.ps1[5]
**** 216 6-bit colors + 16 basic colors + 24 gray scale colors ****
With \e[38;5;nm (foreground) and \e[48;5;nm (background colors), the color palette can be extended to 256 colors which are specified by n:
n
0-7                 8 colors
8-15                8 intense color
16 + 36*r + 6+g + b rgb value (each component having 6 values)
232-255             24 gray scale colors, black to white
**** 24-bit colors ****
With \e[38;2;r;g;bm and \e[48;2;r;g;bm, The color palette is extended to true colors, r, g and b being values between 0 and 255.
***** Positioning the cursor *****
Using H to position the cursor on specific coordinates.
The first number ist the y coordinate, the second number the x coordinate.
echo -e "\e[15;8Hx=8 / y=15"
echo -e "\e[4;22Hx=22 / y=4"
Github respository ANSI-escape-sequences[6], path: /position-cursor[7]
***** Clearing the screen *****
echo -e "\e[2J"
Github respository ANSI-escape-sequences[8], path: /clear-screen[9]
***** bg-48-fg-38-5 *****
The following shell script uses the 38;5 escape function to create 216 background colors (The red, green and blue components are each in the range 0 … 5)
#
#  vim: ft=sh
#
ansi_color_5() {
  local r=$1 # 0 .. 5
  local g=$2 # 0 .. 5
  local b=$3 # 0 .. 5

  echo -e $(( 16+ $r*36 + $g*6 + $b))
}

ansi_color_bg_5 () {
  echo -e "\e[38;5;$(ansi_color_5 $1 $2 $3)m"
}
ansi_color_fg_5 () {
  echo -e "\e[48;5;$(ansi_color_5 $1 $2 $3)m"
}

ansi_reset() {
  echo -e "\e[0m"
}


printf "\n"
for r in {0..5}; do
  for g in {0..5}; do
    for b in {0..5}; do

      printf "  "

      if [[ $r > 3 || $g > 3 ]]; then
        bg_color='0 0 0'
      else
        bg_color='5 5 5'
      fi

      printf "$(ansi_color_fg_5 $r $g $b)$(ansi_color_bg_5 $bg_color) %3d " $(ansi_color_5 $r $g $b)

    done
    printf $(ansi_reset)
    printf "\n"
  done
  printf "\n"
done
Github respository ANSI-escape-sequences[10], path: /bg-48-fg-38-5[11]
The output of the script is
[12]
Apparently, python_script[13] does more or less the same thing.
This_is_a_perl_script[14] does seems to do the same.
And then, there is also the shell command msgcat --color=test.
***** Resetting all settings *****
echo -e "\e[0m"
#
#   Might be followed by \e[2J (Clear screen)
#
Github respository ANSI-escape-sequences[15], path: /reset-all[16]
***** Determine sequence for specfic key on keyboard *****
In order to determine a key's emitted sequence, one can use ctrl-v followed by the key.
***** PowerShell *****
In PowerShell[17], the escape character can be expressed by casting 27 or its hexadecimal representation 0x1b to a char:
write-host[18] "$([char]0x1b)[40;91m red on black $([char]27)[0m"
PowerShell 7 (6?) shortens this cast to a backtick-e which is visually easier to read:
write-host "`e[32;103m green on intense yellow `e[0m"
See also ANSI_colors_in_PowerShell[19].
***** See also *****
highlight.pl[20]: a Perl script that prints ERROR in red and WARNING in yellow.
Perl_module_Term::ANSIColor[21]
Coloring_the_output_in_Bash's_echo[22]
sed_example[23] to colorize a file.
tput:_colors[24]
Virtual_Terminal_Sequences_on_Windows[25]
The PowerShell module console[26], especially its function get-ansiEscapedText[27].
In bash's[28] echo[29] command, the -e[30] flag interprets \e as <ESC>.
***** Links *****
http://ascii-table.com/ansi-escape-sequences.php[31]
Wikipedia:_ANSI_escape_codes[32]
Microsoft Documentation: Console_Virtual_Terminal_Sequences[33]
========================================================================================================================================================================================================
Index[34]
* References *
   1. /notes/Microsoft/dot-net/index
   2. /notes/Microsoft/dot-net/namespaces-classes/System/ConsoleColor
   3. /notes/Windows/dirs/Windows/System32/conhost_exe
   4. https://github.com/ReneNyffenegger/ANSI-escape-sequences
   5. https://github.com/ReneNyffenegger/ANSI-escape-sequences/blob/master/define-16-basic-colors.ps1
   6. https://github.com/ReneNyffenegger/ANSI-escape-sequences
   7. https://github.com/ReneNyffenegger/ANSI-escape-sequences/blob/master/position-cursor
   8. https://github.com/ReneNyffenegger/ANSI-escape-sequences
   9. https://github.com/ReneNyffenegger/ANSI-escape-sequences/blob/master/clear-screen
  10. https://github.com/ReneNyffenegger/ANSI-escape-sequences
  11. https://github.com/ReneNyffenegger/ANSI-escape-sequences/blob/master/bg-48-fg-38-5
  12. /notes/Linux/shell/bg-48-fg-38-5.png
  13. https://github.com/segaleran/eran-dotfiles/blob/master/bin/terminalcolors.py
  14. https://gist.github.com/hSATAC/1095100
  15. https://github.com/ReneNyffenegger/ANSI-escape-sequences
  16. https://github.com/ReneNyffenegger/ANSI-escape-sequences/blob/master/reset-all
  17. /notes/Windows/PowerShell/index
  18. /notes/Windows/PowerShell/command-inventory/noun/host/write/index
  19. /notes/Windows/PowerShell/host/ANSI/index
  20. /notes/development/tools/scripts/personal/highlight_pl
  21. /notes/development/languages/Perl/modules/Term/ANSIColor/index
  22. /notes/Linux/shell/bash/built-in/echo#bash-echo-colors
  23. /notes/development/languages/sed/examples/ansi-escape
  24. /notes/Linux/shell/commands/tput#colors
  25. /notes/Windows/development/Portable-Executable/subsystem/console/index#win-virtual-terminal-sequences
  26. /notes/Windows/PowerShell/modules/personal/console/index
  27. /notes/Windows/PowerShell/modules/personal/console/get-ansiEscapedText
  28. /notes/Linux/shell/bash/index
  29. /notes/Linux/shell/bash/built-in/echo
  30. /notes/Linux/shell/bash/built-in/echo#bash-echo-e
  31. http://ascii-table.com/ansi-escape-sequences.php
  32. https://en.wikipedia.org/wiki/ANSI_escape_code
  33. https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
  34. /notes/index.html
