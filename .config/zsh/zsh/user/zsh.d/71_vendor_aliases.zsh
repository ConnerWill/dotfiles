# shellcheck disable=2148


### Suffix Aliases
autoload -U zsh-mime-setup && zsh-mime-setup
alias -s html="${BROWSER}"
alias -s htm="${BROWSER}"


if [[ "${commands[evince]}" ]]; then
    alias -s pdf=evince
elif [[ "${commands[termux-open]}" ]]; then
    alias -s pdf=termux-open
fi

## Images
if [[ "${commands[eog]}" ]]; then
    alias -s png=eog
    alias -s jpg=eog
    alias -s jpeg=eog
    alias -s gif=eog
elif [[ "${commands[termux-open]}" ]]; then
    alias -s png=termux-open
    alias -s jpg=termux-open
    alias -s jpeg=termux-open
    alias -s gif=termux-open
    alias -s pdf=termux-open
fi

## Videos
if [[ "${commands[mpv]}" ]]; then
    alias -s mp4=mpv
    alias -s avi=mpv
    alias -s mkv=mpv
    alias -s wmv=mpv
    alias -s mov=mpv
elif [[ "${commands[termux-open]}" ]]; then
    alias -s mp4=termux-open
    alias -s avi=termux-open
    alias -s mkv=termux-open
    alias -s wmv=termux-open
    alias -s mov=termux-open
fi



### [=]==================================[=]
### [~]............ RSYNC
### [=]==================================[=]
if [[ "${commands[rsync]}" ]]; then
    alias cpr='rsync --archive --human-readable --info=progress2'
    alias cprvvv='rsync --archive --human-readable --info=ALL'
    alias cpMISC='rsync --archive --human-readable --info=MISC'
    alias cpREMOVED='rsync --archive --human-readable --info=REMOVE'
    alias cpSKIPPED='rsync --archive --human-readable --info=SKIP'
    alias cpSTAT='rsync --archive --human-readable --info=STATS'
fi

### [=]==================================[=]
### [~]............ RCLONE
### [=]==================================[=]
if [[ "${commands[rclone]}" ]]; then
    alias rclone-tree-all='rclone tree sk8: --color --verbose'
fi

### [=]==================================[=]
### [~]............ TERRAFORM
### [=]==================================[=]
if [[ "${commands[terraform]}" ]]; then
  if [[ ! "${commands[tf]}" ]]; then
    alias tf='terraform'
  fi
fi

### [=]==================================[=]
### [~]......... Package Managers
### [=]==================================[=]
if [[  -n "${DISTRO}" ]]; then
    if [[ ${DISTRO} == "Arch" ]] || [[ ${DISTRO} == "Parabola" ]] || [[ ${DISTRO} == "Artix" ]] || [[ ${DISTRO} == "Manjaro" ]] && [[ "${commands[pacman]}" ]]; then
        alias paci="${SUDOCMD} pacman -S --color always --verbose"
        alias pacinstall="${SUDOCMD} pacman -S --color always --verbose"
        alias paclist-installed="${SUDOCMD} pacman -Q --color always"
        alias pacman="pacman --color always"
        alias pacs="pacman -Ss --color=always"
        alias pacsi="pacman -Sii --color always --verbose"
        alias update="${SUDOCMD} pacman -Syuv" # Upgrade all system packages.
        if [[ "${commands[yay]}" ]]; then
            alias yay='yay --color always'
            alias yays='yay -Ss --color always --sortby votes'
            alias yays-aur='yay -Ss --color always --sortby votes --aur'
            alias yaysi='yay -S -ii --color always'
            alias yaysearch='yay -Ss --color always'
            alias yaysearch-popular='yay -Ss --color always --sortby popularity'
            alias yaysearch-name='yay -Ss --color always --sortby name'
            alias yaysearch-modified='yay -Ss --color always --sortby modified'
            alias yaysearch-votes='yay -Ss --color always --sortby votes'
            alias yayinstall='yay -S --color always --verbose'
            alias yayi='yay -S --color always --verbose --needed'
            alias yayino='yay -S --color always --verbose --needed --noconfirm'
            alias yaylist='yay -Q --color always'
            alias yayclean="yay -Scv --noconfirm && \rm -rfv ${XDG_CACHE_HOME}/yay/*"
        fi
    elif [[ ${DISTRO} == "Debian" ]] || [[ ${DISTRO} == "Raspbian" ]] || [[ ${DISTRO} == "Rpios" ]] || [[ ${DISTRO} == "Ubuntu" ]]; then
        alias apts="apt search"
        alias apti="apt install"
        alias apt-upgrade="sudo -s <<< 'apt --yes update && apt --yes upgrade && apt --yes autoremove && apt --yes autoclean'"
        alias apt-upgrade-full="sudo -s <<< 'subcmds=(update full-upgrade autoremove autoclean); for subcmd in \"\${subcmds}\"; do apt -y \"\${subcmd}\"; done; unset subcmds subcmd >/dev/null 2>&1'"
    elif [[ ${DISTRO} == "Android" ]] || [[ ${DISTRO} == "Termux"  ]] && [[ "${commands[pkg]}" ]]; then
        alias pkgi="pkg install"
        alias pkgs="pkg search"
        alias pkgu="pkg upgrade"
        if [[ "${commands[pkgfzf]}" ]] && [[ "${commands[fzf]}"  ]]; then
            alias pkgf="pkgfzf fzf"
        fi
    elif [[ ${DISTRO} == "Gentoo" ]] && [[ "${commands[emerge]}" ]]; then
        printf "PLEASE ADD emerge aliases to %s\n" "${0}"
    fi
fi

### [=]==================================[=]
### [~]............ AWESOMEWM
### [=]==================================[=]
if [[ "${commands[awesome]}" ]]; then
    alias eawesome="$EDITOR ${XDG_CONFIG_HOME}/awesome/rc.lua"
    alias awesome-quit="awesome-client 'awesome.quit()'"
    alias awesome-restart="awesome-client 'awesome.restart()'"
    alias cdawesome="cd ${XDG_CONFIG_HOME}/awesome || printf \"\e[0;38;5;196mCANNOT CD TO THERE\e[0m\n\""
    alias awesome-check="awesome --check"
    alias check-awesome="awesome --check"
    alias list-desktop-applications="ls /usr/share/applications | awk -F '.desktop' ' { print $1}' -"
fi

### [=]==================================[=]
### [~]............ LSD
### [=]==================================[=]
if [[ "${commands[lsd]}" ]]; then
    alias lsd="lsd --color always --icon always"
    alias ls="lsd --color always --icon always"
    alias 'cd ls'='lsd'
    alias ks='ls'
    alias la='ls'
    alias s='lsd'
    alias LS='lsd'
    # alias lllll='draw_entire_line 5 "\e[0;1;38;5;82m"; draw_entire_line 5 "\e[0;1;38;5;198m; lsd --long -A --sort=size --reverse --total-size; draw_entire_line 5 "\e[0;1;38;5;198m; draw_entire_line 5 "\e[0;1;38;5;198m"'
    alias lla='lsd --all --long --total-size --sizesort --reverse'
    alias lstree="lsd --almost-all --tree --total-size --human-readable ${1} 2>/dev/null"                                    # List All On One Line Recurse Sort By Modification Time Long List Reversed
    alias lst="lsd --oneline --long --almost-all --reverse --timesort --human-readable ${1} 2>/dev/null"                   # List All On One Long Line Sort By Modification Time
    alias lltree='printf "\e[0;1;38;5;46mGathering tree ...\n\n\e[0;1;38;5;33mThis may take a while\e[0;1;38;5;190m     \e[0m\n"; echo "$(lsd   --almost-all --tree --total-size -l --sort=time --human-readable --depth=10 2>/dev/null)"'
    alias l='lsd  --oneline --no-symlink --almost-all' # List All On One Line

    ## lsd flags in alieas set below require a newer version of lsd
    alias lls="printf '\e[0;1;38;5;93m🍆💦🍑\e[0;1;3;4;38;5;199mThis could take a hot sec...\e[0m\e[0;1;38;5;93m🍄🦄🐉\e[0m\t'; date +'%Y%m%d_%H%M%S'; lsd --long --sort=size --header --color=always --total-size --date=+'%Y%m%d%H%M%S' --almost-all --dereference --blocks 'size,date,name' --reverse --permission octal 2>/dev/null"
    alias ll='lsd --oneline --long --almost-all --permission octal --date=+%Y%m%d-%H%M%S'
    alias lsl='lsd --oneline --long --almost-all --date=+%Y%m%d-%H%M%S'
    alias lsl='lsd --oneline --long --almost-all --date=+%Y%m%d-%H%M%S --sort extension'
    alias sl='lsd --oneline --long --almost-all --permission octal' # List All On One Line Sort By Extension
fi

### [=]==================================[=]
### [~]............ EXA
### [=]==================================[=]
# _EXA=$(command -v exa | awk '{print $2}')
# if [[ -f "$_EXA" ]]; then
# ### exa
if [[ "${commands[exa]}" ]]; then
    #   alias exa='exa --color always --colour-scale --icons --numeric --git --time-style=long-iso --long'
    #   alias l1='exa  --oneline --all --header'
    #   alias ls-l="exa --long --all"
    #   alias ls-ll="exa --sort=type --tree --recurse --long --all"
    alias exa="exa --color always --color-scale --icons --all"
    alias l1='exa  --oneline --all --header'                        # List All On One Line
    alias lll='exa --long --octal-permissions --all --header --no-time --no-user --sort=type --colour-scale'
    alias llllll='draw_entire_line 2 "\e[0;1;38;5;93m"; lsd --long -A sort=size --reverse --total-size; draw_entire_line 2 "\e[0;1;38;5;93m"'
    alias llsa='exa --color-scale --long --all --long --icons --group-directories-first --sort=size --no-permissions --no-time --no-user --tree --level 3'
    alias ls-l="exa --sort=type --long --all"
fi

### [=]==================================[=]
### [~]............ SHELLCHECK
### [=]==================================[=]
if [[ "${commands[shellcheck]}" ]]; then
    alias shellcheck-all="shellcheck --check-sourced --enable=all --list-optional --color=always --external-sources --format=tty --wiki-link-count=20"
    if [[ "${commands[shellharden]}" ]]; then
        [[ -f "${ZSH_FUNCTIONS_MANUAL}/shellcheck-harden.zsh" ]] && source "${ZSH_FUNCTIONS_MANUAL}/shellcheck-harden.zsh"
    fi
fi

### [=]==================================[=]
### [~]........... CAT/BAT
### [=]==================================[=]
if [[ "${commands[bat]}" ]]; then
    alias  cat='bat --style=header,grid'
    alias  bat="bat --style=header,grid"
    alias catf="bat --style=full"
    alias   ca='bat' ; alias cst="cat" ; alias scat="cat"
    alias  car="cat" ; alias cay="cat" ; alias  cau="cat"
    alias  cau="cat" ; alias  ca="bat" ; alias catp="bat -p"

    if [[ "${commands[fzf]}" ]]; then
        function bat_preview_themes(){
            local viewfile
            viewfile="${1:-${ZSHRC:-${ZDOTDIR}/.zshrc}}"
            [[ -f "${viewfile}" ]] || printf "Cannot find file to preview:\t%s\n" "${viewfile}" >&2 || return 1
            bat --list-themes \
                | sort --reverse   \
                | fzf --preview-window=right,80% --preview="bat --theme={} --language=zsh --color=always ${viewfile}"
        } #; alias bat-preview-themes="bat_preview_themes"

        function bat_preview_languages(){
            local viewfile
            viewfile="${1:-${ZSHRC:-${ZDOTDIR}/.zshrc}}"
            [[ -f "${viewfile}" ]] || printf "Cannot find file to preview:\t%s\n" "${viewfile}" >&2 || return 1
            bat --list-languages        \
                | sort --reverse          \
                | awk -F ":" '{print $2}' \
                | awk -F "," '{print $1}' \
                | awk '{print $1}'        \
                | fzf --preview-window=right,80% --preview="bat --language={} --color=always ${viewfile}"
        } #; alias bat-preview-languages="bat_preview_languages"
    fi

    alias man-bat='man --pager="bat --language=sh --plain --color=never" xkeyboard-config '
    alias man-bat-global-apropos='man --pager="bat --language=sh" --global-apropos'
fi

## bat is 'batcat' when installed via apt
if [[ "${commands[batcat]}" ]]; then
  alias bat="batcat --style=header,grid"
  alias cat="bat"
fi

function c(){
    local catthis
    catthis="${1}"
    if   [[ -z "${catthis}" ]]; then clear && return 0 || return 1; fi
    if   [[ -d "${catthis}" ]]; then cd  "${catthis}"  || printf "\e[0;38;5;196mFailed to cd to %s\e[0m\n]]" "${catthis}" || return 1 && return 0
    elif [[ -f "${catthis}" ]]; then cat "${catthis}"  || return 1 && return 0
    else return 0
    fi
}



### [=]==================================[=]
### [~]............ POWERSHELL
### [=]==================================[=]
if [[ "${commands[pwsh]}" ]]; then
    alias powershell="pwsh"
    # alias cdp="cd ${PDOTDIR} || printf 'CANNOT MOVE TO %s' ${PDOTDIR}"
fi


### [=]==================================[=]
### [~]............ GPING
### [=]==================================[=]
if [[ "${commands[gping]}" ]]; then
    alias gping="gping -4 --watch-interval 0.1"
fi


### [=]==================================[=]
### [~]............ VIRSH
### [=]==================================[=]
if [[ "${commands[virsh]}" ]]; then
    alias virsh-list="virsh list --all"
    alias virt-manager-list="virsh list --all"
fi

#alias tcpdump-OpenWRT-termshark="sudo --prompt='Enter password for tcpdump: ' clear && ssh root@192.168.69.1 tcpdump -i any -U -s0 -w - 'not port 22' | sudo termshark -i -"
#alias tcpdump-OpenWRT-tshark="sudo --prompt='Enter password for tcpdump: ' clear && ssh root@192.168.69.1 tcpdump -i any -U -s0 -w - 'not port 22' | sudo tshark --color -i -"

### [=]==================================[=]
### [~]............ ATTRACTORR
### [=]==================================[=]
if [[ "${commands[attractorr]}" ]]; then
    alias attractorr="attractorr --sort seeders"
fi

### [=]==================================[=]
### [~]............ ETCKEEPER
### [=]==================================[=]
if [[ "${commands[etckeeper]}" ]]; then
    alias etckeeper="sudo etckeeper"
    alias etckeeper-diff="sudo etckeeper vcs status -u"
    alias etckeeper-diff="etckeeper vcs log --unified --color-words | diff-so-fancy --colors | less --tabs=2 -RFX"
    alias etckeeper-modified="etckeeper vcs ls-files --modified"
    alias etckeeper-add="etckeeper vcs add /etc/* --verbose"
    alias etckeeper-add-interactive="etckeeper vcs add /etc/* --verbose --interactive"
    alias etckeeper-commit="echo -e \"\e[38;5;201metckeeper:\e[38;5;27m\tCommiting Changes ...\e[0m\" && etckeeper commit ${COMMITMSG}"
fi

### [=]==================================[=]
### [~]............ Neofetch
### [=]==================================[=]
if [[ "${commands[neofetch]}" ]]; then
    alias nf='neofetch'
fi

### [=]==================================[=]
### [~]............ File Explorers
### [=]==================================[=]
if [[ "${commands[pcmanfm]}" ]]; then
    alias fe='pcmanfm &'
fi

### [=]==================================[=]
### [~]............ GIT
### [=]==================================[=]
if [[ "${commands[gh]}" ]]; then
    alias ghs-shell='printf "\e[0;1;3;4;38;5;33mSearch GitHub For Shell\e[0m\n" ; gh s -l shell'
    alias ghs-view='printf "\e[0;1;3;4;38;5;33mSearch GitHub, Press <Enter> to view README\e[0m\n" ; gh repo view $(gh s) | g -'
    alias ghc='git clone --no-checkout --verbose'
    alias gh-list-my-repos="gh s -E -u @me"
fi

if [[ "${commands[git]}" ]]; then
    # alias cd-git-top="cd $(git rev-parse --show-toplevel)"
    alias giot="git"
    alias guit="git"
    alias giut="git"
    alias got="git"
    alias gpt="git"
    alias gut="git"
    alias git-clone-nocheckout="git clone --no-checkout --verbose"
    alias git-commit-custom='git commit --gpg-sign="3AED4B68E6FD33BC" --message='
    alias git-config-options='git config --list'
    alias git-get-url='git-open --print'
    alias git-log-pretty="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    alias gitc='git clone --no-checkout --verbose'
    alias gg="git"
    alias gp="git pull -v"
    alias gc="git commit --edit --verbose --status"
    alias gs="git status"
    alias git-url="git config --local --get remote.origin.url"
    if [[ "${commands[lazygit]}" ]]; then
        alias git-lazy="lazygit"
    fi
fi

### [=]==================================[=]
### [~]............ GO
### [=]==================================[=]
if [[ "${commands[go]}" ]]; then
  alias goclean='go clean -cache -modcache'
fi

### [=]==================================[=]
### [~]............ DISPLAY
### [=]==================================[=]
if [[ -n "${DISPLAY}" ]]; then
    if [[ "${commands[xclip]}" ]]; then
        alias clip='xclip -selection clipboard -rmlastnl'
        alias copy='xclip -selection clipboard -rmlastnl'
        alias xcopy='xclip -selection clipboard -rmlastnl'
        alias pwd-to-clip='pwd | xclip -selection clipboard'
        alias pwd2clip='pwd | xclip -selection clipboard'
        if [[ "${commands[xdotool]}" ]]; then
            alias type-clipboard="xclip -selection clipboard -out | tr \\n \\r | xdotool selectwindow windowfocus type --clearmodifiers --delay 25 --window %@ --file -"
        fi
    fi
    if [[ "${commands[setxkbmap]}" ]]; then
        alias capslock-escape-keyboard="setxkbmap -layout us -variant ,qwerty -option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape' ; xset r rate 200 30      ; printf 'Increased typing speed!\nCapsLock should now be the escape key\t\e[0;1;38;5;201m :) \e[0m\n'"
        alias swap-capslock-escape-keyboard="setxkbmap -layout us -variant ,qwerty -option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape' ; xset r rate 175 30 ; printf 'Increased typing speed!\nCapsLock should now be the escape key\t\e[0;1;38;5;201m :) \e[0m\n'"
    fi
    if [[ "${commands[nitrogen]}" ]]; then
        alias window-spy='xprop'
    fi

    if [[ "${commands[nitrogen]}" ]]; then
        alias wp='nitrogen --restore'
    fi

    if [[ "${commands[gpick]}" ]]; then
        alias colorpicker='gpick'
    fi

    ### [=]==================================[=]
    ### [~]............ Raspberry Pi
    ### [=]==================================[=]
    if [[ "${commands[rpi-imager]}" ]]; then
        alias rpi-imager='sudo rpi-imager &'
        alias raspberrypi-imager='sudo rpi-imager &'
        alias raspberry-imager='sudo rpi-imager &'
    fi

    ### [=]==================================[=]
    ### [~]............ CAD / 3D Printing
    ### [=]==================================[=]
    if [[ "${commands[prusa-slicer]}" ]]; then
        alias slic3r='prusa-slicer &'
    fi

    ### [=]==================================[=]
    ### [~]............ VNC
    ### [=]==================================[=]
    if [[ "${commands[vncviewer]}" ]]; then
        alias vncviewer-custom='vncviewer --DotWhenNoCursor --UpdateScreenshot --PasswordStoreOffer --AutoReconnect --FullScreen --SecurityNotificationTimeout=0 --ToolbarIconSize=16 --SessionRecordAllowUserControl -FullScreen -AutoReconnect --KeepAliveResponseTimeout=30 --KeepAliveInterval=30 --NotificationPos=2 &'
    fi
    if [[ "${commands[x11vnc]}" ]]; then
        alias vnc-server-start="x11vnc -nevershared -forever -usepw &"
    fi

    if [[ "${commands[monero-wallet-gui]}" ]]; then
        alias monero-gui="monero-wallet-gui"
    fi

    ### [=]==================================[=]
    ### [~]........... FIREJAIL
    ### [=]==================================[=]
    ## Firejail
    if [[ "${commands[firejail]}" ]]; then
        alias fjfx='firejail firefox --private'
    fi

    ### [=]==================================[=]
    ### [~]............ GPU
    ### [=]==================================[=]
    ## View display/gpu events in xorg log file ##
    if [[ -f "/var/log/Xorg.0.log" ]]; then
        alias xorglog='cat /var/log/Xorg.0.log | grep -vi input | grep -vi keyboard | grep -vi logitech | less'
    fi

    if [[ "${commands[xterm]}" ]]; then
        alias xterm='xterm -fg white -bg black -cr red -bd blue'
    fi

    if [[ "${commands[xcompmgr]}" ]]; then
        alias start-compositor="xcompmgr &"
    fi

    if [[ "${commands[wmctl]}" ]]; then
        alias list-windows='wmctrl -l -p -G -x'
        alias list-desktops='wmctrl -d'
    fi

    if [[ "${commands[Xephyr]}" ]] && [[ "${commands[awesome]}" ]]; then
        alias awesomewm-xephyr-emulate="Xephyr :5 -screen 1280x720 -resizeable & sleep 1 ; DISPLAY=:5 awesome"
    fi

    ## END DISPLAY if statement
fi

### [=]==================================[=]
### [~]............ Screen Capturing
### [=]==================================[=]

if [[ "${commands[rgb-tui]}" ]]; then
    alias colorpicker-tui='rgb-tui'
fi

if [[ "${commands[vtop]}" ]]; then
    alias colortop='vtop'
fi


### [=]==================================[=]
### [~]............ NMAP
### [=]=======VIRSH=================[=]
#shellcheck disable=1009
if [[ "${commands[nmap]}" ]]; then
    typeset -A nmapaliases
    nmapaliases[nmap-fast]="nmap -F -T5 --version-light --top-ports 300"
    nmapaliases[nmap-vulscan]="nmap -sV -vv --script=vulscan/vulscan.nse"
    nmapaliases[nmap-vulns]="nmap --script=vuln"
    nmapaliases[nmap-list-ifs]="nmap --iflist"
    nmapaliases[nmap-open-ports]="nmap --open"
    nmapaliases[nmap-ping-scan]="nmap -n -sP"
    nmapaliases[nmap-ping-fw]="nmap -PS -PA"
    nmapaliases[nmap-fin]="sudo nmap -sF -v"
    nmapaliases[nmap-slow]="sudo nmap -sS -v -T1"
    nmapaliases[nmap-check-fw]="sudo nmap -sA -p1-65535 -v -T4"
    nmapaliases[nmap-versions]="sudo nmap -sV -p1-65535 -O --osscan-guess -T4 -Pn"
    nmapaliases[nmap-full]="sudo nmap -sS -T4 -PE -PP -PS80,443 -PY -g 53 -A -p1-65535 -v"
    nmapaliases[nmap-full-udp]="sudo nmap -sS -sU -T4 -A -v -PE -PS22,25,80 -PA21,23,80,443,3389 "
    nmapaliases[nmap-tracrt]="sudo nmap -sP -PE -PS22,25,80 -PA21,23,80,3389 -PU -PO --traceroute "
    nmapaliases[nmap-full-scripts]="sudo nmap -sS -sU -T4 -A -v -PE -PP -PS21,22,23,25,80,113,31339 -PA80,113,443,10042 -PO --script all"
    nmapaliases[nmap-web_safe_osscan]="sudo nmap -p 80,443 -O -v --osscan-guess --fuzzy"
    #shellcheck disable=1072,1058,1073
    for nmapaliasname nmapaliasvalue in ${(kv)nmapaliases}; do
        alias "${nmapaliasname}"="${nmapaliasvalue}"
    done; unset nmapaliasname nmapaliasvalue
    #typeset -A nmapaliasesdesc
    #nmapaliasesdesc[nmapaliases[nmap-fast]="nmap -F -T5 --version-light --top-ports 300"]="fast scan of the top 300 ports with fastest speed"
    #nmapaliasesdesc[nmapaliases[nmap-ping-scan]="nmap -n -sP"]="Nmap ping scan"
    if [[ "${commands[nmapAutomator.sh]}" || "${commands[nmapAutomator]}" ]]; then
        alias nmapAutomatorAll="sudo nmapAutomator.sh --type All --output ${NMAPSCAN:-${PWD}} --host"
    fi
fi

### [=]==================================[=]
### [~]............ MetaSploit
### [=]==================================[=]
if [[ "${commands[rsf]}" ]]; then
    alias -s routersploit='rsf'
fi

if [[ "${commands[metasploit]}" ]]; then
    alias msf="${SUDOCMD} msfconsole"
fi


### [=]==================================[=]
### [~]............. DOCKER
### [=]==================================[=]
if [[ "${commands[docker]}" ]]; then
    alias docker-run-interactive="docker run --interactive --tty"
    alias docker-run-archlinux='clear; printf "\x1B[0;1;38;5;51mSTARTING ARCH LINUX IN DOCKER\x1B[0m\n"; docker run --interactive --tty archlinux'
    alias dockers="docker search --no-trunc"
    alias aws-docker="docker run --rm -it amazon/aws-cli"
    alias docker-cleanup='docker rm -f $(docker ps -aq) ; docker rmi -f $(docker images -aq)'
    if [[ "${commands[lazydocker]}" ]]; then
        alias docker-lazy='lazydocker'
    fi
fi

### [=]==================================[=]
### [~]....... DU ALTERNATIVES
### [=]==================================[=]
if [[ "${commands[duviz]}" ]]; then
    alias duviz="duviz --color --no-progress --max-depth=50"
    alias duviz-pwd="sudo --validate --prompt='Enter sudo password to run duviz: ' && clear; sudo duviz --color --max-depth 50 --one-file-system --no-progress --dereference 2&>/dev/null"
fi

if [[ "${commands[dfrs]}" ]]; then
    alias disk-usage="dfrs --human-readable --total --color=always --columns=filesystem,bar,used_percentage,used,available_percentage,available,capacity,type,mounted_on 2>/dev/null"
    alias watch-disk-usage="watch -c --interval 0.5 --no-title --differences dfrs --human-readable --total --color=always --columns=filesystem,bar,used_percentage,used,available_percentage,available,capacity,type,mounted_on"
fi

if [[ "${commands[dfc]}" ]]; then
    alias disk-usage-2="dfc 2>/dev/null"
    alias watch-disk-usage-2="watch -c --interval 0.5 --no-title --differences dfc -c always"
fi


### [=]==================================[=]
### [~]........... PYTHON
### [=]==================================[=]
if [[ "${commands[python]}" ]]; then
    alias http-server='python -m http.server'
fi

### [=]==================================[=]
### [~]........... TMUX
### [=]==================================[=]
if [[ "${commands[tmux]}" ]]; then
    alias tmux-ssh="tmux new-session ssh"
fi

### [=]==================================[=]
### [~]............ CRYPTO
### [=]==================================[=]
if [[ "${commands[monero-wallet-cli]}" ]]; then
    alias monero-cli="monero-wallet-cli"
fi

### [=]==================================[=]
### [~]............ FZF
### [=]==================================[=]
if [[ "${commands[fzf]}" ]]; then
    alias psfzf="ps -ef | fzf --bind 'ctrl-r:reload(ps -ef)' --header 'Press (CTRL-R) to reload' --header-lines=1"
fi

### [=]==================================[=]
### [~]............ Networking
### [=]==================================[=]
if [[ "${commands[lnstat]}" ]]; then
    alias get-arp-cache-table='lnstat --subject 2 --json'
fi

if [[ "${commands[nmtui]}" ]]; then
    alias networkmanager-tui='nmtui'
fi

if [[ "${commands[nmcli]}" ]]; then
    alias networkmanager-cli='nmcli'
fi

if [[ "${commands[curl]}" ]]; then
    alias external-ip='curl ifconfig.me ; printf "\n"'
fi

## If 'dog' command is found, check if 'dig' command is found.
## If 'dog' command is found but 'dig' is not found, alias 'dig' to 'dog'
if [[ "${commands[dog]}" ]]; then
    if [[ ! "${commands[dig]}" ]]; then
        alias dig='dog'
    fi
fi
