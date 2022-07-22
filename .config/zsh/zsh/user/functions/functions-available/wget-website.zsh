function wgetmirrorwebsite(){
    local domaintoDL="$1"
    local OUTPUTDIR="$2"

    [[ -z "${domaintoDL}" ]] \
        && printf "\e[0;1;38;5;196mDid not receive URL \t\e[0;3;38;5;93m:'(\e[0m\n" \
        && printf "\n\t\e[0;1;38;5;82mUsage:\n\t\t\e[0;38;5;11m%s \e[0;3;38;5;201m<URL> \e[0;3;38;5;93m<OUTPUT_DIR>\n\n\t\e[0;1;38;5;82mExample:\n\t\t\e[0;38;5;11m%s \e[0;3;38;5;201m\"https://google.com\" \e[0;3;38;5;93m\"%s/Trash\"\n\n\e[0m" "$0" "$0" "$HOME" \
            && return 1

    
    [[ -z "${OUTPUTDIR}" ]] \
        &&  printf "\e[0;1;38;5;196mNo directory to output to \t\e[0;1;38;5;93m>:(\e[0m\n" \
        && printf "\n\t\e[0;1;38;5;82mUsage:\n\t\t\e[0;38;5;11m%s \e[0;3;38;5;201m<URL> \e[0;3;38;5;93m<OUTPUT_DIR>\n\n\t\e[0;1;38;5;82mExample:\n\t\t\e[0;38;5;11m%s \e[0;3;38;5;201m\"http://nsa.gov\" \e[0;1;38;5;93m\"/root\"\n\n\e[0m" "$0" "$0" \
            && return 1
    
    [[ ! -d "${OUTPUTDIR}" ]] \
        &&  printf "\e[0;1;38;5;196mNot a directory\t\e[0;1;38;5;93m>:(\e[0m\n" \
            && return 1
    
    cd "$OUTPUTDIR" || return 1

    mkdir -v -p "$OUTPUTDIR" \
        && cd "$OUTPUTDIR" \
        || return 1 
    
    # wget --verbose \
    #     --debug \
    #     --progress=bar:force:noscroll \
    #     --show-progress \
    #     --force-directories \
    #     --recursive \
    #     -l 0 \
    #     --force-html \
    #     --page-requisites \
    #     --convert-links \
    #     --mirror \
    #     --no-parent \
    #     --no-remove-listing \  --domains=:"${domaintoDL}" \
    #     --append-output="${OUTPUTDIR}/wget-download.log" \
    #


  wget --mirror --convert-links --html-extension --wait=5 --random-wait \
    "${domaintoDL}" \
    \
        || printf "\e[0;1;38;5;196mError running wget\t\e[0;1;38;5;93m>:(\e[0m\n" \
        ; sleep 1 && printf "\e[0;1;38;5;82mRunning in background\t\e[0;1;38;5;11m:}\n\n\e[0;1;38;5;55m%s\e[0m\n" "$(ls -1 "$OUTPUTDIR")"
}



RAN1="$(echo "$RANDOM" | cut --characters 2-5)"
RAN2="$(echo "$RANDOM" | cut --characters -3)"
RAN3="$(echo "$RANDOM" | cut --characters -5)"
alias wget-mirror-website="wgetmirrorwebsite"

[[ -n "$1" ]] && [[ -n "$2" ]] \
    && wgetmirrorwebsite "$1" "$2"\
    
[[ -n "$1" ]] && [[ -z "$2" ]] \
    && echo -e "\n\t\e[0;1;38;5;$(echo "$RANDOM" | cut --characters -2)mUsage:\n\t\t\e[0;38;5;${RAN1}mwget-mirror-website \e[0;3;38;5;${RAN2}m<URL> \e[0;3;38;5;${RAN3}m<OUTPUT_DIR>\n\n\t\e[0;1;38;5;$(echo "$RANDOM" | cut --characters -2)mExample:\n\t\t\e[0;38;5;${RAN1}mwget-mirror-website \e[0;3;38;5;${RAN2}m\"https://google.com\" \e[0;3;38;5;${RAN3}m\"$HOME/Trash\"\n\n\e[0m"
unset RAN1 RAN2 RAN3
    # wget \
    #     --page-requisites \
    #      --html-extension \
    #       --convert-links \
    #        --no-parent \
    #         --progress=bar:force:noscroll \
    #        --report-speed=bits \
    #       --rejected-log=logfile \
    #      --random-wait=on \
    #     --wait=20  \
    #      --waitretry=30 \
    #       --mirror \
    #        --convert-links \
    #         --recursive \
    #          --level=0 \
    #
