#############################
#----------- MAN -----------#
#############################

function manfzf(){
    script=$(basename "$0")
    help="$script [-h/--help] -- script to search and open man pages
      Usage:
        $script

      Examples:
        $script"

    [ -n "$1" ] \
        && printf "%s\n" "$help" \
        && exit 0

    select=$(apropos -l '' \
        | cut -d ' ' -f1,2 \
        | sort \
        | fzf -m -e -i --preview "man {1}{2}" \
            --preview-window "right:70%" \
            --bind 'change:first+preview:man {1}{2}' \
            --bind 'ctrl-v:toggle-preview' \
            --bind 'ctrl-/:change-preview-window(up,border-horizontal|up,40%,border-horizontal|left|left,border-left,40%|down|down,40%,border-horizontal|down,10%,border-horizontal|hidden|right,40%|right,70%|right,90%)' \
            --bind 'pgdn:preview-page-down' \
            --bind 'pgup:preview-page-up' \
            --bind 'shift-up:preview-top' \
            --bind 'shift-down:preview-bottom' \
            --bind 'home:last' \
            --bind 'end:first' \
            --bind 'ctrl-y:yank' \
            --bind 'esc:close' \
            --bind 'backward-eof:change-preview-window(hidden)' \
            --bind 'ctrl-l:clear-query' \
            --bind 'enter:accept' \
            --bind 'tab:select' \
            --bind 'ctrl-space:select' \
            --bind 'ctrl-a:select-all' \
            --bind 'ctrl-d:deselect-all' \
            --bind '?:preview: echo $help | cat' \
            --bind 'ctrl-h:preview: echo $help | cat' \
            --info=inline \
            --prompt="> " \
            --pointer="[>" \
            --marker="[]" \
            --header="HELLO" \
            --header-lines=5 \
            --scroll-off=25 \
            --header-first \
            --hscroll-off=100 \
            --ansi \
            --margin 1% \
            --padding 1% \
            --border \
        | tr -d ' ')

    [ -n "$select" ] \
        && man "$select"
}




