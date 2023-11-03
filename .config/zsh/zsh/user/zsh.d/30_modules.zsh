#shellcheck disable=2148


autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz ztodo
autoload -Uz vcs_info


if autoload -Uz run-help; then
  (( ${+aliases[run-help]} )) && unalias run-help
  alias help=run-help

  typeset -a run_help_array=(
                              "git"
                              "ip"
                              "openssl"
                              "p4"
                              "sudo"
                              "svk"
                              "svn"
                            )
  for run_help_module in "${run_help_array[@]}"; do
    autoload -Uz "run-help-${run_help_module}" >/dev/null 2>&1 || printf "\e[0;1;38;5;196mUnable to load run-help module:\t%s\e[0m\n" "${run_help_module}"
  done

  #autoload -Uz run-help-git run-help-ip run-help-openssl run-help-p4 run-help-sudo run-help-svk run-help-svn
fi
