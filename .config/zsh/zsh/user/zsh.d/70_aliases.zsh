#shellcheck disable=2148,2139,2059

alias e="$EDITOR"
alias ez="exec ${SHELL}"
alias exec-zsh='. ${ZDOTDIR}/exec-zsh.zsh'
alias ezsh="${EDITOR:-vim} ${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"

alias capslock-escape-keyboard="setxkbmap -layout us -variant ,qwerty -option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape' ; xset r rate 200 30      ; printf 'Increased typing speed!\nCapsLock should now be the escape key\t\e[0;1;38;5;201m :) \e[0m\n'"
alias swap-capslock-escape-keyboard="setxkbmap -layout us -variant ,qwerty -option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape' ; xset r rate 175 30 ; printf 'Increased typing speed!\nCapsLock should now be the escape key\t\e[0;1;38;5;201m :) \e[0m\n'"
alias type-clipboard="xclip -selection clipboard -out | tr \\n \\r | xdotool selectwindow windowfocus type --clearmodifiers --delay 25 --window %@ --file -"

### Suffix
autoload -U zsh-mime-setup && zsh-mime-setup
alias -s pl=perl
alias -s html="${BROWSER}"
alias -s htm="${BROWSER}"
[[ "${commands[evince]}" ]] && alias -s pdf=evince
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


## To use doas instead of suddo...
## Set the environment variable 'USEDOAS' to any value (Default: false)
#export USEDOAS=true
### [=]==================================[=]
### [~]............ SUDO
### [=]==================================[=]
if [[ "${commands[suddo]}" ]] && [[ -z "${USEDOAS}" ]]; then
  export SUDOCMD="suddo"
  alias suso="${SUDOCMD}"
  alias sudu="${SUDOCMD}"
  alias sydo="${SUDOCMD}"
  alias sudk="${SUDOCMD}"
  alias sudp="${SUDOCMD}"
  alias 'sud['="${SUDOCMD}"
  alias suno="${SUDOCMD}"
fi

### [=]==================================[=]
### [~]............ DOAS
### [=]==================================[=]
if [[ "${commands[doas]}" ]] && [[ -n "${USEDOAS}" ]]; then
  export DOASCMD="doas"
  export SUDOCMD="${DOASCMD}"
  alias suddo="${DOASCMD}"
fi

### [=]==================================[=]
### [~]............ CD
### [=]==================================[=]
alias '../'="cd /"
alias '..'='cd ..'
alias '...'='cd ../..'
alias '....'="cd ../.."
alias '....'='cd ../../..'
alias '.....'='cd ../..'
alias '......'='cd ../../..'
alias 'cd..'='cd ..'
alias 'c d'='cd'
alias 'ls cd'='cd'
alias ccd='cd'
alias scd="cd"
alias cdls='cd .. && ls'
alias cdl='cd .. && ls'
alias ..etc="cd /etc"
alias 'cd-1'="cd ${OLDPWD}"
alias cdold="cd ${OLDPWD}"
alias cdtemp="${TEMPDIR}"
alias cdt="cd ${TEMPDIR}"
alias cd-temp="${TEMPDIR}"


### [=]==================================[=]
### [~]........... CAT/BAT
### [=]==================================[=]
if [[ "${commands[bat]}" ]]; then
  alias cat='bat --style=header,grid'  ; alias bat="bat --style=header,grid"; alias catf="bat --style=full"
  alias ca='bat'     ; alias cst="cat" ; alias scat="cat"
  alias car="cat"    ; alias cay="cat" ; alias cau="cat"
  alias cau="cat"    ; alias ca="bat"  ; alias catp="bat -p"

  alias bat-preview-themes='bat --list-themes | fzf --preview="bat --theme={} --language=sh --color=always $HOME/*"'
  function bat_preview_languages(){
    local viewfile
    viewfile="${1}"
    [[ -z "${viewfile}" ]] && viewfile="${HOME}/*"
    bat --list-languages        \
      | sort --reverse          \
      | awk -F ":" '{print $2}' \
      | awk -F "," '{print $1}' \
      | awk '{print $1}'        \
      | fzf --preview-window=right,80% --preview="bat --language={} --color=always ${viewfile}"
  }; alias bat-preview-languages="bat_preview_languages"
fi

function ca(){
  local catthis
  catthis="${1}"
  if   [[ -z "${catthis}" ]]; then clear && return 0 || return 1; fi
  if   [[ -d "${catthis}" ]]; then cd  "${catthis}"  || printf "\e[0;38;5;196mFailed to cd to %s\e[0m\n]]" "${catthis}" || return 1 && return 0
  elif [[ -f "${catthis}" ]]; then cat "${catthis}"  || return 1 && return 0
  else return 0
  fi
}


### [=]==================================[=]
### [~]............ LS
### [=]==================================[=]
alias ls='ls --color=always'
alias l='ls -A -1'; alias ll='ls -A -l'
alias LS="ls"     ; alias sl="ls"
alias ks="ls"     ; alias sls="ls"
alias lsls='command ls'
alias octal="stat --dereference --printf='\e[0;38;5;190m%a \e[0;38;5;87m%A \e[0;38;5;196m%T \e[0;1;38;5;46m%n\e[0m\n'"

## lsof
alias list-open-files='lsof'
alias list-open-files-repeat='lsof -r "m[~]========================[ Time: %T ]========================[~]"'
alias list-open-internet-files='lsof -i -U'

### [=]==================================[=]
### [~]............ RM
### [=]==================================[=]
alias rm="rm --verbose --preserve-root=all --interactive"
alias rrm="rm"
alias rmf='rm --force'
alias rmbsd="rm -v -I"
alias rm-license="find . -type f -name 'LICENSE' | xargs -I{} rm --interactive=once --preserve-root --recursive --verbose {}"


### [=]==================================[=]
### [~]............ MKDIR
### [=]==================================[=]
alias mkdir='mkdir -p -v'

### [=]==================================[=]
### [~]............ MV
### [=]==================================[=]
alias mv="mv --verbose --interactive"
alias mmv="mv -v"

### [=]==================================[=]
### [~]............ CP
### [=]==================================[=]
alias cp='cp --interactive --verbose'
alias cpr='rsync --archive --human-readable --info=progress2'
alias cprvvv='rsync --archive --human-readable --info=ALL'
alias cpMISC='rsync --archive --human-readable --info=MISC'
alias cpREMOVED='rsync --archive --human-readable --info=REMOVE'
alias cpSKIPPED='rsync --archive --human-readable --info=SKIP'
alias cpSTAT='rsync --archive --human-readable --info=STATS'

### [=]==================================[=]
### [~]............ CLEAR
### [=]==================================[=]
alias cl="clear"
alias cls='clear'
alias cler='clear'
alias cleart='clear'
alias c="clear"

### [=]==================================[=]
### [~]......... Package Managers
### [=]==================================[=]
if [[  -n "${DISTRO}" ]] {
  if [[ ${DISTRO} == "Arch"     ]] \
  || [[ ${DISTRO} == "Parabola" ]] \
  || [[ ${DISTRO} == "Artix"    ]] \
  || [[ ${DISTRO} == "Manjaro"  ]] \
  && [[ "${commands[pacman]}"   ]]; then
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
        fi

  elif [[ ${DISTRO} == "Debian"   ]] \
    || [[ ${DISTRO} == "Raspbian" ]] \
    || [[ ${DISTRO} == "Rpios"    ]] \
    || [[ ${DISTRO} == "Ubuntu"   ]]; then
        alias apts="apt search"
        alias apti="apt install"
        alias aptupdate="printf '\n\n\e[0;38;5;46mUPDATING PACKAGE CACHE\e[0m\n\n'; apt-get update -y"
        alias aptupgrade="printf '\n\n\e[0;38;5;46mUPGRADING PACKAGES\e[0m\n\n' ; apt-get upgrade -y"
        alias update="aptupgrade"
        alias upgrade="aptupgrade"
        alias updgrate="aptupdate && aptupgrade"
        alias aptupdgrate="aptupdate && aptupgrade"

  elif [[ ${DISTRO} == "Android" ]] \
    || [[ ${DISTRO} == "Termux"  ]] \
    && [[ "${commands[pkg]}"     ]]; then
        alias pkgi="pkg install"
        alias pkgs="pkg search"
        alias pkgu="pkg upgrade"

        if [[ "${commands[pkgfzf]}" ]] \
          && [[ "${commands[fzf]}"  ]]; then
          alias pkgf="pkgfzf fzf"
        fi

  elif [[ ${DISTRO} == "Gentoo" ]] \
    && [[ "${commands[emerge]}" ]]; then
    printf ""
  fi
}

### [=]==================================[=]
### [~]............ Markdown
### [=]==================================[=]
alias markdown-cli-renderer="glow"
alias markdown2HTML="markdown_py --output_format=html"
alias ekitty="$EDITOR $XDG_CONFIG_HOME/kitty/kitty.conf"
alias youtube-fzf="ytfzf"
alias ytfzf-dl="cd $YOUTUBEDOWNLOADSDIR ; ytfzf --download --choose-from-history -f --preview-side=bottom --show-thumbnails ; cd $OLDPWD"
alias youtube-fzf-dl="ytfzf-dl"
alias stock-watch="watch --color -n 1 stonks -t icon -i 1m -W 80"
alias stock-sheet="mop"

### [=]==================================[=]
### [~]....... Template Generators
### [=]==================================[=]
alias bash-templates-cd="cd $BASHTEMPLATESDIR"
alias bash-template-here="template -x -f bash -n $1"
alias bash-dev-env="kitty --session $XDG_CONFIG_HOME/kitty/startup-sessions/kitty-startup-bash-dev &"

### [=]==================================[=]
### [~]............ AWESOMEWM
### [=]==================================[=]
if [[ "${commands[awesome]}" ]] {
  alias eawesome="$EDITOR ${XDG_CONFIG_HOME}/awesome/rc.lua"
  alias awesome-quit="awesome-client 'awesome.quit()'"
  alias awesome-restart="awesome-client 'awesome.restart()'"
  alias cdawesome="cd ${XDG_CONFIG_HOME}/awesome || printf \"\e[0;38;5;196mCANNOT CD TO THERE\e[0m\n\""
  alias awesome-check="awesome --check"
  alias check-awesome="awesome --check"
  alias awesomewm-xephyr-emulate="Xephyr :5 -screen 1280x720 -resizeable & sleep 1 ; DISPLAY=:5 awesome"

  alias start-compositor="xcompmgr &"
  alias list-windows='wmctrl -l -p -G -x'
  alias list-desktops='wmctrl -d'
  alias list-desktop-applications="ls /usr/share/applications | awk -F '.desktop' ' { print $1}' -"
}

### [=]==================================[=]
### [~]............ VIM/NEOVIM
### [=]==================================[=]
# alias vim='nvim'            ## Replace Vim with Neo-Vim
alias vim-split='nvim -O2'  ## Open 2 vertical windows in nvim

### [=]==================================[=]
### [~]............ Permissions
### [=]==================================[=]
alias chmod='chmod --preserve-root'
alias chmodex='chmod --preserve-root u+x --verbose'
alias chmodexr='chmod --preserve-root u+x --verbose'
alias chx='chmod --preserve-root u+x --verbose'
alias chown-$USER="sudo chown --verbose --preserve-root $USER:$USER"
alias chgrp='chgrp --verbose'
alias chgrpR='chgrp --verbose --recursive'
alias check-file-permissions="stat ${*} --printf=\"\n%n\n%F\n%A\n%a\n\""

### [=]==================================[=]
### [~]............ RCLONE
### [=]==================================[=]
if [[ "${commands[rclone]}" ]] {
  alias rclone-backup-scripts-to-onedrive="rclone copyto $HOME/scripts sk8:scripts --ignore-existing -v --progress --progress-terminal-title --check-first"
  alias rclone-sync-scripts='rclone sync "$HOME/scripts" "sk8:scripts" --dry-run  --interactive --create-empty-src-dirs --progress --color'
  alias rclone-tree='rclone tree sk8: --color --level 5 --verbose'
  alias rclone-tree-all='rclone tree sk8: --color --verbose'
}

### [=]==================================[=]
### [~]......... PWD/REALPATH
### [=]==================================[=]
alias rp='realpath'
alias rp-pwd='rp --no-symlinks $(ls --group-dirs=first --classic)'
alias rp-all='rp-pwd .*'
alias realpath-all='echo -e "$(rp $(ls --color=never --icon=never  *))"'
alias rl="readlink"

### [=]==================================[=]
### [~]............ GPU
### [=]==================================[=]
## View display/gpu events in xorg log file ##
alias xorglog='cat /var/log/Xorg.0.log | grep -vi input | grep -vi keyboard | grep -vi logitech | less'

### [=]==================================[=]
### [~]............ Neofetch
### [=]==================================[=]
alias nf='neofetch'

### [=]==================================[=]
### [~]............ File Explorers
### [=]==================================[=]
alias fe='pcmanfm &'

### [=]==================================[=]
### [~]............ Lynx
### [=]==================================[=]
# alias lynx="lynx -session=$LYNX_SESSION"

### [=]==================================[=]
### [~]............ GIT
### [=]==================================[=]
if [[ "${commands[gh]}" ]] {
  alias ghs-shell='printf "\e[0;1;3;4;38;5;33mSearch GitHub For Shell\e[0m\n" ; gh s -l shell'
  alias ghs-view='printf "\e[0;1;3;4;38;5;33mSearch GitHub, Press <Enter> to view README\e[0m\n" ; gh repo view $(gh s) | g -'
  alias ghc='git clone --no-checkout --verbose'
}

if [[ "${commands[git]}" ]] {
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
  [[ "${commands[git]}" ]] && alias git-lazy="lazygit"
}








### [=]==================================[=]
### [~]............ Clipboard
### [=]==================================[=]
alias clip='xclip -selection clipboard -rmlastnl'
alias copy='xclip -selection clipboard -rmlastnl'
alias xcopy='xclip -selection clipboard -rmlastnl'
alias pwd-to-clip='pwd | xclip -selection clipboard'
alias pwd2clip='pwd | xclip -selection clipboard'

### [=]==================================[=]
### [~]............ Screen Capturing
### [=]==================================[=]
alias colorpicker='gpick'
alias colorpicker-tui='rgb-tui'
alias colortop='vtop'
### Window Spy
alias window-spy='xprop'
### Reset Wallpaper
alias wp='nitrogen --restore'

### [=]==================================[=]
### [~]............ NMAP
### [=]==================================[=]
if [[ -n "${commands[nmap]}" ]] ; then
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
  for nmapaliasname nmapaliasvalue in ${(kv)nmapaliases}; do
    alias "${nmapaliasname}"="${nmapaliasvalue}"
  done; unset nmapaliasname nmapaliasvalue

  #typeset -A nmapaliasesdesc
  #nmapaliasesdesc[nmapaliases[nmap-fast]="nmap -F -T5 --version-light --top-ports 300"]="fast scan of the top 300 ports with fastest speed"
  #nmapaliasesdesc[nmapaliases[nmap-ping-scan]="nmap -n -sP"]="Nmap ping scan"

  [[ "${commands[nmapAutomator.sh]}" || "${commands[nmapAutomator]}" ]] && alias nmapAutomatorAll="sudo nmapAutomator.sh --type All --output ${NMAPSCAN:-${PWD}} --host"
fi

### [=]==================================[=]
### [~]............ MetaSploit
### [=]==================================[=]
[[ "${commands[rsf]}" ]] && alias -s routersploit='rsf'
[[ "${commands[metasploit]}" ]] && alias msf='sudo msfconsole'

### [=]==================================[=]
### [~]............ Raspberry Pi
### [=]==================================[=]
[[ "${commands[rpi-imager]}" ]] && alias rpi-imager='sudo rpi-imager &'
[[ "${commands[rpi-imager]}" ]] && alias raspberrypi-imager='sudo rpi-imager &'
[[ "${commands[rpi-imager]}" ]] && alias raspberry-imager='sudo rpi-imager &'

### [=]==================================[=]
### [~]............ CAD / 3D Printing
### [=]==================================[=]
[[ "${commands[prusa-slicer]}" ]] && alias slic3r='prusa-slicer &'

### [=]==================================[=]
### [~]............. DOCKER
### [=]==================================[=]
if [[ "${commands[docker]}" ]] {
  alias docker-run-interactive="docker run --interactive --tty"
  alias docker-lazy='lazydocker'
  alias dockers="docker search --no-trunc"

  ##=========================##
  ## aws-cli docker image    ##
  ##                         ##
  ##  Run aws-cli in docker  ##
  ##                         ##===============================================================##
  ###[Share host files, credentials, environment variables, and configuration]##              ##
  ##                                                                                          ##
  ##    $ docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli command                     ##
  ##                                                                                          ##
  ##    $ docker run --rm -it -v ~/.aws:/root/.aws -e ENVVAR_NAME amazon/aws-cli s3 ls        ##
  ##                                                                                          ##
  ###[More Info](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-docker.html): ##
  ##==========================================================================================##
  alias aws-docker="docker run --rm -it amazon/aws-cli"
}


alias figlet-preview="figlet-gallery"
alias list--proprietary-software='absolutely-proprietary'
alias ram-usage="free -th"

alias disk-usage="dfrs --human-readable --total --color=always --columns=filesystem,bar,used_percentage,used,available_percentage,available,capacity,type,mounted_on 2>/dev/null"
alias disk-usage-2="dfc 2>/dev/null"

### [=]==================================[=]
### [~]............ WATCH
### [=]==================================[=]
export WATCH_INTERVAL WATCH_FAST_INTERVAL; WATCH_INTERVAL=1; WATCH_FAST_INTERVAL=0.1
alias watch-disk-usage="watch -c --interval 0.5 --no-title --differences dfrs --human-readable --total --color=always --columns=filesystem,bar,used_percentage,used,available_percentage,available,capacity,type,mounted_on"
alias watch-disk-usage-2="watch -c --interval 0.5 --no-title --differences dfc -c always"
alias watch="watch --precise --interval $WATCH_INTERVAL"
alias watch-fast="watch --precise --interval $WATCH_FAST_INTERVAL"
alias watch="watch -n 0.1 --color"

alias http-server='python -m http.server'
alias xterm='xterm -fg white -bg black -cr red -bd blue'

### [=]==================================[=]
### [~]............ SSH
### [=]==================================[=]
alias ssh-showpublickey="$PAGER ${SSH_DIR:-~/.ssh}/*.pub"
alias tmux-ssh="tmux new-session ssh"

### [=]==================================[=]
### [~]............ VNC
### [=]==================================[=]
alias vncviewer-custom='vncviewer --DotWhenNoCursor --UpdateScreenshot --PasswordStoreOffer --AutoReconnect --FullScreen --SecurityNotificationTimeout=0 --ToolbarIconSize=16 --SessionRecordAllowUserControl -FullScreen -AutoReconnect --KeepAliveResponseTimeout=30 --KeepAliveInterval=30 --NotificationPos=2 &'
alias vnc-server-start="x11vnc -nevershared -forever -usepw &"

### [=]==================================[=]
### [~]............ MAN
### [=]==================================[=]
alias m="man"
alias zshall="man zshall"
alias man-bat='man --pager="bat --language=sh --plain --color=never" xkeyboard-config '
alias man-bat-global-apropos='man --pager="bat --language=sh" --global-apropos'
alias man-search='man --all --wildcard'
alias man-search-name='man --all --names-only --regex'

### [=]==================================[=]
### [~]............ CRYPTO
### [=]==================================[=]
### Monero
alias monero-cli="monero-wallet-cli"
alias monero-gui="monero-wallet-gui"
alias psfzf="ps -ef | fzf --bind 'ctrl-r:reload(ps -ef)' --header 'Press (CTRL-R) to reload' --header-lines=1"

### [=]==================================[=]
### [~]........... FIREJAIL
### [=]==================================[=]
## Firejail
if [[ "${commands[firejail]}" ]] {
  alias fjfx='firejail firefox --private'
}

### [=]==================================[=]
### [~]............ Networking
### [=]==================================[=]
alias get-arp-cache-table='lnstat --subject 2 --json'
alias networkmanager-tui='nmtui'
alias networkmanager-cli='nmcli'
alias external-ip='curl ifconfig.me ; printf "\n"'
alias duhs='du -h --summarize'


### [=]==================================[=]
### [~]............ CHMOD
### [=]==================================[=]
alias chmod-exec-1="find $1 -maxdepth 1 -type $2 -exec chmod --verbose $3 {} \;"
alias chmod-exec-x="find $1 -maxdepth $2 -type $3 -exec chmod --verbose $4 {} \;"
alias chmod-exec="find $1 -type $2 -exec chmod --verbose $3 {} \;"
alias chmod-files-etc-1="find /etc -maxdepth 1 -type f -exec chmod --verbose 644 {} \;"
alias chmod-permissions-dir-etc-1="find /etc -maxdepth 1 -type d -exec chmod --verbose 644 {} \;"
alias chmod-ref-recur="chmod --preserve-root --verbose --recursive --reference $1 $2"
alias chmod-ref="chmod --preserve-root --verbose --reference $1 $2"
alias chmod-dir-775-1="find $1 -maxdepth 1 -type d -exec chmod --verbose 775 {} \;"
alias chmod-files-644-1="find $1 -maxdepth 1 -type f -exec chmod --verbose 644 {} \;"

alias lastlogin="loginctl"

### [=]==================================[=]
### [~]............ ETCKEEPER
### [=]==================================[=]
if [[ "${commands[etckeeper]}" ]] {
  alias etckeeper="sudo etckeeper"
  alias etckeeper-diff="sudo etckeeper vcs status -u"
  alias etckeeper-diff="etckeeper vcs log --unified --color-words | diff-so-fancy --colors | less --tabs=2 -RFX"
  alias etckeeper-modified="etckeeper vcs ls-files --modified"
  alias etckeeper-add="etckeeper vcs add /etc/* --verbose"
  alias etckeeper-add-interactive="etckeeper vcs add /etc/* --verbose --interactive"
  alias etckeeper-commit="echo -e \"\e[38;5;201metckeeper:\e[38;5;27m\tCommiting Changes ...\e[0m\" && etckeeper commit $COMMITMSG"
}


alias iptables-watch="sudo watch --differences --differences --color --interval 1 iptables -vnL --line-numbers"
alias ping-graph="gping -4 --watch-interval 0.1"

alias virsh-list="virsh list --all"
alias virt-manager-list="virsh list --all"
alias kill-firefox="kill \$(pidof firefox)"
alias kill-compositor="kill \$(pidof xcompmgr)"
alias tcpdump-OpenWRT-termshark="sudo --prompt='Enter password for tcpdump: ' clear && ssh root@192.168.69.1 tcpdump -i any -U -s0 -w - 'not port 22' | sudo termshark -i -"
alias tcpdump-OpenWRT-tshark="sudo --prompt='Enter password for tcpdump: ' clear && ssh root@192.168.69.1 tcpdump -i any -U -s0 -w - 'not port 22' | sudo tshark --color -i -"
alias gh-list-my-repos="gh s -E -u @me"
alias mkdircd="mkcd"
alias cdmkdir="mkcd"
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias pping="prettyping"
alias iptables-watch="sudo watch --differences --differences --color --interval 1 iptables -vnL --line-numbers"
alias html2md="html2text --mark-code --unicode-snob --body-width=0 --open-quote '**' --close-quote '**' --reference-links --pad-tables --images-to-alt --no-wrap-links --hide-strikethrough --decode-errors=ignore"
alias difff="diff --color=always --minimal --suppress-common-lines --side-by-side --ignore-all-space"
alias kernel-command-line-parameters="cat /proc/cmdline"
alias count='find . -type f | wc -l'
alias wget="wget --hsts-file "${WGETHSTS:-${HOME}/.cache/.wget-hsts}

### [=]==================================[=]
### [~]............ POWERSHELL
### [=]==================================[=]
[[ -n "${commands[pwsh]}" ]] && alias powershell="pwsh" && alias cdp="cd ${PDOTDIR} || printf 'CANNOT MOVE TO %s' ${PDOTDIR}"


alias cdwww="cd /var/www/connerwill.com"
alias git-url="git config --local --get remote.origin.url"
