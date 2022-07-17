#function listfigletfonts () {
#
#	FIGLETFONTDIR="/usr/share/figlet/fonts"
#	cd $FIGLETFONTDIR
#	for figfile in $FIGLETFONTDIR/ *; do
#		figlet -f "$figfile" HELLO
#		echo "$figfile"
#		echo "============================"
#	done
#	cd $OLDPWD
#	unset FIGLETFONTDIR
#	unset figfile
#
#}



function listfigletfonts(){

#    set -e
#    EXIT_CODE=0

    [[ -z "$1" ]] && local mssssg="$USER" || local mssssg="$1"
    echo "$mssssg"
    for figfont in $(figlist);
    do
        figlet -f "$figfont" "$mssssg"
        #|| EXIT_CODE="$?"
    done
#    echo "$EXIT_CODE"


}






#
#    # This construct is needed, because of a racecondition when trying to obtain
#    # both of last command and error. With this the information of last error is
#    # implied by the corresponding case while command is retrieved.
#
#    if   [[ "${?}" == 0 && "${_}" != "" ]] ; then
#        # Last command MUST be retrieved first.
#        LASTCOMMAND="${_}" ;
#        RETURNSTATUS='✓' ;
#    elif [[ "${?}" == 0 && "${_}" == "" ]] ; then
#        LASTCOMMAND='unknown' ;
#        RETURNSTATUS='✓' ;
#    elif [[ "${?}" != 0 && "${_}" != "" ]] ; then
#        # Last command MUST be retrieved first.
#        LASTCOMMAND="${_}" ;
#        RETURNSTATUS='✗' ;
#        # Fixme: "$?" not changing state until command executed.
#    elif [[ "${?}" != 0 && "${_}" == "" ]] ; then
#        LASTCOMMAND='unknown' ;
#        RETURNSTATUS='✗' ;
#        # Fixme: "$?" not changing state until command executed.
#    fi
