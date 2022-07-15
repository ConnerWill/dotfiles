source "${ZSH_PLUGINS_AVAILABLE}/zsh-vim-mode/zsh-vim-mode.plugin.zsh"
source "${ZSH_PLUGINS_AVAILABLE}/zsh-vim-mode/zsh-vim-mode-plugin-settings.zsh"

### ZSH Banner To Show After Loading ZSHRC
if [[ -n "$_ZSH_BANNER_SHOW" ]]; then
  if [[ -z "$_ZSH_BANNER_START" ]]; then

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
  else
    Draw_Line
    Empty_Line
  fi
fi
