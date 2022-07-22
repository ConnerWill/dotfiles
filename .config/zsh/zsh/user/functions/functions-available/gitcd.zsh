## Clone Repo and cd to it
function gitcd () {
    if (( ARGC != 1 )); then
        printf 'usage: gitcd <repository-url>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command git clone "$1"
    else
        printf '`%s'\'' already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1" \
      || echo "Failed to cd" \
      || return 1
}


