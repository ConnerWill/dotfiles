### realpath2cip

function realpath2clip(){


    realpath2clipHELP="Usage:\r\trealpath2clip <input>"

    local functioninput="$1"

    [[ -z "$functioninput" ]] \
        && echo -e "Input is required!" \
        && echo -e "$realpath2clipHELP" \
        && return

    realpathofinput=$(realpath "$functioninput")
    echo "$realpathofinput"
    echo "$realpathofinput" | xclip -selection clipboard

}



alias rp2clip="realpath2clip $1"
### realpath2cip

function cd2clip(){


    cd2clipHELP="Usage:\r\tcd2clip"

    local functioninput=$(xclip -out -selection clipboard)

    [[ -d "$functioninput" ]] \
        || echo -e "Path '$functioninput' not found" \
        || echo -e "$cd2clipHELP" \
        || return

    echo "Previous: $(pwd)"
    cd "$functioninput"
    echo "Moving to: $(pwd)"
}

alias cd2clip="cd2clip"



function pwd2clip(){

    pwd | xclip -selection clipboard

}
