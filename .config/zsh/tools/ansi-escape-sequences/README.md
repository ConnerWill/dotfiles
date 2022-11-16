# ANSI ESCAPE SEQUENCES

##  CURSOR / LINES

```shell

  \e[?7l        ## Disable line wrap.
  \e[?25l       ## Hide Cursor
  \e[?25h       ## Restore Cursor
  \e[1A         ## Move curser up 1 line
  \e[2K         ## Clear line
  \r            ## Move cursor to beginning of line
  \e[2K         ## Clear line
  \r            ## Move cursor to beginning of line

```

## Embedded Hyperlink

```shell

printf "[0;1;4;38;5;201m]8;;https://connerwill.comconnerwill.sh]8;;[0m\n"

```


## COLORS

```shell

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

```



```shell

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

```

> listcolors

```shell

function listcolors(){

	declare -A colors

	# Reset
	colors[Color_Off]='\033[0m'       # Text Reset

	### Foreground ###           ### Background ###
	colors[Black]='\033[0;30m'     colors[On_Black]='\033[40m'  # Black
	colors[Red]='\033[0;31m'       colors[On_Red]='\033[41m'    # Red
	colors[Green]='\033[0;32m'     colors[On_Green]='\033[42m'  # Green
	colors[Yellow]='\033[0;33m'    colors[On_Yellow]='\033[43m' # Yellow
	colors[Blue]='\033[0;34m'      colors[On_Blue]='\033[44m'   # Blue
	colors[Purple]='\033[0;35m'    colors[On_Purple]='\033[45m' # Purple
	colors[Cyan]='\033[0;36m'      colors[On_Cyan]='\033[46m'   # Cyan
	colors[White]='\033[0;37m'     colors[On_White]='\033[47m'  # White

	### Bold ###                   ### Underline ###
	colors[BBlack]='\033[1;30m'    colors[UBlack]='\033[4;30m'  # Black
	colors[BRed]='\033[1;31m'      colors[URed]='\033[4;31m'    # Red
	colors[BGreen]='\033[1;32m'    colors[UGreen]='\033[4;32m'  # Green
	colors[BYellow]='\033[1;33m'   colors[UYellow]='\033[4;33m' # Yellow
	colors[BBlue]='\033[1;34m'     colors[UBlue]='\033[4;34m'   # Blue
	colors[BPurple]='\033[1;35m'   colors[UPurple]='\033[4;35m' # Purple
	colors[BCyan]='\033[1;36m'     colors[UCyan]='\033[4;36m'   # Cyan
	colors[BWhite]='\033[1;37m'    colors[UWhite]='\033[4;37m'  # White


  ### High Intensity Foreground ### High Intensity Backgrounds ###### Bold High Intensity ###
	colors[IBlack]='\033[0;90m'    colors[On_IBlack]='\033[0;100m'  colors[BIBlack]='\033[1;90m'      # Black
	colors[IRed]='\033[0;91m'      colors[On_IRed]='\033[0;101m'    colors[BIRed]='\033[1;91m'        # Red
	colors[IGreen]='\033[0;92m'    colors[On_IGreen]='\033[0;102m'  colors[BIGreen]='\033[1;92m'      # Green
	colors[IYellow]='\033[0;93m'   colors[On_IYellow]='\033[0;103m' colors[BIYellow]='\033[1;93m'     # Yellow
	colors[IBlue]='\033[0;94m'     colors[On_IBlue]='\033[0;104m'   colors[BIBlue]='\033[1;94m'       # Blue
	colors[IPurple]='\033[0;95m'   colors[On_IPurple]='\033[0;105m' colors[BIPurple]='\033[1;95m'     # Purple
	colors[ICyan]='\033[0;96m'     colors[On_ICyan]='\033[0;106m'   colors[BICyan]='\033[1;96m'       # Cyan
	colors[IWhite]='\033[0;97m'    colors[On_IWhite]='\033[0;107m'  colors[BIWhite]='\033[1;97m'      # White

	for i in "${!colors[@]}"; do
	  printf "$i = ${colors[$i]}DAMPSOCK$white"
	done

```

> listcolorANSI

```shell

function listcolorANSI(){
	for code in {0..255}; do
		printf "\e[38;5;${code}m"'\\e[38;5;'"$code"m"\e[0m\n"
	done
}

```
