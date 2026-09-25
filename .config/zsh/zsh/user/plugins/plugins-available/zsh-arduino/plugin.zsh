#! /bin/zsh
function log() {
    [ $ZSH_ARDUINO_LOG ] && (echo $* >> /tmp/zsh-arduino.log)
}
JQ=jq
ACLI=arduino-cli
err=$(command -v $JQ &> /dev/null || printf "%s" $JQ)
err+=$(command -v $ACLI &> /dev/null || printf ", %s" $ACLI)
if [[ -z "$err" ]]; then
    FPATH=$FPATH:"${0:A:h}"
    autoload -Uz ar_configure
    autoload -Uz ar_build
    autoload -Uz ar_upload
    autoload -Uz ar_serial
    autoload -Uz ar_env
    [ -r _arduino_cli ] || $ACLI completion zsh > "${0:A:h}/_arduino-cli"
    source _arduino_cli
    # echo "arduino plugin registered"
else
    log "zsh-arduino: Commands not found on path: $err; Plugin not registered"
fi


