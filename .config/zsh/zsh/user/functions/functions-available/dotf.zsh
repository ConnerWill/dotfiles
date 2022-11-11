dotf(){
	export DOTFILES DOTFILES_WORKTREE
	local dotfiles_worktree dotfiles_git_dir

	dotfiles_worktree="${HOME}"
	dotfiles_git_dir="${HOME}/.dotfiles"
	DOTFILES="${DOTFILES:-${dotfiles_git_dir}}"
	DOTFILES_WORKTREE="${DOTFILES_WORKTREE:-${dotfiles_worktree}}"

	if [[ "${1}" == "help" ]] || [[ "${1}" == "-h" ]] || [[ "${1}" == "--help" ]]; then
		printf "dotf help:\n\n\tFunction for managing .dotfiles\n\n"

	## Add all changes
	elif [[ "${1}" == "add-all" ]]; then
		$(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" \
			diff --name-only \
			| xargs -I{} sh -c "$(command -v git) --git-dir=${DOTFILES} --work-tree=${HOME} add -v ${HOME}/{}"

	## commit and push
	elif [[ "${1}" == "upload" ]] || [[ "${1}" == "up" ]]; then
		$(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" \
			commit --verbose -m "${2}" \
		&& $(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" \
      push --verbose

	else
		[[ $# -gt 0 ]] \
			&& $(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" "${@}" \
			|| $(command -v git) --git-dir="${DOTFILES}" --work-tree="${DOTFILES_WORKTREE}" status
	fi
}

