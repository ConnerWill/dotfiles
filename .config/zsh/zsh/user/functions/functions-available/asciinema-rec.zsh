function asciinema-rec(){

	# Check if output folder exists
	if [ ! -d "$ASCIINEMA_OUTPUT_DIR" ]
	then
		mkdir -p -v "$ASCIINEMA_OUTPUT_DIR"
	fi

	local RECORDING_FILE_NAME="$DATE-$TIME-Terminal-Recording"
	local RECORDING_FILE="$ASCIINEMA_OUTPUT_DIR/$RECORDING_FILE_NAME"

	# Start Recording session.
	asciinema rec --title "$RECORDING_FILE_NAME" "$RECORDING_FILE"
}
