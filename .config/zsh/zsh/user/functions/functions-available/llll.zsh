function llll(){
    local sortbyllll="Filename"
    local depthllll="5"
    local headerllll="\
    [Sorted: $sortbyllll]\n\
    [Depth: $depthllll]"

    exa \
        --color always \
        --tree \
        --recurse \
        --level="$depthllll" \
        --sort="$sortbyllll" \
        --reverse \
        --all \
        --git \
        --no-user \
        --long \
        --no-permissions \
        --modified \
        --created \
        --header \
        --time-style=iso "$@" \
            | fzf \
                --ansi \
                --header "$headerllll" \
                --no-sort
}
