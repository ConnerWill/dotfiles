#shellcheck disable=2148

wdotf () {
	export WDOTFILES WDOTFILES_WORKTREE WINDOWSHOME

	WINDOWSHOME="/home/conner.will" #WINDOWSHOME="${WINDOWSHOME:-/C:/Users/conner.will}"
	WDOTFILES="${WINDOWSHOME}/.dotfiles"
	WDOTFILES_WORKTREE="${WINDOWSHOME}"

	## If subcommand or switch is help, show help
	if [[ "${1}" == "help" ]] || [[ "${1}" == "-h" ]] || [[ "${1}" == "--help" ]]; then
		printf "%s help:\n\n\tFunction for managing .wdotfiles\n\n" "${0}"
		return 0

	## If subcommand is add-all, Add all changes
	elif [[ "${1}" == "add-all" ]]; then
		$(command -v git) --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" \
			diff --name-only \
			| xargs -I{} sh -c "$(command -v git) --git-dir=${WDOTFILES} --work-tree=${HOME} add -v ${HOME}/{}"

	## If subcommand is upload, commit and push
	elif [[ "${1}" == "upload" ]] || [[ "${1}" == "up" ]]; then
		$(command -v git) --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" \
			commit --status --branch --allow-empty-message --verbose -m "${2}" \
		&& $(command -v git) --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" \
      push --verbose

	## If subcommand does not match above, Run subcommand
	## If there is no subcommand, run status
	else
		[[ $# -gt 0 ]] \
			&& $(command -v git) --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" "${@}" \
			|| $(command -v git) --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" status
	fi
}

# ## If subcomamnd is status, show status
# elif [[ "${1}" == "status" ]]; then
# 	if [[ "${2}" == "-u" ]]; then
# 		$(command -v git) --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" \
# 			status -u | grep "config"
# 	else
# 		$(command -v git) --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" \
# 			status
# 	fi
#
