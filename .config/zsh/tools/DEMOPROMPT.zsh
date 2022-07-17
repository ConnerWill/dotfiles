

function DEMOPROMPT(){ 
	local prompttext
	prompttext="$1"
	[[ -z "$prompttext" ]] \
		&& prompttext="DEMO"
	export origPROMPT="$PROMPT"
 
	clear
	PROMPTDELIMITER1=$'%{\e[$((color=$((30+$RANDOM % 8))))m%}[%{\e[00m%}'
	PROMPTDELIMITER2=$'%{\e[$((color=$((30+$RANDOM % 8))))m%}>%{\e[00m%}'
	PROMPTDELIMITER3=$'%{\e[$((color=$((30+$RANDOM % 8))))m%}: %{\e[00m%}'
	PROMPTREC=$'%{\e[$((color=$((40+$RANDOM % 8))))m\e[$((color=$((30+$RANDOM % 8))))m%}[%{\e[00m%}%f%{\e[$((color=$((40+$RANDOM % 8))))m\e[$((color=$((30+$RANDOM % 8))))m%}'
	PROMPTRECEND=$'%{\e[00m%}%f%{\e[$((color=$((40+$RANDOM % 8))))m\e[$((color=$((30+$RANDOM % 8))))m%}]%{\e[00m%}%f'
	export PROMPT="$PROMPTREC$prompttext$PROMPTRECEND$PROMPTDELIMITER1$PROMPTDELIMITER2$PROMPTDELIMITER3"

	function DEMOPROMPT_RESTORE(){
		[[ -z "$origPROMPT" ]] \
			&& exec zsh \
		|| export PROMPT="$origPROMPT"
		}
}

