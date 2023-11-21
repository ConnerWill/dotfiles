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

### Define Plugin Directory
[[ -z "${ZSH_USER_DIR}" ]] && export ZSH_USER_DIR="${ZDOTDIR}/zsh/${ZSH_USER_NAME:-user}"
      ZSH_PLUGINS_DIR="${ZSH_USER_DIR}/plugins"
ZSH_PLUGINS_AVAILABLE="${ZSH_PLUGINS_DIR}/plugins-available"
  ZSH_PLUGINS_ENABLED="${ZSH_PLUGINS_DIR}/plugins-enabled"
export ZSH_PLUGINS_AVAILABLE ZSH_PLUGINS_ENABLED ZSH_PLUGINS_CONFIG_DIR

## Load plugins
#shellcheck disable=1009,1072,1058,1036,1073
if [[ -d "${ZSH_PLUGINS_ENABLED}" ]]; then
  for ZSH_FILE in "${ZSH_PLUGINS_ENABLED}"/*.zsh(N); do
    source "${ZSH_FILE}" || _zshrc_VERBOSE_ERROR "Unable to source plugin file: ${ZSH_FILE}"
  done
else
  _zshrc_VERBOSE_ERROR "Plugin directory does not exist: ${ZSH_PLUGINS_ENABLED}"
fi


## Custom sourcing plugins. Source plugins like this that require sourcing a specific file
zsh_source_plugin_tmp="${ZSH_PLUGINS_AVAILABLE}/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -e "${zsh_source_plugin_tmp}" ]]; then
  source "${zsh_source_plugin_tmp}" || _zshrc_VERBOSE_ERROR "Unable to source plugin file: ${ZSH_FILE}"
fi
unset zsh_source_plugin_tmp

zsh_source_plugin_tmp="${ZSH_PLUGINS_AVAILABLE}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
if [[ -e "${zsh_source_plugin_tmp}" ]]; then
  source "${zsh_source_plugin_tmp}" \
    && fast-theme dampsock2 >/dev/null 2>&1 \
    || _zshrc_VERBOSE_ERROR "Unable to source plugin file: ${ZSH_FILE}"
fi
unset zsh_source_plugin_tmp
