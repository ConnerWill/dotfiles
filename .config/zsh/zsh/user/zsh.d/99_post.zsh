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
ZSH_PLUGINS_ENABLED="${ZSH_PLUGINS_DIR}/plugins-enabled"

# Remove bindings to ctrl+r
bindkey -r '^r'

zsh_fzf_history_search="${ZSH_PLUGINS_ENABLED}/zsh-fzf-history-search.plugin.zsh"
[[ -e "${zsh_fzf_history_search}" ]] && source "${zsh_fzf_history_search}"
unset zsh_fzf_history_search
