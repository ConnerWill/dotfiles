odotf(){
	export DOTFILES DOTFILES_WORKTREE
	local dotfiles_worktree dotfiles_git_dir

	dotfiles_worktree="${HOME}"
	dotfiles_git_dir="${HOME}/.dotfiles"
	DOTFILES="${DOTFILES:-${dotfiles_git_dir}}"
	DOTFILES_WORKTREE="${DOTFILES_WORKTREE:-${dotfiles_worktree}}"

	if [[ "${1}" == "help" ]] || [[ "${1}" == "-h" ]] || [[ "${1}" == "--help" ]]; then
		printf "dotf help:\n\n\tFunction for managing .dotfiles\n\n"

	elif [[ "${1}" == "add-all" ]]; then
		$(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" diff --name-only \
			| xargs -I{} "sh -c "$(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" add --verbose "${DOTFILES_WORKTREE}" /{}""

	else
		[[ $# -gt 0 ]] \
			&& $(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" "${@}" \
			|| $(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" status
	fi
}

