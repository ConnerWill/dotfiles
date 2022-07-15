# git

function git_init() {

	if [ -z "$1" ]; then
		printf "%s\n" "Please provide a directory name.";
	else
		mkdir "$1";
		builtin cd "$1" \
      || echo "Failed to cd" \
      || return 1
		pwd;
		git init;
		touch README.md .gitignore LICENSE;
		echo "# $(basename "${PWD}")" >> README.md
	fi
}

function git_branch() {

	if [ -d .git ] ; then
		printf "%s" "($(git branch 2> /dev/null \
      | awk '/\*/{print $2}'))";
	fi
}


# Oneline git commit. $1 is the file, $2 is the commit message
function git-commit-push(){
	[[ ( ! -v $1 || ! -v $2 ) ]] \
    && echo -e "\n\t:Usage:\n\n\t\tgit-commit-push <FILE> <MESSAGE>" \
    && return
	git add "$1" \
    && git commit -m "$2" \
    && git push -v
}

