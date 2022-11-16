
# Pre-Load ZSH Config

if [[ -n "$_ZSH_BANNER_SHOW" ]]; then
  if [[ -n "$_ZSH_BANNER_START" ]]; then

    ### ZSH Banner To Show Before Loading ZSHRC
    BANNER_TEXT=" $(whoami)"
    BANNER_TEXT_FIGLET_FONT="Bloody"
    LINE_CHAR="═" # ━" # ═ █

    BANNER_TEXT_CHARS_BEFORE="$(echo $BANNER_TEXT | wc --chars)"
    BANNER_LINE_MULTIPLY=8
    BANNER_TEXT_CHARS="$(( $BANNER_TEXT_CHARS_BEFORE * $BANNER_LINE_MULTIPLY ))"

    function Draw_Line(){
      local begin=1
      local end=$BANNER_TEXT_CHARS
      for (( i = begin; i < end; i++ )); do
        echo -n "$LINE_CHAR"
      done
    }

    function Show_Banner(){
      figlet -f "$BANNER_TEXT_FIGLET_FONT" "$BANNER_TEXT" \
        | lolcat
    }

    function Empty_Line(){
      echo ""
    }
    Draw_Line
    Empty_Line
    Show_Banner
    Draw_Line
    Empty_Line
  fi
fi


### []==========================[]
### []      GPG/SSH Agent
### []==========================[]
#shellcheck source=./zsh-gpg-agent.zsh
function _StartGPGAgent(){
  if [[ -e "${ZDOTDIR}/zsh-gpg-agent.zsh" ]];then #"$ZDOTDIR/plugins/plugin-store/gpg-agent.zsh"
    source "${ZDOTDIR}/zsh-gpg-agent.zsh" \
      || printf "\e[0;38;5;190m%s\e[0m\t\e[0;1;38;5;196m%s\e[0m\n" "UNABLE TO SOURCE" "ZSH-GPG-AGENT" \
      && printf "\e[0;38;5;190m%s\e[0m\t\e[0;1;38;5;82m%s\e[0m\n" "SOURCED" "ZSH-GPG-AGENT"
  else
    printf "%s \e[0;38;5;190m\e[0m%s\t\e[0;1;38;5;196m%s\e[0m\n" "CANNOT LOCATE" "ZSH-GPG-AGENT" "${ZDOTDIR}/zsh-gpg-agent.zsh"
  fi
}
#_StartGPGAgent ; unfunction _StartGPGAgent



# # this will start new tmux session if you connect remotely; if you want
# # to suppress it, just use "TERM=screen ssh user@host" and reset your
# # $TERM back to xterm, or launch screen/tmux on local host.
# # If we're already in screen or not on ssh connection (local access),
# # don't run the rest of the code (shell is secure)
# if [[ "${TERM}" != "screen" ]] && [[ -n "${SSH_CONNECTION}" ]]; then
#   tmux_command="$(command -v tmux)"
#   if [[ -n "${tmux_command}" ]] ; then
#     if tmux -q has-session -t "${tmux_session}" 2> /dev/null; then
#       tmux -q attach-session -t "${tmux_session}"
#     else
#       tmux -q new-session -s "${tmux_session}"
#     fi
#   fi
# fi

