#shellcheck disable=2148,2139,2059

alias e="$EDITOR"
alias ez="exec ${SHELL}"
alias exec-zsh='. ${ZDOTDIR}/exec-zsh.zsh'
alias ezsh="${EDITOR:-vim} ${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"

alias capslock-escape-keyboard="setxkbmap -layout us -variant ,qwerty -option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape' ; xset r rate 200 30      ; printf 'Increased typing speed!\nCapsLock should now be the escape key\t\e[0;1;38;5;201m :) \e[0m\n'"
alias swap-capslock-escape-keyboard="setxkbmap -layout us -variant ,qwerty -option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape' ; xset r rate 175 30 ; printf 'Increased typing speed!\nCapsLock should now be the escape key\t\e[0;1;38;5;201m :) \e[0m\n'"
alias type-clipboard="xclip -selection clipboard -out | tr \\n \\r | xdotool selectwindow windowfocus type --clearmodifiers --delay 25 --window %@ --file -"

### [=]==================================[=]
### [~]............ cd
### [=]==================================[=]
alias ....="cd ../.."   ; alias ../="cd /"
alias ..='cd ..'        ; alias ...='cd ../..'
alias ....='cd ../../..'; alias .....='cd ../../../..'
alias cd..='cd ..'      ; alias cd-1="cd $OLDPWD"
alias 'c d'='cd'        ; alias 'ls cd'='cd'
alias ccd='cd'          ; alias scd="cd"
alias cdls='cd .. && ls'; alias cdl='cd .. && ls'
alias ..etc="cd /etc"
alias home='cd $HOME ; ls ; pwd'
alias cdhome='cd $HOME ; ls ; pwd'
alias cdhometemp='cd $HOME/Temporary ; ls ; pwd'
alias cdold="cd $OLDPWD"
alias cdtemp="$TEMPDIR"
alias cdt="$TEMPDIR"
alias cd-temp="$TEMPDIR"



alias zshall="man zshall"

### [=]==================================[=]
### [~]............ cat
### [=]==================================[=]
if [[ "${commands[exa]}" ]]; then
  alias catp="bat --plain"            ; alias ccat="bat --style=full"
  alias catf="bat --style=full"       ; alias ca="bat --style=header,grid --plain *"
  alias scat="cat"                    ; alias car="cat"
  alias cat='bat --style=header,grid' ; alias ca='bat --style=header,grid *'
  alias bat-preview-languages="bat_preview_languages"
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
  }
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
### [~]............ ls
### [=]==================================[=]
alias ls='ls --color=always'
alias l='ls -A -1'; alias ll='ls -A -l'
alias LS="ls"     ; alias sl="ls"
alias ks="ls"     ; alias sls="ls"
alias lsls='command ls'
alias octal="stat --dereference --printf='\e[0;38;5;190m%a \e[0;38;5;87m%A \e[0;38;5;196m%T \e[0;1;38;5;46m%n\e[0m\n'"

### exa
if [[ "${commands[exa]}" ]]; then
  alias exa='exa --color always --icons'
  alias l1='exa --oneline --all --header'
  alias lll='exa --long --all --header'
  alias ls-l="exa --sort=type --long --all"
  alias ls-ll="exa --sort=type --tree --recurse --long --all"
fi

if [[ "${commands[exa]}" ]]; then
  alias 'cd ls'='lsd --almost-all --long'
  alias ks='lsd --color always --icon always'
  alias l='lsd --color always --no-symlink --oneline --almost-all ; echo -e "▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂\n"   '                                                                     ## List All On One Line
  alias la='lsd --color always --icon always --almost-all'
  alias ll='lsd --color always --icon always --oneline --long --almost-all'                                                                                                   ## List All On One Line Sort By Extension
  alias lla='lsd --all --long --total-size --sizesort --reverse --color always --icon always'
  alias llls="printf \"\e[0;38;5;87mLoading\e[0;38;5;201m...\e[0m\n\"; lsd --long --sort=size --date=+'%Y-%m-%d.%H%M%S' --permission=octal --no-symlink --color=always --total-size --almost-all --reverse"
  alias lls="printf \"\e[0;38;5;93mLoading\e[0;38;5;201m...\e[0m\n\"; lsd --long --sort=size --date=+'%Y-%m-%d.%H%M%S' --color=always --total-size --almost-all --reverse"
  alias ls='lsd --color always --icon always'
  alias lsa='command lsd --color always --icon always --almost-all .*(.)'                                                                                                     ## List Only Hidden Files
  alias lsl='lsd --color always --icon always --oneline --long --almost-all --sizesort --human-readable --reverse'                                                            ## List All On One Line Sort By Size Long List Reversed
  alias lss='lsd --color always --icon always --oneline --long --almost-all --sizesort --human-readable --reverse'                                                            ## List All On One Line Sort By Size Long List Reversed
  alias lst="lsd --color always --icon always --oneline --long --almost-all --timesort --human-readable --reverse" # List All On One Line Recurse Sort By Modification Time Long List Reversed
  alias lstree="lsd --color always --icon always --almost-all --tree --total-size --human-readable $1 2>/dev/null"                                                            ## List All On One Line Recurse Sort By Modification Time Long List Reversed
  alias s='lsd --color always --icon always'
fi

## lsof
alias list-open-files='lsof'
alias list-open-files-repeat='lsof -r "m[~]========================[ Time: %T ]========================[~]"'
alias list-open-internet-files='lsof -i -U'

### [=]==================================[=]
### [~]............ rm
### [=]==================================[=]
# alias rm="rm --verbose --preserve-root=all --interactive=once"
alias rm="rm --verbose --preserve-root=all --interactive"
alias rrm="rm"
alias rmf='rm --force'
alias rmbsd="rm -v -I"
alias rm-license="find . -type f -name 'LICENSE' | xargs -I{} rm --interactive=once --preserve-root --recursive --verbose {}"


### [=]==================================[=]
### [~]............ mkdir
### [=]==================================[=]
alias mkdir='mkdir -p -v'

### [=]==================================[=]
### [~]............ mv
### [=]==================================[=]
alias mv="mv --verbose --interactive"
alias mmv="mv -v"

### [=]==================================[=]
### [~]............ cp
### [=]==================================[=]
alias cp='cp --interactive --verbose'
alias ccp="cp -v"
alias cpr='rsync --archive --human-readable --info=progress2'
alias cprvvv='rsync --archive --human-readable --info=ALL'
alias cpMISC='rsync --archive --human-readable --info=MISC'
alias cpREMOVED='rsync --archive --human-readable --info=REMOVE'
alias cpSKIPPED='rsync --archive --human-readable --info=SKIP'
alias cpSTAT='rsync --archive --human-readable --info=STATS'

### [=]==================================[=]
### [~]............ clear
### [=]==================================[=]
alias cl="clear"
alias cls='clear && ls'
alias cler='clear'
alias cleart='clear'

### [=]==================================[=]
### [~]............ Package Managers
### [=]==================================[=]
## If DISTRO is defined
if [[ -n "${DISTRO}" ]]; then
  ## If distro is arch,artix,parabola,manjaro; load pacman aliases
  if [[ ${DISTRO} == "Arch" ]] || [[ ${DISTRO} == "Parabola" ]] || [[ ${DISTRO} == "Artix" ]] || [[ ${DISTRO} == "Manjaro" ]]; then
    ## If yay is found
    if command -v pacman >/dev/null 2>&1; then
      alias pacman='pacman --color always'
      alias pacs='pacman -Ss --color=always'
      alias pacsi='pacman -Sii --color always --verbose'
      alias pacinstall='sudo pacman -S --color always --verbose'
      alias paci='sudo pacman -S --color always --verbose'
      alias paclist-installed='sudo pacman -Q --color always'
      alias update='sudo pacman -Syuv' # Upgrade all system packages.
    fi
    ## If yay is found
    if command -v yay >/dev/null 2>&1; then
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
      alias yayi='yay -S --color always --verbose'
      alias yaylist='yay -Q --color always'
    fi
  ## If distro is debian,raspbian,ubuntu; load apt aliases
  elif [[ ${DISTRO} == "Debian" ]] || [[ ${DISTRO} == "Raspbian" ]] || [[ ${DISTRO} == "Rpios" ]] || [[ ${DISTRO} == "Ubuntu" ]]; then
    alias apts="apt search"
    alias apti="apt install"
    alias update="printf \"\n\n\e[0;38;5;46mUPDATING PACKAGE CACHE\e[0m\n\n\"; apt-get update -y"
    alias upgrade="printf \"\n\n\e[0;38;5;46mUPGRADING PACKAGES\e[0m\n\n\"; apt-get upgrade -y"
    alias updgrate="printf \"\n\n\e[0;38;5;46mUPDATING PACKAGE CACHE\e[0m\n\n\"; apt-get update -y && printf \"\n\n\e[0;38;5;46mUPGRADING PACKAGES\e[0m\n\n\" && apt-get full-upgrade -y"
  ## If distro is gentoo
  elif [[ ${DISTRO} == "Gentoo" ]]; then
    printf ""
  fi
fi

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
alias bash-template-argbash="$HOME/scripts/bash/development/snippets/templates-bash/template-generators-bash/generate-template-argbash/generate-template-argbash.sh"
alias bash-snippet-copyANSIterminalcodes="cat $SCRIPTS/bash/development/snippets/text-displaying_printing/define-terminal-codes.sh | xclip && echo -e 'Copied \e[1m ANSI Terminal Codes snippet \e[0m' to clipboard"
alias bash-snippet-copyElevatePermissions="cat $SCRIPTS/bash/development/snippets/elevate-permissions/elevate-permissions.sh | xclip && echo -e 'Copied \e[1m Prompt to Elevate Permissions snippet \e[0m' to clipboard"
alias bash-snippet-copyReadExamples="cat $SCRIPTS/bash/development/snippets/read/read--wait-for-key-press.sh | xclip && echo -e 'Copied \e[1m Read Examples Snippet\e[0m' to clipboard"
alias bash-snippet-copySplitLinesInFileToArray="cat $SCRIPTS/bash/development/snippets/split-lines-in-file-to-array/split-lines-in-file-to-array.sh | xclip && echo -e 'Copied \e[1m Splitt lines in file to arrays Snippet\e[0m' to clipboard"
alias bash-dev-env="kitty --session $XDG_CONFIG_HOME/kitty/startup-sessions/kitty-startup-bash-dev &"

### [=]==================================[=]
### [~]............ AwesomeWM
### [=]==================================[=]
alias eawesome='$EDITOR ~/.config/awesome/rc.lua'
alias awesome-quit="awesome-client 'awesome.quit()'"
alias awesome-restart="awesome-client 'awesome.restart()'"
alias bawesome='bash $HOME/.config/awesome/awesome-backups/awesome-backup-scripts/awesome-config-backup.sh'
alias cdawesome='cd ~/.config/awesome'
alias awesome-check='awesome --check'
alias check-awesome='awesome --check'
alias awesomeh='xdg-open https://awesomewm.org/apidoc/index.html'
alias awesomeh-easy='xdg-open https://awesomewm.org/apidoc/documentation/07-my-first-awesome.md.html'

### [=]==================================[=]
### [~]............ Vim/Neo-Vim
### [=]==================================[=]
alias vim='nvim'            ## Replace Vim with Neo-Vim
alias vim-split='nvim -O2'  ## Open 2 vertical windows in nvim

### [=]==================================[=]
### [~]............ Permissions
### [=]==================================[=]
alias chmod='chmod --preserve-root'
alias chmodex='chmod --preserve-root u+x --verbose'
alias chmodexr='chmod --preserve-root u+x --verbose'
alias chx='chmod --preserve-root u+x --verbose'
alias chown-dampsock="sudo chown --verbose --preserve-root dampsock:dampsock"
alias chown-dampsock-recursive="sudo chown --verbose --preserve-root --recursive dampsock:dampsock"
alias chgrp='chgrp --verbose'
alias chgrpR='chgrp --verbose --recursive'
alias check-file-permissions="stat ${*} --printf=\"\n%n\n%F\n%A\n%a\n\""

### [=]==================================[=]
### [~]............ rclone
### [=]==================================[=]
alias rclone-backup-scripts-to-onedrive="rclone copyto $HOME/scripts sk8:scripts --ignore-existing -v --progress --progress-terminal-title --check-first"
alias rclone-sync-scripts='rclone sync "$HOME/scripts" "sk8:scripts" --dry-run  --interactive --create-empty-src-dirs --progress --color'
alias rclone-tree='rclone tree sk8: --color --level 5 --verbose'
alias rclone-tree-all='rclone tree sk8: --color --verbose'

### [=]==================================[=]
### [~]............ pwd/realpath
### [=]==================================[=]
alias rp='realpath'
alias rp-pwd='rp --no-symlinks $(ls --group-dirs=first --classic)'
alias rp-all='rp-pwd .*'
alias realpath-all='echo -e "$(rp $(ls --color=never --icon=never  *))"'

### [=]==================================[=]
### [~]............ sudo
### [=]==================================[=]
alias sudp='sudo'
alias "sud["='sudo'

### [=]==================================[=]
### [~]............ gpu
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
alias lynx="lynx -session=$LYNX_SESSION"

### [=]==================================[=]
### [~]............ git
### [=]==================================[=]
alias gito='git-open'
alias git-get-url='git-open --print'
alias git-config-options='git config --list'
alias gh-fzf-search="gh fzrepo"
alias git-fzf-search="gh fzrepo"
alias gh-search="gh search"
alias git-search="gh search"
alias gh-fuzzy="git-fuzzy"
alias gitignore-generator="gibo"
alias ghc='git clone --no-checkout --verbose'
alias gitc='git clone --no-checkout --verbose'
alias git-clone-nocheckout="git clone --no-checkout --verbose"
alias git-cloner='githubcloner'
alias git-cloneall='cloneall'
alias gitignore-templates='gibo'
alias git-lazy="lazygit"
alias git-commit-custom='git commit --gpg-sign="3AED4B68E6FD33BC" --message='
alias table-of-contents="gh-md-toc"
alias git-log-pretty="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias ghs='printf "\e[0;1;3;4;38;5;33mSearch GitHub\e[0m\n" ; gh s'
alias ghs-shell='printf "\e[0;1;3;4;38;5;33mSearch GitHub For Shell\e[0m\n" ; gh s -l shell'
alias ghs-view='printf "\e[0;1;3;4;38;5;33mSearch GitHub, Press <Enter> to view README\e[0m\n" ; gh repo view $(gh s) | g -'

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
alias screencap="scrot '%Y-%m-%d_$wx$h_screencapture.png' --overwrite --select -e && 'mv $f ~/images/screencaptures/$f'"
alias sc="scrot '%Y-%m-%d_$wx$h_screencapture.png' --select -e 'mv $f $HOME/images/screencaptures/$f'"
alias scap="scrot '%Y-%m-%d_$wx$h_screencapture.png' --overwrite -e 'mv $f ~/images/screencaptures/'"
alias scrot="scrot '$HOME/pictures/screencaptures/%Y-%m-%d_%H%M%S_$wx$h_$a_Screenshot.png' --line style=dash,width=5 --select=hide --quality 100 -n \"-f '/usr/share/fonts/TTF/Inconsolata-ExtraBold.ttf/20' -x 5 -y 10 -c 0,0,0 -t '$USER $DATE'\" && echo -e \"\e[32mSaved Screenshot To Directory\e[33m:  \e[1m\e[33m'\e[3;4m\e[34m/home/dampsock/pictures/screencaptures/\e[0m\\e[33m'\e[0m\""
alias screenc="scrot '$HOME/pictures/screencaptures/%Y-%m-%d_%H%M%S_$wx$h_$a_Screenshot.png' --line style=dash,width=5 --select=hide --quality 100 -n \"-f '/usr/share/fonts/TTF/Inconsolata-ExtraBold.ttf/20' -x 5 -y 10 -c 0,0,0 -t '$USER $DATE'\" && echo -e \"\e[32mSaved Screenshot To Directory\e[33m:  \e[1m\e[33m'\e[3;4m\e[34m/home/dampsock/pictures/screencaptures/\e[0m\\e[33m'\e[0m\""

alias colorpicker='gpick'
## Icon Editor: ACYLS - https://github.com/worron/ACYLS ##
alias iconedit='python3 ~/.icons/ACYLS/scripts/run.py & '
alias colorpicker-tui='rgb-tui'
### Window Spy
alias window-spy='xprop'
### Reset Wallpaper
alias wp='nitrogen --restore'

### [=]==================================[=]
### [~]............ NMAP
### [=]==================================[=]
if [[ -n "${commands[nmap]}" ]] ; then
  alias nmap_open_ports="nmap --open"
  alias nmap_list_interfaces="nmap --iflist"
  alias nmap_slow="sudo nmap -sS -v -T1"
  alias nmap_fin="sudo nmap -sF -v"
  alias nmap_full="sudo nmap -sS -T4 -PE -PP -PS80,443 -PY -g 53 -A -p1-65535 -v"
  alias nmap_check_for_firewall="sudo nmap -sA -p1-65535 -v -T4"
  alias nmap_ping_through_firewall="nmap -PS -PA"
  alias nmap_fast="nmap -F -T5 --version-light --top-ports 300"
  alias nmap_detect_versions="sudo nmap -sV -p1-65535 -O --osscan-guess -T4 -Pn"
  alias nmap_check_for_vulns="nmap --script=vuln"
  alias nmap_full_udp="sudo nmap -sS -sU -T4 -A -v -PE -PS22,25,80 -PA21,23,80,443,3389 "
  alias nmap_traceroute="sudo nmap -sP -PE -PS22,25,80 -PA21,23,80,3389 -PU -PO --traceroute "
  alias nmap_full_with_scripts="sudo nmap -sS -sU -T4 -A -v -PE -PP -PS21,22,23,25,80,113,31339 -PA80,113,443,10042 -PO --script all "
  alias nmap_web_safe_osscan="sudo nmap -p 80,443 -O -v --osscan-guess --fuzzy "
  alias nmap_ping_scan="nmap -n -sP"
  alias nmap-vulscan="nmap -sV -vv --script=vulscan/vulscan.nse"
  alias nmapAutomator-scan-all="sudo nmapAutomator.sh --type All --output $NMAPSCAN --host"
  alias nmap-scan-list-hosts="nmap -vv -sL $1"
  alias nmap-scan-hosts-local="nmap -vv -sL 192.168.64.1/24"
  alias nmap-scan-local-script-scan='sudo nmap --traceroute -sV -sC -A --privileged -vv -oA "$NMAPSCANOUTPUTDIR/local-subnet/$DATE--nmap-scan--$IPGATEWAY-local-subnet" $IPGATEWAY/24'
  alias nmap-scan-external-ip-script-scan='sudo nmap --traceroute -sV -sC -A --privileged -vv -oA "$NMAPSCANOUTPUTDIR/external-ip/$DATE--nmap-scan--$(external-ip)-external-IP" $(external-ip)'
fi

### [=]==================================[=]
### [~]............ MetaSploit
### [=]==================================[=]
[[ "${commands[rsf]}" ]] && alias -s routersploit='rsf'
[[ "${commands[metasploit]}" ]] && alias msf='sudo msfconsole'

### [=]==================================[=]
### [~]............ Raspberry Pi
### [=]==================================[=]
alias rpi-imager='sudo rpi-imager &'
alias raspberrypi-imager='sudo rpi-imager &'
alias raspberry-imager='sudo rpi-imager &'

### [=]==================================[=]
### [~]............ CAD / 3D Printing
### [=]==================================[=]
alias slic3r='prusa-slicer &'

### [=]==================================[=]
### [~]............. DOCKER
### [=]==================================[=]



# alias docker-run-zsh='docker run -it archlinux sh -c "pacman -Syv --noconfirm zsh git vim && chsh --shell $(which zsh) && touch ~/.zshrc && echo "WyAtZiAiJEhPTUUvLmxvY2FsL3NoYXJlL3phcC96YXAuenNoIiBdICYmIHNvdXJjZSAiJEhPTUUvLmxvY2FsL3NoYXJlL3phcC96YXAuenNoIgoKZWNobyAtZSAiXG5cblxlWzA7MTszODs1OzIwMW1XQVpaWlpBUFBQUFxlWzBtXG5cbiIKCmFsaWFzIGxzPSJscyAtLWNvbG9yPWFsd2F5cyIKYWxpYXMgbD0ibHMgLS1jb2xvcj1hbHdheXMgLUEgLTEiCmFsaWFzIGxsPSJscyAtLWNvbG9yPWFsd2F5cyAtQSAtbCIKCiMgRXhhbXBsZSBpbnN0YWxsIHBsdWdpbnMKemFwcGx1ZyAienNoLXVzZXJzL3pzaC1hdXRvc3VnZ2VzdGlvbnMiCnphcHBsdWcgInpzaC11c2Vycy96c2gtc3ludGF4LWhpZ2hsaWdodGluZyIKemFwcGx1ZyAiaGxpc3NuZXIvenNoLWF1dG9wYWlyIgp6YXBwbHVnICJ6YXAtenNoL3ZpbSIKCiMgRXhhbXBsZSB0aGVtZQp6YXBwbHVnICJ6YXAtenNoL3phcC1wcm9tcHQiCgojIEV4YW1wbGUgaW5zdGFsbCBjb21wbGV0aW9uCnphcGNtcCAiZXNjL2NvbmRhLXpzaC1jb21wbGV0aW9uIiBmYWxzZQo=" | base64 -d >> ~/.zshrc && git clone https://github.com/zap-zsh/zap.git ~/zap && cd ~/zap && sh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh) && source ~/zap/zap.zsh && exec zsh; sleep 1; exec zsh# "'
alias docker-run-zsh='docker run -it archlinux sh -c "pacman -Syv --noconfirm zsh git vim && chsh --shell $(which zsh) && cd ~ && clear && curl -sL https://github.com/vincentbernat/zshrc/releases/download/latest/zsh-install.sh | sh && exec zsh; sleep 1; exec zsh"'
alias docker-run-interactive="docker run --interactive --tty"
alias docker-lazy='lazydocker'
alias dockers="docker search --no-trunc"

alias figlet-preview="figlet-gallery"
alias list--proprietary-software='absolutely-proprietary'
alias ram-usage="free -th"
alias all-the-tops="$SCRIPTS/bash/all-the-tops/all-the-tops.sh"
alias colortop='vtop'
alias disk-usage="dfrs --human-readable --total --color=always --columns=filesystem,bar,used_percentage,used,available_percentage,available,capacity,type,mounted_on 2>/dev/null"
alias disk-usage-2="dfc 2>/dev/null"

export WATCH_INTERVAL WATCH_FAST_INTERVAL; WATCH_INTERVAL=1; WATCH_FAST_INTERVAL=0.1
alias watch-disk-usage="watch -c --interval 0.5 --no-title --differences dfrs --human-readable --total --color=always --columns=filesystem,bar,used_percentage,used,available_percentage,available,capacity,type,mounted_on"
alias watch-disk-usage-2="watch -c --interval 0.5 --no-title --differences dfc -c always"
alias watch="watch --precise --interval $WATCH_INTERVAL"
alias watch-fast="watch --precise --interval $WATCH_FAST_INTERVAL"

alias http-server='python -m http.server'
alias xterm='xterm -fg white -bg black -cr red -bd blue'

### [=]==================================[=]
### [~]............ SSH
### [=]==================================[=]
alias ssh-audit='$HOME/.local/lib/python3.9/site-packages/ssh_audit/ssh_audit.py'
alias ssh-copypublickey='copysshkeypublic'
alias ssh-showpublickey='cat ~/.ssh/id_rsa.pub'
alias sshuttle-connerwill="sudo sshuttle --verbose --dns --remote connerwill.com 0.0.0.0/0"
alias sshuttle-bigchugus="sudo sshuttle --verbose --dns --remote bigchungus 0.0.0.0/0"
alias tmux-ssh="tmux new-session ssh"

### [=]==================================[=]
### [~]............ VNC
### [=]==================================[=]
alias vncviewer-custom='vncviewer --DotWhenNoCursor --UpdateScreenshot --PasswordStoreOffer --AutoReconnect --FullScreen --SecurityNotificationTimeout=0 --ToolbarIconSize=16 --SessionRecordAllowUserControl -FullScreen -AutoReconnect --KeepAliveResponseTimeout=30 --KeepAliveInterval=30 --NotificationPos=2 &'
alias vnc-server-start="x11vnc -nevershared -forever -usepw &"

### [=]==================================[=]
### [~]............ man
### [=]==================================[=]
alias m="man"
alias man-bat='man --pager="bat --language=sh --plain --color=never" xkeyboard-config '
alias man-bat-global-apropos='man --pager="bat --language=sh" --global-apropos'
alias man-search='man --all --wildcard'
alias man-search-name='man --all --names-only --regex'

### [=]==================================[=]
### [~]............ Crypto
### [=]==================================[=]
### Monero
alias monero-cli="monero-wallet-cli"
alias monero-gui="monero-wallet-gui"
alias psfzf="ps -ef | fzf --bind 'ctrl-r:reload(ps -ef)' --header 'Press (CTRL-R) to reload' --header-lines=1"

### [=]==================================[=]
### [~]........... FireJail
### [=]==================================[=]
## Firejail
alias fj='firejail'
alias ffps='firejail firefox --private'
alias firefoxj='firejail firefox --private'
alias ffoxjail='firejail firefox --private'
alias firejail-noprofile='firejail --noprofile'
alias fj-np='FIREJAILRUNNOPROFILE=$1 && clear && echo -e "${fg_red}-------------------${res_norm}\n${bg_red}${fg_black}${fg_bold}${fg_underline}Firejail No Profile\n${res_norm}${fg_red}-------------------${res_norm}\n" && firejail --quiet --noprofile $FIREJAILRUNNOPROFILE'

### [=]==================================[=]
### [~]............ Networking
### [=]==================================[=]
alias ifdown='bash $HOME/security/networking/localmachine-networking/disable-network-interface.sh'
alias ifup='bash $HOME/security/networking/localmachine-networking/enable-network-interface.sh'
alias nettog='bash $HOME/security/networking/localmachine-networking/toggle-net-int.sh'
alias get-arp-cache-table='lnstat --subject 2 --json'
alias networkmanager-tui='nmtui'
alias networkmanager-cli='nmcli'
alias external-ip='curl ifconfig.me ; printf "\n"'
alias duhs='du -h --summarize'
alias list-file-sizes='du -h --summarize *'
alias list-largefiles='du --all --max-depth=1 --human-readable | sort --human-numeric-sort -r'
alias list-windows='wmctrl -l -p -G -x'
alias list-desktops='wmctrl -d'
alias list-desktop-applications="ls /usr/share/applications | awk -F '.desktop' ' { print $1}' -"
alias ps-tree="pstree --long --color=age --show-pids --thread-names --ns-changes --ns-sort=time"
alias tree-ps='ps-tree'
alias pstree-long='ps-tree'
alias thingiverse-dl="$HOME/3D-CAD/3D-CAD-scripts/file-downloaders/thingiverse/thingiverse-dl/parse-thingi-url.sh $1"
alias thingi-dl="$HOME/3D-CAD/3D-CAD-scripts/file-downloaders/thingiverse/thingiverse-dl/parse-thingi-url.sh $1"
alias tdl="$HOME/3D-CAD/3D-CAD-scripts/file-downloaders/thingiverse/thingiverse-dl/parse-thingi-url.sh $1"
alias xterm='xterm -fg white -bg black &'
alias image2ascii="asciiview"
alias pixel-art-editor='pxltrm'

alias chmod-exec-1="find $1 -maxdepth 1 -type $2 -exec chmod --verbose $3 {} \;"
alias chmod-exec-x="find $1 -maxdepth $2 -type $3 -exec chmod --verbose $4 {} \;"
alias chmod-exec="find $1 -type $2 -exec chmod --verbose $3 {} \;"
alias chmod-files-etc-1="find /etc -maxdepth 1 -type f -exec chmod --verbose 644 {} \;"
alias chmod-permissions-dir-etc-1="find /etc -maxdepth 1 -type d -exec chmod --verbose 644 {} \;"
alias chmod-ref-recur="chmod --preserve-root --verbose --recursive --reference $1 $2"
alias chmod-ref="chmod --preserve-root --verbose --reference $1 $2"
alias chmod-dir-775-1="find $1 -maxdepth 1 -type d -exec chmod --verbose 775 {} \;"
alias chmod-files-644-1="find $1 -maxdepth 1 -type f -exec chmod --verbose 644 {} \;"
alias chmod-ref-dir="chmod --preserve-root --verbose --reference $etcbackup/$1 /etc/$1"

alias lastlogin="loginctl"

alias etckeeper="sudo etckeeper"
alias etckeeper-diff="sudo etckeeper vcs status -u"
alias etckeeper-diff="etckeeper vcs log --unified --color-words | diff-so-fancy --colors | less --tabs=2 -RFX"
alias etckeeper-modified="etckeeper vcs ls-files --modified"
alias etckeeper-add="etckeeper vcs add /etc/* --verbose"
alias etckeeper-add-interactive="etckeeper vcs add /etc/* --verbose --interactive"
alias etckeeper-commit="echo -e \"\e[38;5;201metckeeper:\e[38;5;27m\tCommiting Changes ...\e[0m\" && etckeeper commit $COMMITMSG"

alias list-zsh-keybindings="bindkey -L | bat --language=zsh --paging=always --style=plain --theme=Dracula"
alias iptables-watch="sudo watch --differences --differences --color --interval 1 iptables -vnL --line-numbers"
alias ping-graph="gping -4 --watch-interval 0.1"
alias start-compositor="xcompmgr &"
alias awesomewm-xephyr-emulate="Xephyr :5 -screen 1280x720 -resizeable & sleep 1 ; DISPLAY=:5 awesome"
alias virsh-list="virsh list --all"
alias virt-manager-list="virsh list --all"
alias kill-firefox="kill \$(pidof firefox)"
alias kill-compositor="kill \$(pidof xcompmgr)"
alias Hat.sh='echo "\t\tHat.sh\n\nSimple, fast, secure client-side file encryption\n\n" ;cd "$SCRIPTS/javascript/hat.sh" && npm run start || echo -e "\nFailed to start 'Hat.sh'\n\n      -----------------------------------\n      You Can visit the online version :)\n\n\t\thttps://hat.sh\n      -----------------------------------\n\n" ; cd $OLDPWD'
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

[[ -n "${commands[pwsh]}" ]] && alias powershell="pwsh"

alias git-url="git config --local --get remote.origin.url"
