#shellcheck disable=2148

dotf(){
	export DOTFILES DOTFILES_WORKTREE
	local dotf_cmd printstring flag_verbose fill
  declare -A colors

	## Define GLOBAL variables
	DOTFILES="${DOTFILES:-${HOME}/.dotfiles}"
	DOTFILES_WORKTREE="${DOTFILES_WORKTREE:-${HOME}}"

	## Define local varuables
	dotf_cmd="$(command -v git) --git-dir=${DOTFILES} --work-tree=${DOTFILES_WORKTREE}"

  # printstring=()
  # flag_verbose=false
  # fill=myfile

  colors[ColorOff]='\e[0m'
  colors[bold]='\e[1m'
  colors[italic]='\e[3m'
  colors[underline]='\e[4m'
  colors[Black]='\e[30m'
  colors[Gray]='\e[38;5;7m'
  colors[DarkGray]='\e[38;5;8m'
  colors[White]='\e[37m'
  colors[Red]='\e[38;5;196m'
  colors[Green]='\e[38;5;46m'
  colors[Yellow]='\e[38;5;190m'
  colors[Blue]='\e[38;5;33m'
  colors[Purple]='\e[38;5;93m'
  colors[Magenta]='\e[38;5;201m'
  colors[Cyan]='\e[38;5;87m'
  colors[reset]='\e[0m'

  ###{{{ commented out
  # local usage=(
  #   "${colors[bold]}${colors[underline]}${colors[Green]}${0}${colors[reset]}:" #;38;5;15m\"<phrase to center>\" \"<1 char to fill empty space>\" \e[38;5;240m[<number of columns>] [<1 char to surround the whole result>\e[0m\n" >&2 \
  #   " "
  #   " ${colors[bold]}USAGE${colors[reset]}:"
  #   " "
  #   "   ${0} ${colors[italic]}${colors[Gray]}[-h|--help]${colors[reset]}"
  #   "   ${0} ${colors[italic]}${colors[Gray]}[-f|--fill=<string>] [-s|--surround=<string>] ${colors[bold]}[<string>]${colors[reset]}"
  #   "  "
  #   " "
  #   " ${colors[bold]}OPTIONS${colors[reset]}:"
  #   " "
  #   "   [-h|--help]              Show this help"
  #   "   [-f|--fill=<string>]     Character to fill empty space (single character)"
  #   "   [-s|--surround=<string>] Character to surround the whole result with (single character)"
  #   " "
  #   " "
  #   " ${colors[bold]}EXAMPLES${colors[reset]}:"
  #   " "
  #   "   $ ${0} ${colors[italic]}${colors[Gray]}--fill='═' --surround='╪' ' HOWDY '${colors[reset]}"
  # )
  #
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

local usage_full=(
    "${colors[Magenta]}================================================================================${colors[reset]}\n"
    " ${colors[Blue]}NAME${colors[reset]}                                             \n"
    "                                                                                \n"
    "     ${colors[Cyan]}$0${colors[reset]}                                        \n"
    "                                                                                \n"
    " ${colors[Blue]}DESCRIPTION${colors[reset]}                                      \n"
    "                                                                                \n"
    " 		Shell/Bash/Zsh Function for managing .dotfiles                             \n"
    "                                                                                \n"
    "                                                                                \n"
    " ${colors[Blue]}USAGE${colors[reset]}                                            \n"
    "                                                                                \n"
    "     ${colors[Cyan]}$0${colors[reset]} [[-Aahpu]][[-h][-a files...][-A][-p][-u[=][message]]][-- [git commands] \n"
    "                                                                                \n"
    "                                                                                \n"
    " ${colors[Blue]}SUBCOMMANDS${colors[reset]}                                      \n"
    "                                                                                \n"
    " 		[[[-]h][[--]help]]                              : Show this help message   \n"
    " 		[[[-]a[=]<files>][[--]add[=]<files>]]           : Add specific files       \n"
    " 		[[[-]A][[--]all][add-all]]                      : Add all modified files   \n"
    " 		[[[-]u[=][message]][[--]up[load][=][message]]]  : Commit and push changes  \n"
    "                                                                                \n"
    "                                                                                \n"
    " ${colors[Blue]}EXAMPLE${colors[reset]}                                          \n"
    "                                                                                \n"
    " 		\$  ${colors[Cyan]}$0${colors[reset]}                                    \n"
    "                                                                                \n"
    " 	Runnind '${colors[Cyan]}$0${colors[reset]}' with no subcommands or argumentns will show the current status. \n"
    " 	(Equivalent to running: '${colors[Cyan]}$0${colors[reset]} status')        \n"
    "                                                                                \n"
    "                                                                                \n"
    " ${colors[Blue]}EXAMPLE${colors[reset]}                                          \n"
    "                                                                                \n"
    "                                                                                \n"
    " 		\$  ${colors[Cyan]}$0${colors[reset]} add-all                            \n"
    "                                                                                \n"
    " 	This command will 'git add' all modified files.                              \n"
    " 	It will not add new files that are not being tracked.                        \n"
    "                                                                                \n"
    "                                                                                \n"
    " ${colors[Blue]}EXAMPLE${colors[reset]}                                          \n"
    "                                                                                \n"
    " 		\$  ${colors[Cyan]}$0${colors[reset]} upload 'Added help menu to function\n"
    "                                                      # or                      \n"
    " 		\$  ${colors[Cyan]}$0${colors[reset]} --upload='Added help menu to functinon'\n"
    "                                                                                \n"
    " 	These two command will do the exact same thing.                              \n"
    " 	Just wanted to show you how the subcommands can be used.                     \n"
    "                                                                                \n"
    " 	This will commit and push changes to the remote                              \n"
    " 	repository with a commit message of 'Added help menu to function'            \n"
    "                                                                                \n"
    "                                                                                \n"
    " ${colors[Blue]}EXAMPLE${colors[reset]}                                          \n"
    "                                                                                \n"
    " 		\$  ${colors[Cyan]}$0${colors[reset]} a && ${colors[Cyan]}$0${colors[reset]} u 'Expanded help menu'     \n"
    "                                                                                \n"
    " 	This command is a shorthand way of adding all modified files,                \n"
    " 	commiting with the commit message of 'Expanded help menu',                   \n"
    "   and then pushing to the remote.                                              \n"
    "                                                                                \n"
    "                                                                                \n"
    "${colors[Magenta]}================================================================================${colors[reset]}\n"
  )
	## If subcommand or switch is help, show help
	if [[ "${1}" == "help" ]] || [[ "${1}" == "-h" ]] || [[ "${1}" == "--help" ]]; then print -f%b "%s\n" $usage_full && return 1;

	## If subcommand is add-all, Add all changes
	elif [[ "${1}" == "add-all" ]]; then
 		$(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" \
			diff --name-only \
			| xargs -I{} sh -c "$(command -v git) --git-dir=${DOTFILES} --work-tree=${HOME} add -v ${HOME}/{}"

	## If subcommand is upload, commit and push
	elif [[ "${1}" == "upload" ]] || [[ "${1}" == "up" ]]; then
		$(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" \
			commit --status --branch --allow-empty-message --verbose -m "${2}" \
		&& $(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" \
      push --verbose

	## If subcommand does not match above, Run subcommand. If there is no subcommand, run status
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
