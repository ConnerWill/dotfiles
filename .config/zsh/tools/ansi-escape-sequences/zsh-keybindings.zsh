# shellcheck disable=2148

function zshprintkey(){

	typeset -A Zcolors

	# Regular Colors          # Background
	Zcolors[Color_Off]='[0m' # # Text Reset
	Zcolors[Black]='[30m'    # Zcolors[On_Black]='40m' # Black
	Zcolors[Red]='[38;5;196m'      #   Zcolors[On_Red]='41m' # Red
	Zcolors[Green]='[38;5;46m'    # Zcolors[On_Green]='42m' # Green
	Zcolors[Yellow]='[38;5;190m'   #Zcolors[On_Yellow]='43m' # Yellow
	Zcolors[Blue]='[38;5;33m'     #  Zcolors[On_Blue]='44m' # Blue
	Zcolors[Purple]='[38;5;93m'   #Zcolors[On_Purple]='45m' # Purple
	Zcolors[Cyan]='[38;5;87m'     #  Zcolors[On_Cyan]='46m' # Cyan
	Zcolors[White]='[37m'    # Zcolors[On_White]='47m' # White

	hi="ZSH KEYBINDINGS"
	# SLEEPTIME="${1:-0}"
	SLEEPTIME=0

	Xnumletters=${#${hi}}
	Xnumlet=$(( Xnumletters / 2 ))
	Xcols=$(( COLUMNS / 2 ))
	Xsubtr=$(( Xcols - Xnumlet ))
	Xtcols="${(r:$Xsubtr:: :)}"
	Xsolidline="${(r:$COLUMNS::—:)}"
  printf "${Zcolors[Cyan]}%s%s${Zcolors[Purple]}%s%s${Zcolors[Cyan]}%s${Zcolors[Color_Off]}\n" "${Xsolidline}" "${Xtcols}" "${hi}" "${Xtcols}" "${Xsolidline}"
	printf "${Zcolors[Magenta]}KEYMAPS${Zcolors[Color_Off]}:\n"
	print -l ${keymaps}
	for keym in "${keymaps[@]}"; do
		numletters=${#${keym}}
		numlet=$(( numletters / 2 ))
		cols=$(( COLUMNS / 2 ))
		subtr=$(( cols - numlet ))
		tcols="${(r:$subtr:: :)}"
		solidline="${(r:$COLUMNS::—:)}"
		bind=$(zsh --onecmd -c "bindkey -R -M ${keym}" | sort )
		[[ -n "${bind}" ]] && printf "${Zcolors[Yellow]}%s${Zcolors[Color_Off]}%s${Zcolors[Green]}%s${Zcolors[Color_Off]}%s${Zcolors[Yellow]}\n%s${Zcolors[Color_Off]}%s\n" "${solidline}" "${tcols}" "${keym}" "${tcols}" "${solidline}" "${bind}"
		sleep $SLEEPTIME
	done
	unset hi Xcols Xsubtr Xtcols Xnumlet Xnumletters Xsolidline
	Xnumletters=${#${hi}}
	Xnumlet=$(( Xnumletters / 2 ))
	Xcols=$(( COLUMNS / 2 ))
	Xsubtr=$(( Xcols - Xnumlet ))
	Xtcols="${(r:$Xsubtr:: :)}"
	Xsolidline="${(r:$COLUMNS::—:)}"
  printf "${Zcolors[Cyan]}%s%s${Zcolors[Purple]}%s%s${Zcolors[Cyan]}%s${Zcolors[Color_Off]}\n" "${Xsolidline}" "${Xtcols}" "${hi}" "${Xtcols}" "${Xsolidline}"
}
