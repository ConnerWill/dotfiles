function ZSHPLUGINMOVE(){

    CURRENTPLUGIN="$1"
    [[ -z "$CURRNTPWD" ]] \
# && return 2

    [[ -z "$CURRENTPLUGIN" ]] \
# && return 2

    cd "$CURRENTPLUGIN" \
        || return 1

    CURRNTPWD=$(pwd)
    MOVEPLUGIN "$CURRENTPLUGIN" \
        || return 1
}


function MKDEST(){

    [[ -z "$DESTDIR" ]] \
# && DESTDIR="/home/dampsock/server/skell-lite/in-use-zsh-plugins"

    [[ -z "$DESTDIR" ]] \
# && return 5

    mkdir -v -p "$DESTDIR" \
        || return 1
}

function MOVEPLUGIN(){

    CURRNTPWD="$1"
    [[ -z "$CURRNTPWD" ]] \
    # && return 2

    [[ -d "$DESTDIR" ]] \
        || MKDEST \
            || return 1

    cp -r -v "$CURRNTPWD" -t "$DESTDIR/" \
        || return 1
}

function RESETVAR(){

    echo -e "\n\tUnsetting Vars\n"
    CURRNTPWD=""
    CURRENTPLUGIN=""
    unset CURRNTPWD
    unset CURRENTPLUGIN

    [[ -n "$CURRNTPWD" ]] \
# && unset CURRENTPWD=""

    [[ -n "$CURRNTPLUGIN" ]] \
# && unset CURRNTPLUGIN

}

export ZSH_SKEL_TEMP_PLUGINS="/home/dampsock/server/skell-lite/.config/zsh/plugins/plugin-store"


STARTINGGDIR=$(pwd)

DESTDIR="/home/dampsock/server/skell-lite/in-use-zsh-plugins"



ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/zsh-colored-man-pages"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/zsh-autosuggestions"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/autoenv"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/git-plugins/forgit"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/undollar"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/copier"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/expand-ealias.plugin.zsh"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/tmux-plugins/tsm"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/k"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/zsh-autoswitch-virtualenv"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/z.lua"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/zsh-autopair"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/history-search-multi-word"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/zsh-change-case"
ZSHPLUGINMOVE "$ZDOTDIR/plugins/plugin-store/symmetric-ctrl-z"


echo -e "\n\n\t\tDONE\n\n"
cd "$STARTINGGDIR"
