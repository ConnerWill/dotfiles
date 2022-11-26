function llll(){
    local sortbyllll="Filename"
    local depthllll="10"
    fzfcolor='hl:#00ffff,hl+:#ff00ff,fg:#505050,fg+:#00ffff,bg:#010101,bg+:#202020,query:#00ff00,info:#9090a0,spinner:#ff00ff,border:#ff00ff,preview-fg:#ffffff,preview-bg:#200050,gutter:#101010,pointer:#ff00ff,info:#020202'
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
        --no-user \
        --long \
        --no-permissions \
        --modified \
        --created \
        --header \
        --time-style=iso "$@" \
            | fzf \
                --ansi \
                --no-sort \
                --sync \
                --multi \
                --header "$headerllll" \
                --color=$fzfcolor
}
