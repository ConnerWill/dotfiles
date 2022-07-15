## Create Directory and cd to it
function mkcd () {
    if (( ARGC != 1 )); then
        printf 'usage: \n\n\tmkcd <new-directory>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf '`%s'\'' already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1" \
			|| echo "Cannot cd to dir" \
			|| return 1
}

