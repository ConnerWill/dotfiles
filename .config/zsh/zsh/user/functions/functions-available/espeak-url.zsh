### espeak-url.zsh
function espeak-url(){
  # localize our variables
  local espeakcmd espeakpath espeak_voice espeak_speed espeak_outputdir espeak_outputname espeak_outputpath
  local html2textcmd html2textpath
  local inputurl
  
  # User config section, modify if you please
  espeakcmd="espeak"
  espeak_voice="english-us"
  espeak_speed=200
  espeak_outputdir="$HOME/temporary/espeak"
  espeak_outputname="$(date +'%Y%m%d%H%M%S')-espeak.wav"
  html2textcmd="html2text"
  # End user config

  # Defined input to variables
  inputurl="$1"
  # Check if we can find command. If we cant, show error and return
  espeakpath="$(which $espeakcmd)"
  [[ -e "$espeakpath" ]] \
    || printf "\e[0;38;5;196mCannot find: \e[0m\t\e[0;1;38;5;190m%s\e[0m\n" "$espeakcmd" \
      || return 1
  # Check if we can find command. If we cant, show error and return
  html2textpath="$(which $html2textcmd)"
  [[ -e "$html2textpath" ]] \
    || printf "\e[0;38;5;196mCannot find: \e[0m\t\e[0;1;38;5;190m%s\e[0m\n" "$html2textcmd" \
      || return 1
  # Check if input was received. If no input, show error and return
  [[ -z "$inputurl" ]] \
    && printf "\e[0;38;5;196mNo input URL\e[0m\n" \
      && return 1
  # Check if output dir is defined 
  if [[ -n "$espeak_outputdir" ]]; then
  # Repeat until directory exists or we are unable to create directory
    while [[ ! -d "$espeak_outputdir" ]]; do
      # Show messege that directory doesnt exist
      printf "\e[0;38;5;190mOutput directory does not exist: \e[0m\t\e[0;1;38;5;201m%s\e[0m\n" "$espeak_outputdir"
      printf "\e[0;38;5;51mCreating directory: \e[0m\t\t\e[0;1;38;5;93m%s\e[0m\n" "$espeak_outputdir"
      # sleep incase of error and tries to create directories over and over
      sleep 3
      # Attempt to create directory
      # Show messege and return if fails
      # Show messege and continue command if success
      mkdir -p -v "$espeak_outputdir" \
        || printf "\e[0;38;5;196mUnable to create directory: \e[0m\t\e[0;1;38;5;190m%s\e[0m\n" "$espeak_outputdir" \
          || return 1 \
        && printf "\e[0;38;5;82mCreated directory: \e[0m\t\t\e[0;1;38;5;190m%s\e[0m\n" "$espeak_outputdir" 
    done
    # combine output directory and output file name
    espeak_outputpath="$espeak_outputdir/$espeak_outputname"
    # Run command.
    # Pipe inputurl into html2text 
    # Then pipe into espeak which saves a wav file of spoken text from the content at inputurl to espeak_outputpath
    # If error running commands, show error and return
    curl -sSL "$inputurl" \
        | "${html2textpath}" \
              | "${espeakpath}" \
                  --stdin \
                  -v "$espeak_voice" \
                  -s "$espeak_speed" \
                  -w "$espeak_outputpath" \
    && printf "\e[0;38;5;51mSaved wav file to: \e[0m\t\e[0;1;38;5;93m%s\e[0m\n" "$espeak_outputpath" \
      && return 0 \
    || printf "\e[0;38;5;190mError: \e[0m\n" \
      || return 1
  else
    # Check if ouputdir is defined. If not defined, show error and return
    printf "\e[0;38;5;190mOutput directory is not defined: \e[0m\t\e[0;1;38;5;201mespeak_outputdir\e[0m\n"
    return 1
  fi
}





            # --mark-code \
            # --unicode-snob \
            # --body-width=0 \
            # --open-quote '**' \
            # --close-quote '**' \
            # --reference-links \
            # --pad-tables \
            # --images-to-alt \
            # --no-wrap-links \
            # --hide-strikethrough \
            # --decode-errors=ignore 
