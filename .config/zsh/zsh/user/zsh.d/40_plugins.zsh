
## ShellCheck Setup{{{

# shellcheck disable=2148
# shellcheck disable=SC2236
# shellcheck enable=quote-safe-variables
# shellcheck enable=check-unassigned-uppercase
# shellcheck enable=require-variable-braces
# shellcheck source-path=SCRIPTDIR
# shellcheck source-path=/etc/zsh/zshenv
# shellcheck source-path=/etc/zsh/zprofile
# shellcheck source=./.zshenv
# shellcheck source=./.zprofile
# shellcheck source=./.zlogin
# shellcheck source=./banner/zshbanner.zsh
# shellcheck source=./variables/zshvariables.zsh
# shellcheck source=./options/zshoptions.zsh
# shellcheck source=./aliases/zshalias.zsh
# shellcheck source=./history/zshhistory.zsh
# shellcheck source=./keybindings/zshkeybindings.zsh
# shellcheck source=./functions/zshfunctions.zsh
# shellcheck source=./themes-prompts/zshpromptsthemes.zsh
# shellcheck source=./modules/zshmodules.zsh
# shellcheck source=./plugins/zshplugins.zsh
# shellcheck source=./completions/zshcompletions.zsh
##}}}
### [=============================]
### [-------- ZSH PLUGINS --------]
### [=============================]
### {{{ Help
### [=============================]--------------------------]
### [ Example:                                               ]
### [  $ source "$ZSH_CUSTOM_PLUGINS/path-to/zsh-plugin.zsh" ]
### [=============================]--------------------------]
### }}}


### Define Plugin Directory
export                    \
  ZSH_PLUGINS_AVAILABLE   \
  ZSH_PLUGINS_ENABLED     \
  ZSH_PLUGINS_CONFIG_DIR

[[ -z "${ZSH_USER_DIR}" ]] && export ZSH_USER_DIR="${ZDOTDIR}/zsh/${ZSH_USER_NAME:-user}"
      ZSH_PLUGINS_DIR="${ZSH_USER_DIR}/plugins"
ZSH_PLUGINS_AVAILABLE="${ZSH_PLUGINS_DIR}/plugins-available"
  ZSH_PLUGINS_ENABLED="${ZSH_PLUGINS_DIR}/plugins-enabled"

## Load plugins
# shellcheck disable=SC1009
if [[ -d "${ZSH_PLUGINS_ENABLED}" ]]; then
  # shellcheck disable=SC1072,SC1058,SC1036,SC1073
  for ZSH_FILE in "${ZSH_PLUGINS_ENABLED}"/*.zsh(N); do
      _zshrc_VERBOSE_MESSEGE "  Plugin  " "$(basename ${ZSH_PLUGINS_ENABLED})/$(basename ${ZSH_FILE})" "201" "57"
      source "${ZSH_FILE}" || _zshrc_VERBOSE_ERROR "Plugin Failed" "[${ZSH_FILE}]" "196" "190"
  done
else
  _zshrc_VERBOSE_ERROR "Directory does not exist" "[${ZSH_PLUGINS_ENABLED}]" "196" "124"
fi


zsh_source_plugin_tmp="${ZSH_PLUGINS_AVAILABLE}/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -e "${zsh_source_plugin_tmp}" ]] && source "${zsh_source_plugin_tmp}"; unset zsh_source_plugin_tmp


zsh_source_plugin_tmp="${ZSH_PLUGINS_AVAILABLE}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
[[ -e "${zsh_source_plugin_tmp}" ]] && source "${zsh_source_plugin_tmp}"; unset zsh_source_plugin_tmp


