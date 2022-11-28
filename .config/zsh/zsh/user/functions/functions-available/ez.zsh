#shellcheck disable=2296,2148

function ez(){

	function _ez_printcentered(){

		local printstring=()
		local flag_verbose=false
		local fill=myfile

		declare -Al colors
		colors[off]='[0m'
		colors[Black]='[30m'
		colors[Gray]='[38;5;7m'
		colors[DarkGray]='[38;5;8m'
		colors[White]='[37m'
		colors[Red]='[38;5;196m'
		colors[Green]='[38;5;46m'
		colors[Yellow]='[38;5;190m'
		colors[Blue]='[38;5;33m'
		colors[Purple]='[38;5;93m'
		colors[Cyan]='[38;5;87m'     # [0m
		colors[bold]='[1m'
		colors[italic]='[3m'
		colors[underline]='[4m'      # [0m
		colors[reset]='[0m'


		while (( $# )); do
			case $1 in
				-*) printf "Unknowm option:\t%s" "${@}" && return 2 ;;
				*)  printstring+=("${@[@]}"); break        ;;
			esac
			shift
		done

  declare -i NB_COLS filler_len str_len
  NB_COLS=$(( COLUMNS - $(( ${#surround} * 2 )) )) # $((  )) ))
  str_len="${#printstring}"
  filler_len="$(( (NB_COLS - str_len) / 2 ))"          # Build the chars to add before and after the given text
  [[ $# -ge 2 ]] && ch="${2:0:1}" || ch=" "
  for (( i = 0; i < filler_len; i++ )); do
    filler="${filler}${ch}"
  done

  printf "%s%s%s%s%s" "$surround" "$filler" "$printstring" "$filler" "$surround"  # Add an additional filler char at the end if the result length is not even
  [[ $(( (NB_COLS - str_len) % 2 )) -ne 0 ]] && printf "%s" "${ch}"
  printf "%s" "${SURROUNDING_CHAR}"
  return 0
}

	printf "\e[2K\e[1A\e[2K\r"
	printf "\e[0;1;38;5;46m"
	_ez_printcentered "Reloading ..."
	printf "\e[0m\e[1A\r"
	exec ${(k)commands[zsh]}
}
