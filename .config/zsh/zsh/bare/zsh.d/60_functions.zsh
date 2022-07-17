
###
### Title	      60_functions.zsh
### Author	    : ConnerWill
### Source	    : https://github.com/connerwill
### Description	: 
###

### Define Functions Directory
export ZSH_FUNCTIONS_AVAILABLE ZSH_FUNCTIONS_ENABLED ZSH_FUNCTIONS_CONFIG_DIR
ZSH_FUNCTIONS_DIR="${ZSH_USER_DIR}/functions"
ZSH_FUNCTIONS_AVAILABLE="${ZSH_FUNCTIONS_DIR}/functions-available"
ZSH_FUNCTIONS_ENABLED="${ZSH_FUNCTIONS_DIR}/functions-enabled"

## Load functions
# shellcheck disable=SC1009
if [[ -d "${ZSH_FUNCTIONS_ENABLED}" ]]; then
  # shellcheck disable=SC1072,SC1058,SC1036,SC1073
  for ZSH_FILE in "${ZSH_FUNCTIONS_ENABLED}"/*.zsh(N); do
      _zshrc_VERBOSE_MESSEGE "  Function" "$(basename ${ZSH_FUNCTIONS_ENABLED})/$(basename ${ZSH_FILE})" "93" "46"
      source "${ZSH_FILE}" \
        || _zshrc_VERBOSE_ERROR "Function Failed To Load" "[${ZSH_FILE}]" "196" "190"
    done
  else
    _zshrc_VERBOSE_ERROR "Directory does not exist" "[${ZSH_FUNCTIONS_ENABLED}]" "196" "124"
fi
