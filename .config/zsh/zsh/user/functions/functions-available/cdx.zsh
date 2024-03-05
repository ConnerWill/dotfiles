# shellcheck disable=1072,2148

function cdX(){
    printf "Change directories to X\n"
    printf "Here is a list of the currently defined cd aliases\n"
    if [[ $functions[draw_entire_line] ]]; then
        draw_entire_line
    else
        printf "----------\n"
    fi
    alias -r | grep --extended-regexp --regexp='^cd.*$'
}

function cdz() {
    # Localize variables
    local _Destination _currentdir _openeditor
    # Define variables
    _Destination="${1}"
    _openeditor="${2}"
    _currentdir="${PWD}"
    # Check if No Destination, Use ZDOTDIR if set otherwise nothing
    if [[ -z "${_Destination}" ]]; then
        # Check ZDOTDIR
        if [[ -z "$ZDOTDIR" ]]; then
            _Destination="$_currentdir"
        else
            _Destination="${ZDOTDIR}"
        fi
    fi
    # Check if CurrentDir = Destination
    [[ "$_currentdir" == "${_Destination}" ]] \
        && printf '\e[0;38;5;190mNo need to move \e[0;1;48;5;51;38;5;9m:)\e[0m \e[0;38;5;27mYou are where you should be:\t\e[0;1;3;38;5;9m"\e[0;3;38;5;201m%s\e[0;1;3;38;5;9m"\e[0m\n' "${_Destination}" && return 0
    # Check if Destination doesnt exist
    [[ ! -d "${_Destination}" ]] \
        && printf '\e[0;38;5;196mCannot find:\t"\e[0;1;3;38;5;226m%s\e[0;3;38;5;196m"\e[0m\n' "${_Destination}" && return 1
    # Check if EDITOR defined
    [[ -z "${EDITOR}" ]] \
        && unset _openeditor
    # If passed 2 inputs, open path in EDITOR
    if [[ -z "${_openeditor}" ]]; then
        # Move to Destination, error if failed
        cd "${_Destination}" \
            && printf '\e[0;38;5;82mMoved to:\t"\e[0;1;38;5;226m%s\e[0;38;5;82m"\e[0m\n' "${_Destination}" && return 0 \
            || printf '\e[0;3;38;5;196mUnable to move to:\t"\e[0;1;3;38;5;226m%s\e[0;3;38;5;196m"\e[0m\n' "${_Destination}" || return 1
    else
        # Edit Destination, error if failed
        "${EDITOR}" "${_Destination}" \
            && printf '\e[0;38;5;82mOpening :\t"\e[0;1;38;5;226m%s\e[0;38;5;82m" \e[0;38;5;82min \e[0;1;38;5;27m%s\e[0m\n' "${_Destination}" "${EDITOR}" && return 0 \
            || printf '\e[0;3;38;5;196mFailed Editing:\t"\e[0;1;3;38;5;226m%s\e[0;3;38;5;196m"\e[0m\n' "${_Destination}" || return 1
    fi
}

### cd to ZDOTDIR subfolders
if [[ -n "${ZDOTDIR}" ]]; then
    if [[ -n "${ZSH_USER_DIR}" ]]; then
        if [[ -d "${ZSH_USER_DIR}" ]]; then
            alias cdz-='cdz'
            alias cdz-f='cdz ${ZSH_USER_DIR}/functions/functions-available'
            alias cdzf='cdz ${ZSH_USER_DIR}/functions/functions-available'
            alias cdz-fa='cdz ${ZSH_USER_DIR}/functions/functions-available'
            alias cdzfa='cdz ${ZSH_USER_DIR}/functions/functions-available'
            alias cdz-fe='cdz ${ZSH_USER_DIR}/functions/functions-enabled'
            alias cdzfe='cdz ${ZSH_USER_DIR}/functions/functions-enabled'
            alias cdz-p='cdz ${ZSH_USER_DIR}/plugins'
            alias cdzp='cdz ${ZSH_USER_DIR}/plugins/plugins-available'
            alias cdzpa='cdz ${ZSH_USER_DIR}/plugins/plugins-available'
            alias cdzpe='cdz ${ZSH_USER_DIR}/plugins/plugins-enabled'
            alias cdz-d='cdz ${ZSH_USER_DIR}/zsh.d'
            alias cdzd='cdz ${ZSH_USER_DIR}/zsh.d'
            alias ezsh='${EDITOR} ${ZSH_USER_DIR}/zsh.d'
        fi
    fi
fi

### cd to VIMDIR subfolders
if [[ -n "${NVIMDIR}" ]]; then
    if [[ -d "${NVIMDIR}" ]]; then
        alias cdv='cdz ${NVIMDIR}'
        alias cdv-='cdz ${NVIMDIR}/lua/user'
        alias cdvc='cdz ${NVIMDIR}/lua/config'
        alias cdvp='cdz ${NVIMDIR}/lua/plugins'
        alias envim='${EDITOR} ${NVIMDIR}/lua'
    fi
fi

### cd to awesomewm subfolders
if [[ -n "$AWESOMEWM_CONFIG_DIR" ]]; then
    AWESOMEWM_CONFIG_DIR="${XDG_CONFIG_HOME}/awesome"
    if [[ -d "$AWESOMEWM_CONFIG_DIR" ]]; then
        export AWESOMEWM_CONFIG_DIR
        alias cda='cdz $AWESOMEWM_CONFIG_DIR'
        alias cda-='cdz $AWESOMEWM_CONFIG_DIR'
        alias cda-t='cdz $AWESOMEWM_CONFIG_DIR/themes'
        alias cda-w='cdz $AWESOMEWM_CONFIG_DIR/widgets'
        alias cda-e='${EDITOR} $AWESOMEWM_CONFIG_DIR'
    fi
fi

### cd to kitty subfolders
if [[ -n "${KITTY_CONFIG_DIR}" ]]; then
    KITTY_CONFIG_DIR="${XDG_CONFIG_HOME}/kitty"
    if [[ -d "${KITTY_CONFIG_DIR}" ]]; then
        export KITTY_CONFIG_DIR
        alias cdk='cdz ${KITTY_CONFIG_DIR}'
        alias cdk-='cdz ${KITTY_CONFIG_DIR}'
        alias cdk-d='cdz ${KITTY_CONFIG_DIR}/kitty.d'
        alias cdk-t='cdz ${KITTY_CONFIG_DIR}/themes'
        alias cdk-k='cdz ${KITTY_CONFIG_DIR}/keybindings'
        alias cdk-e='${EDITOR} ${KITTY_CONFIG_DIR}/kitty.conf'
    fi
fi

### cd to temporary folder
TEMPORARY_DIR="${TEMPORARY_DIR:-${HOME}/temporary}"
if [[ -d "${TEMPORARY_DIR}" ]]; then
    export TEMPORARY_DIR
    alias cdt='cdz ${TEMPORARY_DIR}'
fi
