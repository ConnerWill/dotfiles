#shellcheck disable=2296,2148

function ez(){
	printf "\e[2K\e[1A\e[2K\r"
	printf "\e[0;1;38;5;46mReloading zsh ...\e[0m"
	exec ${(k)commands[zsh]}
}
