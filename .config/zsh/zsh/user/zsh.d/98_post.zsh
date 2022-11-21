###{{{ ShellCheck Setup
#shellcheck disable=2148
#shellcheck disable=SC2236
#shellcheck enable=quote-safe-variables
#shellcheck enable=check-unassigned-uppercase
#shellcheck enable=require-variable-braces
#shellcheck source-path=SCRIPTDIR
#shellcheck source-path=/etc/zsh/zshenv
#shellcheck source-path=/etc/zsh/zprofile
#shellcheck source=../../../.zshenv
#shellcheck source=../../../.zprofile
#shellcheck source=../../../.zshrc
#shellcheck source=./00_pre.zsh
#shellcheck source=./10_variables.zsh
#shellcheck source=./20_options.zsh
#shellcheck source=./21_history.zsh
#shellcheck source=./30_modules.zsh
#shellcheck source=./40_plugins.zsh
#shellcheck source=./50_keybindings.zsh
#shellcheck source=./60_functions.zsh
#shellcheck source=./70_aliases.zsh
#shellcheck source=./80_hooks.zsh
#shellcheck source=./81_prompts.zsh
#shellcheck source=./82_colors.zsh
#shellcheck source=./83_vcs_prompts.zsh
#shellcheck source=./85_highlighting.zsh
#shellcheck source=./90_completions.zsh
#shellcheck source=./99_post.zsh
##}}}



## Load final plugins
[[ -z "${ZSH_USER_DIR}" ]] && export ZSH_USER_DIR="${ZDOTDIR}/zsh/${ZSH_USER_NAME:-user}"
ZSH_PLUGINS_DIR="${ZSH_USER_DIR}/plugins"
ZSH_PLUGINS_AVAILABLE="${ZSH_PLUGINS_DIR}/plugins-available"

zsh_source_plugin_tmp="${ZSH_PLUGINS_AVAILABLE}/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
[[ -e "${zsh_source_plugin_tmp}" ]] && source "${zsh_source_plugin_tmp}"
unset zsh_source_plugin_tmp

zsh_source_plugin_tmp="${ZSH_PLUGINS_AVAILABLE}/history-search-multi-word/history-search-multi-word.plugin.zsh"
[[ -e "${zsh_source_plugin_tmp}" ]] \
  && if source "${zsh_source_plugin_tmp}"; then
        zstyle ":history-search-multi-word" highlight-color "fg=201,bg=16,bold"
        # Color in which to highlight matched, searched text (default bg=17 on 256-color terminals)
        zstyle ":history-search-multi-word" page-size "12"
        # Number of entries to show (default is $LINES/3)
        zstyle ":plugin:history-search-multi-word" active "fg=87,bg=233,underline"
        # Effect on active history entry. Try: standout, bold, bg=blue (default underline)
        zstyle ":plugin:history-search-multi-word" check-paths "no"
        # Whether to check paths for existence and mark with magenta (default true)
        zstyle ":plugin:history-search-multi-word" clear-on-cancel "no"
        # Whether pressing Ctrl-C or ESC should clear entered query
        zstyle ":plugin:history-search-multi-word" synhl "yes"
        # Whether to perform syntax highlighting (default true)
  fi
unset zsh_source_plugin_tmp

function zsh_banner_load(){
  ## ZSH Banner To Show After Loading ZSHRC
  if [[ -n "${ZSH_BANNER_SHOW}" ]]; then
    if [[ -z "${ZSH_BANNER_START}" ]]; then
      ## ZSH Banner To Show Before Loading ZSHRC
      BANNER_TEXT=" $(whoami)"
      BANNER_TEXT_FIGLET_FONT="Bloody"
      LINE_CHAR="═" # ━" # ═ █
      BANNER_TEXT_CHARS_BEFORE="$(echo "${BANNER_TEXT}"| wc --chars)"
      BANNER_LINE_MULTIPLY=8
      BANNER_TEXT_CHARS="(( ${BANNER_TEXT_CHARS_BEFORE} * ${BANNER_LINE_MULTIPLY} ))"
      function Draw_Line(){
        local begin end
        begin=1; end="${BANNER_TEXT_CHARS}"
        for (( i = begin; i < end; i++ )); do
          echo -n "${LINE_CHAR}"
        done
      }
      function Show_Banner(){
        figlet -f "${BANNER_TEXT_FIGLET_FONT}" "${BANNER_TEXT}" | lolcat
      }
      function Empty_Line(){
        printf "\n"
      }
      Draw_Line && Empty_Line && Show_Banner && Draw_Line && Empty_Line
    else
      Draw_Line && Empty_Line
    fi
  fi
}; zsh_banner_load
