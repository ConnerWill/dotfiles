# shellcheck disable=2148

function zCOLORz(){

	declare -Ag colors
	#curl www.bunlongheng.com/code/colors.png

	# Reset
	Zcolors[Color_Off]='\033[0m'       # Text Reset

	# Regular Colors
	Zcolors[Black]='\033[0;30m'        # Black
	Zcolors[Red]='\033[0;31m'          # Red
	Zcolors[Green]='\033[0;32m'        # Green
	Zcolors[Yellow]='\033[0;33m'       # Yellow
	Zcolors[Blue]='\033[0;34m'         # Blue
	Zcolors[Purple]='\033[0;35m'       # Purple
	Zcolors[Cyan]='\033[0;36m'         # Cyan
	Zcolors[White]='\033[0;37m'        # White

	# Bold
	Zcolors[BBlack]='\033[1;30m'       # Black
	Zcolors[BRed]='\033[1;31m'         # Red
	Zcolors[BGreen]='\033[1;32m'       # Green
	Zcolors[BYellow]='\033[1;33m'      # Yellow
	Zcolors[BBlue]='\033[1;34m'        # Blue
	Zcolors[BPurple]='\033[1;35m'      # Purple
	Zcolors[BCyan]='\033[1;36m'        # Cyan
	Zcolors[BWhite]='\033[1;37m'       # White

	# Underline
	Zcolors[UBlack]='\033[4;30m'       # Black
	Zcolors[URed]='\033[4;31m'         # Red
	Zcolors[UGreen]='\033[4;32m'       # Green
	Zcolors[UYellow]='\033[4;33m'      # Yellow
	Zcolors[UBlue]='\033[4;34m'        # Blue
	Zcolors[UPurple]='\033[4;35m'      # Purple
	Zcolors[UCyan]='\033[4;36m'        # Cyan
	Zcolors[UWhite]='\033[4;37m'       # White

	# Background
	Zcolors[On_Black]='\033[40m'       # Black
	Zcolors[On_Red]='\033[41m'         # Red
	Zcolors[On_Green]='\033[42m'       # Green
	Zcolors[On_Yellow]='\033[43m'      # Yellow
	Zcolors[On_Blue]='\033[44m'        # Blue
	Zcolors[On_Purple]='\033[45m'      # Purple
	Zcolors[On_Cyan]='\033[46m'        # Cyan
	Zcolors[On_White]='\033[47m'       # White

	# High Intensity
	Zcolors[IBlack]='\033[0;90m'       # Black
	Zcolors[IRed]='\033[0;91m'         # Red
	Zcolors[IGreen]='\033[0;92m'       # Green
	Zcolors[IYellow]='\033[0;93m'      # Yellow
	Zcolors[IBlue]='\033[0;94m'        # Blue
	Zcolors[IPurple]='\033[0;95m'      # Purple
	Zcolors[ICyan]='\033[0;96m'        # Cyan
	Zcolors[IWhite]='\033[0;97m'       # White

	# Bold High Intensity
	Zcolors[BIBlack]='\033[1;90m'      # Black
	Zcolors[BIRed]='\033[1;91m'        # Red
	Zcolors[BIGreen]='\033[1;92m'      # Green
	Zcolors[BIYellow]='\033[1;93m'     # Yellow
	Zcolors[BIBlue]='\033[1;94m'       # Blue
	Zcolors[BIPurple]='\033[1;95m'     # Purple
	Zcolors[BICyan]='\033[1;96m'       # Cyan
	Zcolors[BIWhite]='\033[1;97m'      # White

	# High Intensity backgrounds
	Zcolors[On_IBlack]='\033[0;100m'   # Black
	Zcolors[On_IRed]='\033[0;101m'     # Red
	Zcolors[On_IGreen]='\033[0;102m'   # Green
	Zcolors[On_IYellow]='\033[0;103m'  # Yellow
	Zcolors[On_IBlue]='\033[0;104m'    # Blue
	Zcolors[On_IPurple]='\033[0;105m'  # Purple
	Zcolors[On_ICyan]='\033[0;106m'    # Cyan
	Zcolors[On_IWhite]='\033[0;107m'   # White


#for colorsKVtext in "${Zcolors[@]}"; do

for key val in "${(@kv)Zcolors}"; do
	colorsKVtext="$key $val"
  numletters=${#${colorsKVtext}}
  numlet=$(( numletters / 2 ))
  cols=$(( COLUMNS / 2 ))
  asubtr=$(( cols - numlet ))
  subtr=$(( asubtr - 1 ))
  tcols="${(r:$asubtr::.:)}"
  solidline="${(r:$COLUMNS::—:)}"

  # header="${solidline}\n${tcols}${color_green}${colorsKVtext}${tcols}${solidline}\n${bind}"

	# plainText=$(print -r "$colorsKVtext")
	plainText="$colorsKVtext"
	# print -f "${solidline}\n${tcols}${color_green}${plainText}${tcols}${solidline}\n"

	# print -nf "${colorsKVtext}${solidline}${tcols}"
	# print -nr "${solidline}${tcols}${plainText}${tcols}${solidline}"
 #  print -f "${colorsKVtext}${tcols}${solidline}"
	#

	echo "${val}${solidline}${tcols}${solidline}${tcols}${plainText}${tcols}${solidline}${colorsKVtext}${tcols}${solidline}"
done

return

${}

	for key val in "${(@kv)Zcolors}"; do
		echo "$key -> $val"
	done
	sleep 1


	for i in "${!Zcolors[@]}"
    do
	  echo -e "$i = ${Zcolors[$i]}I love you$white"
	done



#





  }

