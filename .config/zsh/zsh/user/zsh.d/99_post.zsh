## ShellCheck Setup{{{

# Disable warnings of adding shebang or a 'shell' directive.
# shellcheck disable=2148
# Allow [ ! -z foo ] instead of suggesting -n
# shellcheck disable=SC2236

# Turn on warnings for unquoted variables with safe values
# shellcheck enable=quote-safe-variables

# Turn on warnings for unassigned uppercase variables
# shellcheck enable=check-unassigned-uppercase

# Suggest ${VAR} in place of $VAR
# shellcheck enable=require-variable-braces

# Look for 'source'd files relative to the checked script,
# and also look for absolute path
# shellcheck source-path=SCRIPTDIR
# shellcheck source-path=/etc/zsh/zshenv 
# shellcheck source-path=/etc/zsh/zprofile 
# shellcheck source=../../../.zshenv
# shellcheck source=../../../.zprofile
# shellcheck source=../../../.zshrc
# shellcheck source=./00_pre.zsh
# shellcheck source=./10_variables.zsh
# shellcheck source=./20_options.zsh
# shellcheck source=./21_history.zsh
# shellcheck source=./30_modules.zsh
# shellcheck source=./40_plugins.zsh
# shellcheck source=./50_keybindings.zsh
# shellcheck source=./60_functions.zsh
# shellcheck source=./70_aliases.zsh
# shellcheck source=./80_hooks.zsh
# shellcheck source=./81_prompts.zsh
# shellcheck source=./82_colors.zsh
# shellcheck source=./83_vcs_prompts.zsh
# shellcheck source=./85_highlighting.zsh
# shellcheck source=./90_completions.zsh
# shellcheck source=./99_post.zsh
##}}}

[[ -z "${ZSH_USER_DIR}" ]] && export ZSH_USER_DIR="${ZDOTDIR}/zsh/${ZSH_USER_NAME:-user}"
      ZSH_PLUGINS_DIR="${ZSH_USER_DIR}/plugins"
ZSH_PLUGINS_AVAILABLE="${ZSH_PLUGINS_DIR}/plugins-available"

zsh_source_plugin_tmp="${ZSH_PLUGINS_AVAILABLE}/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
[[ -e "${zsh_source_plugin_tmp}" ]] && source "${zsh_source_plugin_tmp}"
unset zsh_source_plugin_tmp

### ZSH Banner To Show After Loading ZSHRC
if [[ -n "${ZSH_BANNER_SHOW}" ]]; then
  if [[ -z "${ZSH_BANNER_START}" ]]; then

    ### ZSH Banner To Show Before Loading ZSHRC
    BANNER_TEXT=" $(whoami)"
    BANNER_TEXT_FIGLET_FONT="Bloody"
    LINE_CHAR="═" # ━" # ═ █

    BANNER_TEXT_CHARS_BEFORE="$(echo "${BANNER_TEXT}"| wc --chars)"
    BANNER_LINE_MULTIPLY=8
    BANNER_TEXT_CHARS="(( ${BANNER_TEXT_CHARS_BEFORE} * ${BANNER_LINE_MULTIPLY} ))"

    function Draw_Line(){
      local begin=1
      local end="${BANNER_TEXT_CHARS}"
      for (( i = begin; i < end; i++ )); do
        echo -n "${LINE_CHAR}" 
      done
    }

    function Show_Banner(){
      figlet -f "${BANNER_TEXT_FIGLET_FONT}" "${BANNER_TEXT}" \
        | lolcat
    }

    function Empty_Line(){
      printf "\n"
    }

    Draw_Line && Empty_Line && Show_Banner && Draw_Line && Empty_Line
  else
    Draw_Line && Empty_Line
  fi
fi
