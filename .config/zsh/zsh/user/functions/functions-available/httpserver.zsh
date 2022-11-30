
##{{{ main
httpserver(){
    local inputDIR localhostURL localhostPORT
    export serverPID
    localhostPORT=8000
    localhostURL="http://localhost:${localhostPORT}"
    inputDIR="${*}"

    if [ -z "${inputDIR}" ]; then
        inputDIR="$(pwd)"
        printf "using %s\n" "${inputDIR}"
    fi

    if pgrep -f http.server ; then
        kill "$(pgrep -f http.server)" && echo "killed " || echo "failed2kill"
        sleep 1
    fi

    python -m http.server --directory "${inputDIR}" $localhostPORT &
    serverPID=$!
    # if [ $serverPID -gt 0 ]; then
        xdg-open "${localhostURL}"
        printf "\n\tDir:\t%s\n\tURL:\t%s\n\nTo kill server run:\n\n\t\tkillserver\n\nor\n\n\t\t kill %s\n\n\n" "${inputDIR}" "${localhostURL}" $serverPID
        alias killserver"kill $serverPID"
        fg $serverPID

    # else
        # printf "Fail\n"
    # fi
}
##}}}



