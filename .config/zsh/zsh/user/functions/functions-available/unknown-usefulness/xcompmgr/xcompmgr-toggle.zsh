#!/bin/bash
#
# Start a composition manager.
# (xcompmgr in this case)

comphelp() {
    echo "Composition Manager:"
    echo "   (re)start: COMP"
    echo "   (re)start: COMP"
    echo "   stop:      COMP -s"
    echo "   query:     COMP -q"
    echo "              returns 0 if composition manager is running, else 1"
    exit
}

checkcomp() {
    pgrep xcompmgr &>/dev/null
}

stopcomp() {
    checkcomp && killall xcompmgr
    echo "Turning xcompmgr OFF"
}

startcomp() {
    stopcomp
    # Example settings only. Replace with your own.
    xcompmgr -CcfF -I-.015 -O-.03 -D6 -t-1 -l-3 -r4.2 -o.5 &
    echo "Turning xcompmgr ON"
    exit
}

case "$1" in
    "")   startcomp ;;
    "-q") checkcomp ;;
    "-s") stopcomp; exit ;;
    *)    comphelp ;;
esac
