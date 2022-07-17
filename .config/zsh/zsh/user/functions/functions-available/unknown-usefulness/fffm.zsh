# Fucking Fast File-Manager
fffm() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")" \
        || echo "Unable to cd to dir" \
        || return 1 \
        && return 0
}


