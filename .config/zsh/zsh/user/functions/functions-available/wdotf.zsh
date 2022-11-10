wdotf () {
	export WDOTFILES WDOTFILES_WORKTREE
	local windows_dotfiles_worktree windows_dotfiles_git_dir

	windows_dotfiles_worktree="/mnt/conner_will"
	windows_dotfiles_git_dir="/mnt/conner_will/.dotfiles"
	WDOTFILES="${WDOTFILES:-${windows_dotfiles_git_dir}}"
	WDOTFILES_WORKTREE="${WDOTFILES_WORKTREE:-${windows_dotfiles_worktree}}"

	if [[ "${1}" == "help" ]] || [[ "${1}" == "-h" ]]; then
		printf "wdotf help : enter help msg here\n"
	elif [[ "${1}" == "add-all" ]]; then
		$(command -v git) --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" diff --name-only | xargs -I{} "sh -c "git --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" add --verbose "${WDOTFILES_WORKTREE}" /{}""
	else
		if [[ $# -gt 0 ]]; then
			$(command -v git) --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" "${@}"

		else
			$(command -v git) --git-dir="${WDOTFILES}" --work-tree="${WDOTFILES_WORKTREE}" status

		fi
	fi
}

