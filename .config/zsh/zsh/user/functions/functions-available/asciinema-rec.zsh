function asciinema-rec(){
	local USERINPUT ASCIINEMA_OUTPUT_DIR ASCIINEMA_OUTPUT_DIR_DEFAULT ASCIINEMA_OUTPUT_NAME ASCIINEMA_OUTPUT_PATH
	command -v asciinema >/dev/null 2>&1 \
		|| printf "asciinema is not installed :(\n" \
		|| return 1
	## Define output directory and file name
	## If user passes input into this function, that input will be used as 'ASCIINEMA_OUTPUT_PATH'
	USERINPUT="${*}"
	ASCIINEMA_OUTPUT_DIR_DEFAULT="${PWD}"
	ASCIINEMA_OUTPUT_NAME_DEFAULT="$(date +%Y%m%d_%H%M%S)-asciinema-terminal-recording.yml"
	ASCIINEMA_OUTPUT_DIR="${ASCIINEMA_OUTPUT_DIR:-${ASCIINEMA_OUTPUT_DIR_DEFAULT:-${PWD}}}"
	ASCIINEMA_OUTPUT_PATH="${USERINPUT:-${ASCIINEMA_OUTPUT_DIR/${ASCIINEMA_OUTPUT_NAME_DEFAULT}}}"
	ASCIINEMA_OUTPUT_NAME="$(dirname "${ASCIINEMA_OUTPUT_PATH}")"
	ASCIINEMA_OUTPUT_NAME="$(basename "${ASCIINEMA_OUTPUT_PATH}")"
	OUTPUT_PATH_TEMP="${HOME}/${ASCIINEMA_OUTPUT_NAME}"
	# Check if output folder exists
	if [[ ! -d "$ASCIINEMA_OUTPUT_DIR" ]]; then
		mkdir -vp "${ASCIINEMA_OUTPUT_DIR}" \
			|| ASCIINEMA_OUTPUT_DIR="${ASCIINEMA_OUTPUT_DIR_DEFAULT}" \
			|| printf "Cannot create directory. Saving recording to current directory:\t%s\n" "${ASCIINEMA_OUTPUT_PATH}"
	fi
	printf "\n\n\n\#[0;1;38;5;9mStarting recording\e[0m"; sleep 1; printf "\t3 "; sleep 1; printf "\t2"; sleep 1; printf "\t1"; sleep 1; printf "\n"
	if asciinema rec "${OUTPUT_PATH_TEMP}"; then
		printf "Re-rendering recording\n"
		asciinema rec "asciinema play -s 5 -i 2 ${OUTPUT_PATH_TEMP}" -t "${ASCIINEMA_OUTPUT_NAME}" "${ASCIINEMA_OUTPUT_PATH}" \
			&& rm -f "${OUTPUT_PATH_TEMP}" \
			&& printf "\n\;\e[0;38;5;46mSaved recording to:\t\e[0;1;38;5;190m%s\e[0m\n\n" "${ASCIINEMA_OUTPUT_PATH}" \
			&& sleep 3 && return 0
	fi
}
