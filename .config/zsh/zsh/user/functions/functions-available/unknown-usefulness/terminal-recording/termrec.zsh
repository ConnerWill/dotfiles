


function termrec(){


  local TERMINAL_RECORDING_DIR="$HOME/videos/terminal-recordings"
  local NOW="$(date +'%Y%m%d-%H%M')"
  local NEW_TERMINAL_RECORDING_DIR="$TERMINAL_RECORDING_DIR/$NOW-terminal-recording"
  local NEW_TERMINAL_RECORDING_PATH="$NEW_TERMINAL_RECORDING_DIR/$NOW-terminal-recording.ttyrec"
  local NEW_TERMINAL_RECORDING_DESC_PATH="$NEW_TERMINAL_RECORDING_DIR/Description"
  
  which ttyrec \
    || return 1 
  
  [[ -d "$TERMINAL_RECORDING_DIR" ]] \
    || mkdir -v -p "$HOME/videos/terminal-recordings"

  mkdir -v -p "$NEW_TERMINAL_RECORDING_DIR" \
    || return 1

  clear 

  echo -n -e "\e[32m(START)\e[0m\e[34m ENTER DESCRIPTION OF RECORDING:\e[0m    "
  read -r >> "$NEW_TERMINAL_RECORDING_DESC_PATH" 

  clear

  ttyrec \
    --output "$NEW_TERMINAL_RECORDING_PATH" \
      --append \
        --kill-timeout 1200 \
        --warn-before-kill 600

  clear 

  echo -n -e "\e[32m(END)\e[0m\e[34m ENTER DESCRIPTION OF RECORDING:\e[0m    "
  read -r >> "$NEW_TERMINAL_RECORDING_DESC_PATH"
  
  clear
  
  echo -e "\e[32mDONE\e[0m"
  echo -e "\e[34mSAVED TO:\e[0m  \e[33m$NEW_TERMINAL_RECORDING_DIR\e[0m"
}
