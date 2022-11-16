# https://notes.burke.libbey.me/ansi-escape-codes/

function listcolorANSI(){
	local fgbg
	fgbf=48 ## Background
	for code in {0..2}; do
		for code in {0..255}; do
			printf "\t\e[${fgbf};5;${code}m"'\\e['"${fgbg}"';5;'"$code"m"\e[0m" ## Foreground
		done
		fgbf=38  ## Foreground
	done
}
function listcolorANSI(){
	for code in {0..255}; do
		printf "\e[38;5;${code}m"'▌║█║▌│║▌│║▌║▌█║\\e[38;5;'"$code"m"▌│║▌║▌│║║▌█║▌║█\e[0m\n" #\t\e[48;5;${code}m"'\\e[48;5;'"$code"m"\e[0m\n"
		# printf "\e[38;5;${code}m"'\\e[38;5;'"$code"m"\e[0m\t\e[48;5;${code}m"'\\e[48;5;'"$code"m"\e[0m\n"
	done
}
 # ▌║█║▌│║▌│║▌║▌█║\\e[38;5; m ▌│║▌║▌│║║▌█║▌║█
alias list-colors-ANSI="listcolorANSI"

## =============================
# ██▓▒▒░░░░░░▒▒▓████▓▒▒░░░░░░▒▒▓██
# ░░░▒▒▓████▓▒▒░░░░░░▒▒▓████▓▒▒░░░
# ██▓▒▒░░░░░░▒▒▓████▓▒▒░░░░░░▒▒▓██
# ░░░▒▒▓████▓▒▒░░░░░░▒▒▓████▓▒▒░░░
# ██▓▒▒░░░░░░▒▒▓████▓▒▒░░░░░░▒▒▓██
# ░░░▒▒▓████▓▒▒░░░░░░▒▒▓████▓▒▒░░░
# ██▓▒▒░░░░░░▒▒▓████▓▒▒░░░░░░▒▒▓██
# ░░░▒▒▓████▓▒▒░░░░░░▒▒▓████▓▒▒░░░
# ██▓▒▒░░░░░░▒▒▓████▓▒▒░░░░░░▒▒▓██
# ░░░▒▒▓████▓▒▒░░░░░░▒▒▓████▓▒▒░░░






function listcolors(){

	clear
	declare -A colors
	#curl www.bunlongheng.com/code/colors.png

	# Reset
	colors[Color_Off]='\033[0m'       # Text Reset

	# Regular Colors
	colors[Black]='\033[0;30m'        # Black
	colors[Red]='\033[0;31m'          # Red
	colors[Green]='\033[0;32m'        # Green
	colors[Yellow]='\033[0;33m'       # Yellow
	colors[Blue]='\033[0;34m'         # Blue
	colors[Purple]='\033[0;35m'       # Purple
	colors[Cyan]='\033[0;36m'         # Cyan
	colors[White]='\033[0;37m'        # White

	# Bold
	colors[BBlack]='\033[1;30m'       # Black
	colors[BRed]='\033[1;31m'         # Red
	colors[BGreen]='\033[1;32m'       # Green
	colors[BYellow]='\033[1;33m'      # Yellow
	colors[BBlue]='\033[1;34m'        # Blue
	colors[BPurple]='\033[1;35m'      # Purple
	colors[BCyan]='\033[1;36m'        # Cyan
	colors[BWhite]='\033[1;37m'       # White

	# Underline
	colors[UBlack]='\033[4;30m'       # Black
	colors[URed]='\033[4;31m'         # Red
	colors[UGreen]='\033[4;32m'       # Green
	colors[UYellow]='\033[4;33m'      # Yellow
	colors[UBlue]='\033[4;34m'        # Blue
	colors[UPurple]='\033[4;35m'      # Purple
	colors[UCyan]='\033[4;36m'        # Cyan
	colors[UWhite]='\033[4;37m'       # White

	# Background
	colors[On_Black]='\033[40m'       # Black
	colors[On_Red]='\033[41m'         # Red
	colors[On_Green]='\033[42m'       # Green
	colors[On_Yellow]='\033[43m'      # Yellow
	colors[On_Blue]='\033[44m'        # Blue
	colors[On_Purple]='\033[45m'      # Purple
	colors[On_Cyan]='\033[46m'        # Cyan
	colors[On_White]='\033[47m'       # White

	# High Intensity
	colors[IBlack]='\033[0;90m'       # Black
	colors[IRed]='\033[0;91m'         # Red
	colors[IGreen]='\033[0;92m'       # Green
	colors[IYellow]='\033[0;93m'      # Yellow
	colors[IBlue]='\033[0;94m'        # Blue
	colors[IPurple]='\033[0;95m'      # Purple
	colors[ICyan]='\033[0;96m'        # Cyan
	colors[IWhite]='\033[0;97m'       # White

	# Bold High Intensity
	colors[BIBlack]='\033[1;90m'      # Black
	colors[BIRed]='\033[1;91m'        # Red
	colors[BIGreen]='\033[1;92m'      # Green
	colors[BIYellow]='\033[1;93m'     # Yellow
	colors[BIBlue]='\033[1;94m'       # Blue
	colors[BIPurple]='\033[1;95m'     # Purple
	colors[BICyan]='\033[1;96m'       # Cyan
	colors[BIWhite]='\033[1;97m'      # White

	# High Intensity backgrounds
	colors[On_IBlack]='\033[0;100m'   # Black
	colors[On_IRed]='\033[0;101m'     # Red
	colors[On_IGreen]='\033[0;102m'   # Green
	colors[On_IYellow]='\033[0;103m'  # Yellow
	colors[On_IBlue]='\033[0;104m'    # Blue
	colors[On_IPurple]='\033[0;105m'  # Purple
	colors[On_ICyan]='\033[0;106m'    # Cyan
	colors[On_IWhite]='\033[0;107m'   # White


	for C in {0..255}; do
	    tput setab "$C"
	    echo -n "$C "
	done
	tput sgr0
	echo

	#   color=${colors[$input_color]}
	white="${colors[White]}"
	echo "$white"


#	echo -e "\n\n-------------------\n--- ANSI Colors ---\n-------------------\n"

	for i in "${!colors[@]}"
    do
	  echo -e "$i = ${colors[$i]}I love you$white"
	done

	echo "\n\n\t --- 'tput' Colors ---"


	tput init

	end=$(( $(tput colors)-1 ))
	w=8

	for c in $(seq 0 $end); do

	    eval "$(printf "tput setaf %3s   " "$c")" ; echo -n "$_"

	    [[ $c -ge $(( w*2 )) ]] && offset=2 || offset=0

	    [[ $(((c+offset) % (w-offset))) -eq $(((w-offset)-1)) ]] && echo

	done

	tput init
}

alias list-colors="listcolors"

### =============================

function listcolorsprintf(){

    ## Define Colors
    red='\e[1;31m%s\e[0m\n'
    green='\e[1;32m%s\e[0m\n'
    yellow='\e[1;33m%s\e[0m\n'
    blue='\e[1;34m%s\e[0m\n'
    magenta='\e[1;35m%s\e[0m\n'
    cyan='\e[1;36m%s\e[0m\n'
    orange='\e[38;5;166m%s\e[0m\n'
    lightblue='\e[38;5;111m%s\e[0m\n'

    ## Clear Screen
    clear

    ## Show Colored Text Test
    printf "    $green"   "This is a test in green"
    printf "    $red"     "This is a test in red"
    printf "    $yellow"  "This is a test in yellow"
    printf "    $blue"    "This is a test in blue"
    printf "    $magenta" "This is a test in magenta"
    printf "    $cyan"    "This is a test in cyan"
}

alias list-colors-printf="listcolorsprintf"

### =============================
