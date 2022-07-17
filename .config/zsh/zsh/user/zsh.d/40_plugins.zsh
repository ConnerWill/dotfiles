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
### [=============================]--------------------------]
### [ Example:                                               ]
### [  $ source "$ZSH_CUSTOM_PLUGINS/path-to/zsh-plugin.zsh" ]
### [=============================]--------------------------]

### Define Plugin Directory
export ZSH_PLUGINS_AVAILABLE ZSH_PLUGINS_ENABLED ZSH_PLUGINS_CONFIG_DIR
ZSH_PLUGINS_DIR="${ZSH_USER_DIR}/plugins"
ZSH_PLUGINS_AVAILABLE="${ZSH_PLUGINS_DIR}/plugins-available"
ZSH_PLUGINS_ENABLED="${ZSH_PLUGINS_DIR}/plugins-enabled"

function _zsh_plugins_clone_personal_plugins(){
  declare -a my_repo_list 
  local ZSH_PLUGINS_AVAILABLE \
        ZSH_PLUGINS_ENABLED   \
        repo_full_url         \
        repo_host_url         \
        repo_host_username    \
        repo_host_user_url  

  ZSH_PLUGINS_DIR="${ZSH_USER_DIR}/plugins"
  ZSH_PLUGINS_AVAILABLE="${ZSH_PLUGINS_DIR}/plugins-available"
  ZSH_PLUGINS_ENABLED="${ZSH_PLUGINS_DIR}/plugins-enabled"
  repo_host_url="https://github.com"
  repo_host_username="ConnerWill"
  repo_host_user_url="${repo_host_url}/${repo_host_username}"
  my_repo_list=(
                "cheat-fzf"
                "yayfzf"
               ) 
  declare -r my_repo_list
  for repo_to_clone in $my_repo_list
  do
    repo_full_url="${repo_host_user_url}/${repo_to_clone}"
    repo_full_dl_path="${ZSH_PLUGINS_AVAILABLE}/${repo_to_clone}"
    git clone                     \
      --verbose                   \
      "${repo_full_url}"          \
      "${repo_full_dl_path}"
  done
  ln -sr "${ZSH_PLUGINS_AVAILABLE}/yayfzf/bin/yayfzf" "${ZSH_PLUGINS_ENABLED}/yayfzf.zsh"
  ln -sr "${ZSH_PLUGINS_AVAILABLE}/cheat-fzf/src/cht-fzf.sh" "${ZSH_PLUGINS_ENABLED}/chtfzf.zsh"
}
if [[ -d "${ZSH_PLUGINS_AVAILABLE}/cheat-fzf" ]] && [[ -d "${ZSH_PLUGINS_AVAILABLE}/yayfzf" ]]; then
  echo -n ""
else
  _zsh_plugins_clone_personal_plugins
fi

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

source "${ZSH_PLUGINS_AVAILABLE}/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${ZSH_PLUGINS_AVAILABLE}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

