function zshreload(){

  ## Hide Cursor
  # echo -ne "\e[?25l"

  ## Move curser up 1 line
  echo -ne "\e[1A"

  ## Clear line
  echo -ne "\e[2K"

  ## Move cursor to beginning of line
  echo -ne "\r"

  exec zsh

  ## Restore Cursor
  #echo -ne "\e[?25h"

}
