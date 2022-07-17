### Kitty Terminal Image Viewer
    #    kitty icat <Image|URL|Directory>
function vcat(){
    local UserInput="$1"
    [[ -z $(whereis kitty) ]] && echo -e "\e[38;5;9mMake sure kitty is installed :):):):)\e[0m" && return 1
    if [[ -z "$UserInput" ]];then
        UserInput="$(pwd)"
        echo -e "\e[38;5;196mNo input received,\n\n\e[38;5;13mDo you want to view images under path\t(\e[0m\e[38;5;46mY\e[38;5;13m/\\e[0m\e[38;5;196mN\e[38;5;13m):\n\t'\e[0m\e[38;5;46m$(pwd)\e[0m\e[38;5;13m'\e[0m"
        read -s -q || return 0
        sleep 1
    fi
    kitty icat --place="0,0" "$UserInput" 2>/dev/null
}
