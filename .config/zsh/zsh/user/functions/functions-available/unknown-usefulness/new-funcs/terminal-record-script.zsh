function script-terminal-rec(){

	# Check if output folder exists
    [[ -z "$ASCIINEMA_OUTPUT_DIR" ]] && local ASCIINEMA_OUTPUT_DIR="$HOME/terminal-recordings"
	[[ ! -d "$ASCIINEMA_OUTPUT_DIR" ]] && mkdir -p -v "$ASCIINEMA_OUTPUT_DIR"
    [[ ! -d "$ASCIINEMA_OUTPUT_DIR" ]] && echo -e "\e[38;5;196mERROR!\e[0m\t\e[38;5;190mCannot create directory to save recordings\e[0m:\t\e[38;5;45m$ASCIINEMA_OUTPUT_DIR" && return
	local RECORDING_FILE_NAME="$(date +'%Y%m%d-%H%M%S')_Terminal-Recording"
	local RECORDING_FILE="$ASCIINEMA_OUTPUT_DIR/$RECORDING_FILE_NAME"
	# Start Recording session.
    echo -e "\e[38;5;46mRecording Terminal Session\e[0m \e[38;5;190m...\e[0m"
    sleep 2
    script --timing="$RECORDING_FILE" --logging-format=Advanced
    echo -e "\e[38;5;190mTo play the recorded terminal session, use command\e[0m:\n\n\t\e[38;5;45mscriptreplay --typescript=typescript --timing=\"$RECORDING_FILE\"\e[0m\n"

}

