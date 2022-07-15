function man_global_apropos(){
    SearchInput="$1"
    [[ -z "$SearchInput" ]] \
        && echo -e -n "\e[38;5;11mSearch man pages\e[0m\t\e[38;5;160mInput Required!\e[0m\n\e[38;5;11mPlease Enter Initial Search Query\e[0m: " \
        && read -r SearchInput
    [[ -z "$SearchInput" ]] \
        && return
    echo -e "\e[38;5;45mSearching man pages for\e[0m: \e[38;5;165m$SearchInput\e[0m \e[38;5;165m...\e[0m "
    man --global-apropos --pager='less -FR --pattern "$SearchInput"' "$SearchInput" \
        || echo -e -n "\e[38;5;11mSearch man pages\e[0m\t\e[38;5;160mNo results!\e[0m\n\e[38;5;11mTry again :(\e[0m: "
}
alias man-global-apropos="man_global_apropos"
alias man-search-global="man_global_apropos"
