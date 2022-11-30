#shellcheck disable=2148

dotf(){
  DOTFCMD="dotf"
  DOTFVERSION="0.1.1"
  export DOTFILES DOTFILES_WORKTREE DOTFCMD
	local dotf_cmd printstring flag_verbose fill

	## Define GLOBAL variables
	DOTFILES="${DOTFILES:-${HOME}/.dotfiles}"
	DOTFILES_WORKTREE="${DOTFILES_WORKTREE:-${HOME}}"

	## Define local varuables
	dotf_cmd="$(command -v git) --git-dir=${DOTFILES} --work-tree=${DOTFILES_WORKTREE}"

  # printstring=()
  # flag_verbose=false
  # fill=myfile

## Check if 'NO_COLOR' environment variable is defined
## if 'NO_COLOR' is defined, do not define color array
NO_COLOR=${NO_COLOR:-""}
if [[ -n ${NO_COLOR} ]]; then
  declare -A colors
  colors[ColorOff]='\e[0m'
  colors[bold]=''
  colors[italic]=''
  colors[underline]=''
  colors[Black]=''
  colors[Gray]=''
  colors[DarkGray]=''
  colors[White]=''
  colors[Red]=''
  colors[Green]=''
  colors[Yellow]=''
  colors[Blue]=''
  colors[Purple]=''
  colors[Magenta]=''
  colors[Cyan]=''
  colors[reset]='\e[0m'
else
  declare -A colors
  colors[ColorOff]='\e[0m'
  colors[bold]='\e[1m'
  colors[italic]='\e[3m'
  colors[underline]='\e[4m'
  colors[Black]='\e[30m'
  colors[Gray]='\e[38;5;245m'
  colors[DarkGray]='\e[38;5;8m'
  colors[White]='\e[38;5;15m'
  colors[Red]='\e[38;5;196m'
  colors[Green]='\e[38;5;46m'
  colors[Yellow]='\e[38;5;190m'
  colors[Blue]='\e[38;5;33m'
  colors[Purple]='\e[38;5;93m'
  colors[Magenta]='\e[38;5;201m'
  colors[Cyan]='\e[38;5;87m'
  colors[reset]='\e[0m'
fi


  ###{{{ commented out
  # opterr() { printf >&2 "%s:${colors[reset]}${colors[Blue]}%s ${colors[yellow]}%s${colors[reset]}" "${1}" "${2}" "${3}"; printf "%s\n" $usage && return 1; }
  #
  # while (( $# )); do
  #   case $1 in
  #     --)                 shift; printstring+=("${@[@]}"); break ;;
  #     -h|--help|h|help)          printf "%s\n" $usage && return         ;;
  #     -A|--all|A|all|add-all)          shift; fill=${1}                         ;;
  #     -u|--up|u|up|upload)          shift; fill=${1}                         ;;
  #     -u=*|--up=*|--upload=*)      fill="${1#*=}"                         ;;
  #     -a|a|--add|add)      shift; surround=${1}                     ;;
  #     -a=*|--add=*)      fill="${1#*=}"                         ;;
  #     -*)                 opterr "${0}" "Unknowm option:" ${1} && printf "%s\n" $usage && return 2                  ;;
  #     *)                  printstring+=("${@[@]}"); break        ;;
  #   esac
  #   shift
  # done
  #
  ###}}} commented out

 function _dotf_version(){
    printf "%s %s\n" "${DOTFCMD}" "${DOTFVERSION}"
 }

function _dotf_help_name(){
  printf "$(cat <<HELPMENUNAME

${colors[bold]}${colors[Blue]}NAME${colors[reset]}

  ${colors[Green]}${DOTFCMD}${colors[reset]}


HELPMENUNAME
)\n\n"
}

function _dotf_help(){
  printf "$(cat <<HELPMENU

${colors[bold]}${colors[Blue]}DESCRIPTION${colors[reset]}

  ${colors[White]}Manage, backup, develop, sync your .dotfiles with ease${colors[reset]}


${colors[bold]}${colors[Blue]}USAGE${colors[reset]}

  ${colors[Green]}${DOTFCMD}${colors[reset]} [-AapufhV] [-a|a|--add|add <files>] [-A|A|--all|all|add-all]
       [-u|u|--up|up|--upload|upload [message]] [--fzf|fzf]
       [-h|h] [--help|help] [-V|--version] [-- <git command>]

  ${colors[Green]}${DOTFCMD}${colors[reset]} [-AapufhV]

  ${colors[Green]}${DOTFCMD}${colors[reset]} [options] [-- <git command|git options>]

  ${colors[Green]}${DOTFCMD}${colors[reset]} [git subcommand]


${colors[bold]}${colors[Blue]}OPTIONS${colors[reset]}

    -a, --add, a, add <files>
          Add files to be tracked ${colors[italic]}(git add)${colors[reset]}

    -A, A, --all, add-all
          Add all tracked files that have been modified

    -u, u, --up, --upload [message]
          Commit and push changes, including an option commit message

    --fzf, fzf
          Run interactive dotf interface to manage repository with fzf

    -- <git command|git options>
          Run git commands


${colors[bold]}${colors[Blue]}META OPTIONS${colors[reset]}

    -h, h
        Show the help menu

    --help, help
        Show the full ${DOTFCMD} help menu

    --usage, usage
        Show ${DOTFCMD} usage

    --examples, examples
        Show ${DOTFCMD} examples

    -V, --version
        Show ${DOTFCMD} version

HELPMENU
)\n\n"
}

function _dotf_help_aliases(){
  printf "$(cat <<HELPMENUALIASES

${colors[bold]}${colors[Blue]}ALIASES${colors[reset]}

  To add convenience when working with ${colors[Green]}${DOTFCMD}${colors[reset]},
  several aliases exist that are assigned to specific ${colors[Green]}${DOTFCMD}${colors[reset]} commands.

  Here are the aliases that are currently defined:

    ${colors[Cyan]}d${colors[reset]}         ${colors[DarkGray]}:${colors[reset]} alias for '${colors[Green]}${DOTFCMD}${colors[reset]}'
    ${colors[Cyan]}dotfa${colors[reset]}     ${colors[DarkGray]}:${colors[reset]} alias for '${colors[Green]}${DOTFCMD}${colors[reset]} add'
    ${colors[Cyan]}dotfc${colors[reset]}     ${colors[DarkGray]}:${colors[reset]} alias for '${colors[Green]}${DOTFCMD}${colors[reset]} commit'
    ${colors[Cyan]}dotfp${colors[reset]}     ${colors[DarkGray]}:${colors[reset]} alias for '${colors[Green]}${DOTFCMD}${colors[reset]} pull'
    ${colors[Cyan]}dotfallup${colors[reset]} ${colors[DarkGray]}:${colors[reset]} alias for '${colors[Green]}${DOTFCMD}${colors[reset]} add-all && ${colors[Green]}${DOTFCMD}${colors[reset]} up'


HELPMENUALIASES
)\n\n"
}


function _dotf_help_examples(){
  printf "$(cat <<HELPMENUEXAMPLES

${colors[bold]}${colors[Blue]}EXAMPLES${colors[reset]}

  Running '${colors[Green]}${DOTFCMD}${colors[reset]}' with no subcommands, options, or arguments
  will show the current status of the repository:
     ${colors[italic]}(Equivalent to running: '${colors[Green]}${DOTFCMD}${colors[reset]} status${colors[italic]}')${colors[reset]}

    ${colors[DarkGray]}\$${colors[reset]}  ${colors[Green]}${DOTFCMD}${colors[reset]}


  Adding all modified files currently checked into dotf.
  It will not add new files that are not being tracked.

    ${colors[DarkGray]}\$${colors[reset]}  ${colors[Green]}${DOTFCMD}${colors[reset]} add-all


  These next two command will do the exact same thing.
  Showing you how the subcommands/options can be used.

  These examples will commit and push changes to the remote repository
  with a commit message of 'Added help menu to function'

    ${colors[DarkGray]}\$${colors[reset]}  ${colors[Green]}${DOTFCMD}${colors[reset]} upload 'Added help menu to function'

    ${colors[DarkGray]}\$${colors[reset]}  ${colors[Green]}${DOTFCMD}${colors[reset]} --upload='Added help menutofunctinon'


  This little command is a shorthand way of running multiple commands
  to add all modified files that are checked into ${DOTFCMD}, commit changes
  with a commit message of 'Expanded help menu', and then pushing to the remote.

    ${colors[DarkGray]}\$${colors[reset]}  ${colors[Green]}${DOTFCMD}${colors[reset]} a && ${colors[Green]}${DOTFCMD}${colors[reset]} 'Expanded help menu'


HELPMENUEXAMPLES
)\n\n"
}

function _dotf_help_more_info(){
  printf "$(cat <<HELPMENUMOREINFO

${colors[bold]}${colors[Blue]}MORE${colors[reset]}

  For more information, view the README on the ${DOTFCMD} repository
  https://github.com/connerwill/${DOTFCMD}
HELPMENUMOREINFO
)\n\n"
}

function _dotf_help_full(){
  _dotf_help_name
  _dotf_help
  _dotf_help_aliases
  _dotf_help_examples
  _dotf_help_more_info
}

  ## Full help
	if [[ "${1}" == "--help" ]] || [[ "${1}" == "help" ]]; then
    # print -f%b "%s\n" $usage_full && return 1;
    _dotf_help_full
    return

  ## Short help
	elif [[ "${1}" == "-h" ]] || [[ "${1}" == "h" ]];then
    #print -f%b "%s\n" $usage_full && return 1;
    _dotf_help_name
    _dotf_help
    printf "\nrun '%s --help' to see the full help menu\n" "${DOTFCMD}"
    return

  ## Usage
  elif [[ "${1}" == "--usage" ]] || [[ "${1}" == "usage" ]];then
    _dotf_help_name
    _dotf_help
    printf "\nrun '%s --help' to see the full help menu\n" "${DOTFCMD}"
    return

  ## Examples
  elif [[ "${1}" == "--examples" ]] || [[ "${1}" == "examples" ]];then
    _dotf_help_name
    _dotf_help_examples
    _dotf_help_more_info
    printf "\nrun '%s --help' to see the full help menu\n" "${DOTFCMD}"
    return

  ## Examples
  elif [[ "${1}" == "-V" ]] || [[ "${1}" == "--version" ]];then
    _dotf_version
    return

  ## Add all changes
	elif [[ "${1}" == "add-all" ]] || [[ "${1}" == "all" ]] || [[ "${1}" == "--all" ]] || [[ "${1}" == "A" ]] || [[ "${1}" == "-A" ]]; then; then
 		$(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" \
			diff --name-only \
			| xargs -I{} sh -c "$(command -v git) --git-dir=${DOTFILES} --work-tree=${HOME} add -v ${HOME}/{}"

	## commit and push
	elif [[ "${1}" == "upload" ]] || [[ "${1}" == "up" ]] || [[ "${1}" == "--up" ]] || [[ "${1}" == "--upload" ]] || [[ "${1}" == "-u" ]] || [[ "${1}" == "u" ]]; then
		$(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" \
			commit --status --branch --allow-empty-message --verbose -m "${2}" \
		&& $(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" \
      push --verbose

	## open fzf
	elif [[ "${1}" == "--fzf" ]] || [[ "${1}" == "fzf" ]]; then
    _dotf-fzf-status

	## If args do not match above, Run subcommand. If there is no subcommand, run status
	else
		#shellcheck disable=2015
		[[ $# -gt 0 ]] \
			&& $(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" "${@}" \
			|| $(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" status
	fi
}


#################### DOTFZF ################################
# Enhanced Git Status (Open multiple files with tab + diff preview)
function _dotf-fzf-status(){
  tput smcup
  clear
    local selected
    git --git-dir=$DOTFILES --work-tree=$HOME rev-parse --git-dir > /dev/null 2>&1 \
      || printf "\e[0;1;38;5;190;48;5;196m\t\t\t\tΣΣΣΣΣΣΣΣΣΣΣΣ\nᵈªʳⁿ\t\t\t\t\n\t\t WTF ?!?!?!\t\n\n\e[0m\n\n\e[0;1;38;5;201m\t\t You aint in no git repo\e[0m\n\e[0;1;3;4;38;5;87;48;5;201m\n\n\t\t Cant do shit ...\t\t\n\t\t\n\n\n\e[0m\n" \
      || return 1
    selected=$( \
      git --git-dir=$DOTFILES --work-tree=$HOME -c color.status=always status --short \
        | fzf                                                                                                                                                       \
            --border                                                                                                                                                \
            -m                                                                                                                                                      \
            --ansi                                                                                                                                                  \
            --reverse                                                                                                                                               \
            --inline-info                                                                                                                                           \
            --preview-window='down,80%'                                                                                                                             \
            --header-first                                                                                                                                          \
            --color='fg:#00FFFF,bg:#101010,hl:#4909bb,hl+:#ff00ff,preview-fg:#ffffff,preview-bg:#020202,gutter:#000000,header:#666666,border:#900aff'               \
            --header="$(git --git-dir=$DOTFILES --work-tree=$HOME remote get-url --all origin)"                                                                     \
            --nth 2..,..                                                                                                                                            \
            --preview "(git --git-dir=$DOTFILES --work-tree=$HOME diff --color=always --text -- {-1} | sed 1,4d; cat {-1}) | head -500"                             \
            --bind 'ctrl-/:toggle-preview'                                                                                                                          \
            --bind 'pgdn:preview-page-down'                                                                                                                         \
            --bind 'pgup:preview-page-up'                                                                                                                           \
            --bind 'j:down'                                                                                                                                         \
            --bind 'k:up'                                                                                                                                           \
            --bind "J:preview-down"                                                                                                                                 \
            --bind "K:preview-up"                                                                                                                                   \
            --bind 'home:last'                                                                                                                                      \
            --bind 'end:first'                                                                                                                                      \
            --bind "ctrl-p:execute(${PAGER} {})"                                                                                                                    \
            --bind "ctrl-e:execute(${EDITOR} {})"                                                                                                                   \
            --bind "enter:execute(git --git-dir=$DOTFILES --work-tree=$HOME diff --color=always --text -- {-1} | sed 1,4d; cat {-1} | less --RAW-CONTROL-CHARS)"    \
            --bind "ctrl-a:execute(git --git-dir=$DOTFILES --work-tree=$HOME add -v {})"                                                                            \
            --bind "ctrl-r:execute(git --git-dir=$DOTFILES --work-tree=$HOME rm --cached {})" \
            --bind "ctrl-e:execute(${EDITOR} {1})" \
        | cut -c4- \
          | sed 's/.* -> //' \
    )
    if [[ $selected ]]; then
      for prog in ${selected};
      do
        "${EDITOR}" "${prog}"
      done
    fi
  # tput rmcup
}

# Checkout to existing branch or else create new branch. gco <branch-name>.
# Falls back to fuzzy branch selector list powered by fzf if no args.
function _dotf-fzf-checkout(){
    if git --git-dir=$DOTFILES --work-tree=$HOME rev-parse --git-dir > /dev/null 2>&1; then
        if [[ "$#" -eq 0 ]]; then
            local branches branch
            branches=$(git --git-dir=$DOTFILES --work-tree=$HOME branch -a) &&
            branch=$(echo "$branches" |
            fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m -- --reverse --color='fg:#00FFFF,fg+:#ff0000,bg:#202020v,hl:#eeff00,hl+:#ff00ff' --header="$(git --git-dir=$DOTFILES --work-tree=$HOME remote get-url --all origin)" ) &&
            git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
     elif git --git-dir=$DOTFILES --work-tree=$HOME rev-parse --verify --quiet "$@" || git --git-dir=$DOTFILES --work-tree=$HOME branch --remotes | grep  --extended-regexp "^[[:space:]]+origin/${*}" ]; then
            echo "Checking out to existing branch"
            git --git-dir=$DOTFILES --work-tree=$HOME checkout "$*"
        else
            echo "Creating new branch"
            git --git-dir=$DOTFILES --work-tree=$HOME checkout -b "$*"
        fi
    else
      printf "\e[0;1;38;5;190;48;5;196m\t\t\t\tΣΣΣΣΣΣΣΣΣΣΣΣ\nᵈªʳⁿ\t\t\t\t\n\t\t WTF ?!?!?!\t\n\n\e[0m\n\n\e[0;1;38;5;201m\t\t You aint in no git repo\e[0m\n\e[0;1;3;4;38;5;87;48;5;201m\n\n\t\t Cant do shit ...\t\t\n\t\t\n\n\n\e[0m\n"
      printf "\e[0;1;38;5;87;48;5;46m\t \t\t \t\t \t\t \t\t \t\t \t\t \t\t \t         ⇙⇐⇖⇑⇗⇒⇘⇓\t \t\t \t\t \t\t \t\t \t\t \t       \e[0m\e[0;1;38;5;8m\t \t\t \t\t \t\t \t\t \t\t \t\t \t\t \t\t \t         bye\e[0m\e[0;1;3;4;38;5;249;48;5;8m∞πΣ±_‹[]\e[0m"
      return 1
    fi
}

alias dotfzf="_dotf-fzf-status"
alias dotf-fzf="_dotf-fzf-status"
alias dotf-fzf-checkout="_dotf-fzf-checkout"
alias d='printf "\x1B[0;1;38;5;93m[DOTF]\x1B[0m:\x1B[0;38;5;87m\tDOTFILES MANAGER\x1B[0m\t\x1B[0;38;5;8m%s\x1B[0m\n" "$(date +%Y-%m-%d_%H:%M:%S)"; dotf'
alias dotfallup="dotf add-all && dotf up"
alias dotfc='printf "\x1B[0;1;48;5;46;38;5;15m[COMMIT]\x1B[0;38;5;46m\tcommiting changes...\n"; dotf commit --status --verbose -m'
alias dotfa='printf "\x1B[0;1;48;5;46;38;5;15m[ADD]\x1B[0;38;5;46m\tadding files...\n"; dotf add --verbose'
alias dotfp='dotf pull --all --progress --verbose --stat --dry-run || printf "\x1B[0;1;4;48;5;196;38;5;15m[FAILED]\x1B[0;38;5;196m\tdry-run pull failed!\n" && dotf pull --all --progress --verbose --stat'
