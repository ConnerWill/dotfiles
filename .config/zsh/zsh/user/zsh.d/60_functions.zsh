## ShellCheck Setup{{{
#shellcheck disable=1009,1072,1058,1036,1073,2148
#shellcheck disable=SC2236
#shellcheck enable=quote-safe-variables
#shellcheck enable=check-unassigned-uppercase
#shellcheck enable=require-variable-braces
#shellcheck source-path=SCRIPTDIR
#shellcheck source-path=/etc/zsh/zshenv
#shellcheck source-path=/etc/zsh/zprofile
#shellcheck source=./.zshenv
#shellcheck source=./.zprofile
#shellcheck source=./.zlogin
#shellcheck source=./banner/zshbanner.zsh
#shellcheck source=./variables/zshvariables.zsh
#shellcheck source=./options/zshoptions.zsh
#shellcheck source=./aliases/zshalias.zsh
#shellcheck source=./history/zshhistory.zsh
#shellcheck source=./keybindings/zshkeybindings.zsh
#shellcheck source=./functions/zshfunctions.zsh
#shellcheck source=./themes-prompts/zshpromptsthemes.zsh
#shellcheck source=./modules/zshmodules.zsh
#shellcheck source=./functions/zshfunctions.zsh
#shellcheck source=./completions/zshcompletions.zsh
##}}}
### [=============================]
### [------- ZSH FUNCTIONS -------]
### [=============================]
      ZSH_FUNCTIONS_DIR="${ZSH_USER_DIR}/functions"
ZSH_FUNCTIONS_AVAILABLE="${ZSH_FUNCTIONS_DIR}/functions-available"
  ZSH_FUNCTIONS_ENABLED="${ZSH_FUNCTIONS_DIR}/functions-enabled"
export ZSH_FUNCTIONS_AVAILABLE ZSH_FUNCTIONS_ENABLED ZSH_FUNCTIONS_CONFIG_DIR

## Load functions
if [[ -d "${ZSH_FUNCTIONS_ENABLED}" ]]; then
  for ZSH_FILE in "${ZSH_FUNCTIONS_ENABLED}"/*.zsh(N); do
    source "${ZSH_FILE}" || _zshrc_VERBOSE_ERROR "Failed to source function file: ${ZSH_FILE}"
  done
else
  _zshrc_VERBOSE_ERROR "Function directory does not exist: ${ZSH_FUNCTIONS_ENABLED}"
fi
