
###
### Title	40_plugins.zsh
### Author	: ConnerWill
### Source	: https://github.com/connerwill
### Description	: 
###

### Define Plugin Directory
export ZSH_PLUGINS_AVAILABLE ZSH_PLUGINS_ENABLED ZSH_PLUGINS_CONFIG_DIR
ZSH_PLUGINS_DIR="${ZSH_USER_DIR}/plugins"
ZSH_PLUGINS_AVAILABLE="${ZSH_PLUGINS_DIR}/plugins-available"
ZSH_PLUGINS_ENABLED="${ZSH_PLUGINS_DIR}/plugins-enabled"

## Load plugins
# shellcheck disable=SC1009
if [[ -d "${ZSH_PLUGINS_ENABLED}" ]]; then
  # shellcheck disable=SC1072,SC1058,SC1036,SC1073
  for ZSH_FILE in "${ZSH_PLUGINS_ENABLED}"/*.zsh(N); do
      _zshrc_VERBOSE_MESSEGE "  Plugin  " "$(basename ${ZSH_PLUGINS_ENABLED})/$(basename ${ZSH_FILE})" "201" "57"
      source "${ZSH_FILE}" \
        || _zshrc_VERBOSE_ERROR "Plugin Failed" "[${ZSH_FILE}]" "196" "190"
  done
else
  _zshrc_VERBOSE_ERROR "Directory does not exist" "[${ZSH_PLUGINS_ENABLED}]" "196" "124"
fi
