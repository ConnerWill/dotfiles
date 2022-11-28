#shellcheck disable=2296,2148

function ez(){
	[[ -z "${commands[zsh]}" ]] || printf "\e[0;1;38;5;196mCannot find:\tzsh\e[0m\n" || return 1
	printf "\e[1A\e[2K\e[1A\e[2K\r"
	printf "\e[0;1;38;5;46mReloading zsh ...\e[0m"; sleep 0.25
	printf "\r\e[2K\r"
	exec ${(k)commands[zsh]}
}
