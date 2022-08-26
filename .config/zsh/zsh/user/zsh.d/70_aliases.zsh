#shellcheck disable=2148,2139

alias ezsh="${EDITOR:-vim} ${ZDOTDIR:-${XDG_CONFIG_HOME}/zsh}"
alias e="$EDITOR"
#alias -s html='lynx'
#alias -s org='lynx'
#alias -s com='lynx'
alias capslock-escape-keyboard="setxkbmap -layout us -variant ,qwerty -option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape' ; xset r rate 200 30      ; printf 'Increased typing speed!\nCapsLock should now be the escape key\t\e[0;1;38;5;201m :) \e[0m\n'"
alias swap-capslock-escape-keyboard="setxkbmap -layout us -variant ,qwerty -option 'shift:both_capslock_cancel,altwin:menu_win,caps:escape' ; xset r rate 175 30 ; printf 'Increased typing speed!\nCapsLock should now be the escape key\t\e[0;1;38;5;201m :) \e[0m\n'"
### [=]==================================[=]
### [~]............ cd
### [=]==================================[=]
### Directory Navigation ###
alias cd..="cd .."
alias ..="cd .."
alias ....="cd .."
alias ..etc="cd /etc"
alias ../="cd /"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd..='cd ..'
alias cdls='cd .. && ls'
alias 'c d'='cd'
alias cdl='cd .. && ls'
alias ccd='cd'
alias 'ls cd'='cd'
alias home='cd $HOME ; ls ; pwd'
alias cdhome='cd $HOME ; ls ; pwd'
alias cdhometemp='cd $HOME/Temporary ; ls ; pwd'
alias cdold="cd $OLDPWD"
alias cdtemp="$TEMPDIR"
alias cdt="$TEMPDIR"
alias cd-temp="$TEMPDIR"
alias scd="cd"
alias zshall="man zshall"
### [=]==================================[=]
### [~]............ cat
### [=]==================================[=]
alias catp="bat --plain"
alias ccat="bat --style=full"
alias catf="bat --style=full"
alias ca="bat --style=header,grid --plain *"
alias scat="cat"
alias car="cat"
alias cat='bat --style=header,grid'
alias ca='bat --style=header,grid *'
function bat_preview_languages(){
    local batlangsdirt batlangs viewfile
    viewfile="$1"
    [[ -z "$viewfile" ]] && local viewfile="$HOME/*"
    batlangsdirt=$(bat --list-languages | sort --reverse)
    batlangs=$(echo "$batlangsdirt" | awk -F ":" '{print $2}' | awk -F "," '{print $1}' | awk '{print $1}')
    echo "$batlangs" | fzf --preview-window=right,80% --preview="bat --language={} --color=always $viewfile"
} ; alias bat-preview-languages="bat_preview_languages"
function c(){
          local catthis="$1"
  if   [[ -z "${catthis}" ]]; then clear && return 0 || return 1; fi
  if   [[ -d "${catthis}" ]]; then cd  "${catthis}"  || printf "\e[0;38;5;196mFailed to cd to %s\e[0m\n]]" "${catthis}" || return 1 && return 0
  elif [[ -f "${catthis}" ]]; then cat "${catthis}"  || return 1 && return 0
  else return 0
  fi
}
alias bat-preview-themes='bat --list-themes | fzf --preview="bat --theme={} --language=sh --color=always $HOME/*"'
### [=]==================================[=]
### [~]............ ls
### [=]==================================[=]
### [ ls ]
### ls aliases
alias lsls='/usr/bin/ls'
alias ls-plain='/usr/bin/ls --color --oneline'
alias l='ls --color=always --all --long' # List All On One Line
_LSD=$(whereis lsd | awk '{print $2}')
if [[ -f "$_LSD" ]]; then
#  alias l='clear ; echo -e "▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂" ; pwd ; echo -e "██████████████████████████████████" ; lsd --color always --oneline --all ; echo -e "▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂\n"   ' # List All On One Line
  alias l='lsd --color always --oneline --almost-all ; echo -e "▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂\n"   ' # List All On One Line
  alias ll='clear && lsd --color always --icon always --oneline --long --almost-all' # List All On One Line Sort By Extension
  alias la='lsd --color always --icon always --almost-all'
  alias lla='lsd --all --long --total-size --sizesort --reverse --color always --icon always'
  alias lls="tput smcup ; clear ; printf 'o boi ...   This could take a  quick second ﭂ \n' ; lsd --long --sort=size --date=+'%Y-%m-%d.%H%M%S' --permission=octal --no-symlink --color=always --total-size --almost-all --reverse"
  alias lsext='lsd --color always --icon always --oneline --almost-all --extensionsort' # List All On One Line Sort By Extension
  alias ls="lsd --almost-all"
  alias ls='lsd --color always --icon always'
  alias lsa='command lsd --color always --icon always --almost-all .*(.)' # List Only Hidden Files
  alias lsar='command lsd --color always --icon always --almost-all --recursive .*(.)' # List Only Hidden Files Recurse
  alias lsl='lsd --color always --icon always --oneline --long --almost-all --sizesort --human-readable --reverse' # List All On One Line Sort By Size Long List Reversed
  alias lss='lsd --color always --icon always --oneline --long --almost-all --sizesort --human-readable --reverse' # List All On One Line Sort By Size Long List Reversed
  alias lsdir="lsd --color always --icon always --oneline --long --almost-all --sizesort --total-size --human-readable $1 2>/dev/null" # List All On One Line Sort By Size Long List Show Directory Sizes Reversed
  alias lsdirr="lsd --color always --icon always --oneline --long --almost-all --recursive --sizesort --total-size --human-readable $1 2>/dev/null" # List All On One Line Recurse Sort By Size Long List Show Directory Sizes Reversed
  alias lsdirg="lsd --color always --icon always --oneline --long --almost-all --recursive --group-dirs --total-size --human-readable $1 2>/dev/null" # List All On One Line Recurse Sort By Size Long List Show Directory Sizes Reversed
  alias lsr="lsd --color always --icon always --oneline --long --almost-all --recursive --human-readable $1 2>/dev/null" # List All On One Line Recurse Long List
  alias lst="lsd --color always --icon always --oneline --long --almost-all --recursive --timesort --human-readable $1 2>/dev/null" # List All On One Line Sort By Modification Time Long List Reversed
  alias lst="lsd --color always --icon always --oneline --long --almost-all --timesort --human-readable --reverse" # List All On One Line Recurse Sort By Modification Time Long List Reversed
  alias lstr="lsd --color always --icon always --oneline --long --almost-all --recursive --timesort --human-readable $1 2>/dev/null" # List All On One Line Recurse Sort By Modification Time Long List Reversed
  alias lltree='clear ; echo -e "Gathering tree ...\n\nThis may take a while     " ; echo "$(lsd --color always --icon always --almost-all --tree --total-size -l --sort=time --human-readable --depth=10 2>/dev/null)" | bat --color=never --plain'
  alias lstree="lsd --color always --icon always --almost-all --tree --total-size --human-readable $1 2>/dev/null" # List All On One Line Recurse Sort By Modification Time Long List Reversed
  alias 'cd ls'='lsd --almost-all --long'
  alias ks='lsd --color always --icon always'
  alias s='lsd --color always --icon always'
fi
_EXA=$(whereis exa | awk '{print $2}')
if [[ -f "$_EXA" ]]; then
  alias llsa='clear && exa --all --color always --long --icons --group-directories-first --sort=size --no-permissions --no-time --no-user --tree --level 3'
  alias l1='exa --color always --icons --oneline --all --header' # List All On One Line
#  alias l='exa --color always --icons --grid --all --header' # List All On One Line
  alias lll='exa --color always --icons --long --all --header' # List All On One Line Long List
  alias ls-ll="clear ; exa --sort=type --colour always --tree --recurse --long --all"
  alias ls-ll2="clear ; exa --sort=type --colour always --tree --level 2 --long --all"
  alias ls-ll4="clear ; exa --sort=type --colour always --tree --level 4 --long --all"
  alias ls-l="clear ; exa --sort=type --colour always --long --all"
  alias ls-l="clear ; exa --sort=type --colour always --long --all $"
  alias ls-lnc="clear ; exa --sort=type --colour never --long --all"
  alias ls-ll-etcback="clear ; exa --sort=type --colour always --tree --recurse --long --all $etcbackup"
  alias ls-ll2-etcback="clear ; exa --sort=type --colour always --tree --level 2 --long --all $etcbackup"
  alias ls-ll4-etcback="clear ; exa --sort=type --colour always --tree --level 4 --long --all $etcbackup"
  alias ls-l-etcback="clear ; exa --sort=type --colour always --long --all $etcbackup"
  alias ls-l-etcback="clear ; exa --sort=type --colour always --long --all $ $etcbackup"
  alias ls-lnc-etcback="clear ; exa --sort=type --colour never --long --all $etcbackup"
  alias ls-ll-etc="clear ; exa --sort=type --colour always --tree --recurse --long --all /etc"
  alias ls-ll2-etc="clear ; exa --sort=type --colour always --tree --level 2 --long --all /etc"
  alias ls-ll4-etc="clear ; exa --sort=type --colour always --tree --level 4 --long --all /etc"
  alias ls-l-etc="clear ; exa --sort=type --colour always --long --all /etc"
  alias ls-l-etc="clear ; exa --sort=type --colour always --long --all $ /etc"
  alias ls-lnc-etc="clear ; exa --sort=type --colour never --long --all /etc"
fi
alias LS="ls"
alias sl="ls"
alias sls="ls"
alias list-open-files='lsof'
alias list-open-files-repeat='lsof -r "m[~]========================[ Time: %T ]========================[~]"'
alias list-open-internet-files='lsof -i -U'
### [=]==================================[=]
### [~]............ rm
### [=]==================================[=]
alias rm="rm -v --preserve-root=all --interactive=once"
alias rrm="rm -v"
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
## [ Package Managers ]
## Debian
# apt
# apt-get
#alias apt-s="apt search"
#alias apt-s="apt search"
#alias apt-i="apt install -y"
# apt update and upgrade
#alias updgrate="apt-get update -y && apt-get full-upgrade -y"
## Gentoo
# emerge
## Arch
alias update='sudo pacman -Syuv' # Upgrade all system packages.
alias update-repo='sudo pacman --sync --refresh --verbose' # Update the package databases
alias update-repo-pgp='sudo pacman --sync --needed archlinux-keyring --verbose' # Update the local database of PGP keys used by the package maintainers.
# pacman
alias pacman='pacman --color always'
alias pacs='pacman -Ss --color=always'
alias pacsi='pacman -Sii --color always --verbose'
alias pacinstall='sudo pacman -S --color always --verbose'
alias paci='sudo pacman -S --color always --verbose'
alias paclist-installed='sudo pacman -Q --color always'
# yay
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
### [=]==================================[=]
### [~]............ Markdown
### [=]==================================[=]
#alias g="rich --markdown --padding 1,5,1,5 --panel rounded --line-numbers --center --text-full --pager --theme one-dark  --no-wrap --guides"
alias markdown-cli-renderer="glow"
alias markdown2HTML="markdown_py --output_format=html"
### Kitty Terminal
alias ekitty="$EDITOR $XDG_CONFIG_HOME/kitty/kitty.conf"
### Terminator
# YouTube Search/Watcher Using fzf
alias youtube-fzf="ytfzf"
# YouTube Search/Downloader Using fzf
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
### Edit ~/.config/awesome/rc.lua
alias eawesome='$EDITOR ~/.config/awesome/rc.lua'
#alias awesome-quit="echo 'awesome.quit()' | awesome-client"
alias awesome-quit="awesome-client 'awesome.quit()'"
alias awesome-restart="awesome-client 'awesome.restart()'"
### Backup ~/.config/awesome/rc.lua , theme.lua
alias bawesome='bash $HOME/.config/awesome/awesome-backups/awesome-backup-scripts/awesome-config-backup.sh'
### Switch to ~/.config/awesome
alias cdawesome='cd ~/.config/awesome'
### Check Awesome config file for errors
alias awesome-check='awesome --check'
alias check-awesome='awesome --check'
##### Open Awesome documentation Online
alias awesomeh='xdg-open https://awesomewm.org/apidoc/index.html'
alias awesomeh-easy='xdg-open https://awesomewm.org/apidoc/documentation/07-my-first-awesome.md.html'
### [=]==================================[=]
### [~]............ Vim/Neo-Vim
### [=]==================================[=]
### Replace Vim with Neo-Vim
alias vim='nvim'
### Open 2 vertical windows in nvim
alias vim-split='nvim -O2'
### Edit nVim Configuration '$HOME/.config/nvim/init.vim'
### Install nVim plugins from CLI
#nvim -es -u "$HOME/.config/nvim/init.vim" -i NONE -c "PlugInstall" -c "qa"
### [=]==================================[=]
### [~]............ Permissions
### [=]==================================[=]
# Preserve Root
alias chmod='chmod --preserve-root'
alias chmodex='chmod --preserve-root u+x --verbose'
alias chmodexr='chmod --preserve-root u+x --verbose'
alias chx='chmod --preserve-root u+x --verbose'
alias chown-dampsock="sudo chown --verbose --preserve-root dampsock:dampsock"
alias chown-dampsock-recursive="sudo chown --verbose --preserve-root --recursive dampsock:dampsock"
alias chgrp='chgrp --verbose'
alias chgrpR='chgrp --verbose --recursive'
# shellcheck disable=2139
alias check-file-permissions="stat ${*} --printf=\"\n%n\n%F\n%A\n%a\n\""
### [=]==================================[=]
### [~]............ rclone
### [=]==================================[=]
alias rclone-backup-scripts-to-onedrive="rclone copyto $HOME/scripts sk8:scripts --ignore-existing -v --progress --progress-terminal-title --check-first"
alias rclone-sync-scripts='rclone sync "$HOME/scripts" "sk8:scripts" --dry-run  --interactive --create-empty-src-dirs --progress --color'
alias rclone-tree='rclone tree sk8: --color --level 5 --verbose'
alias rclone-tree-all='rclone tree sk8: --color --verbose'
alias generate-passphrase='diceware --delimiter "." --specials 2 --caps --num 6 | xclip -selection Clipboard && echo "${fg_blue}Copied Passphrase To Clipboard ... ${reset_normal}"'
### [=]==================================[=]
### [~]............ pwd/realpath
### [=]==================================[=]
### Real Path
alias rp='realpath'
alias rp-pwd='rp --no-symlinks $(ls --group-dirs=first --classic)'
alias rp-all='rp-pwd .*'
#alias rp-all='rp --no-symlinks $(ls --group-dirs=first --classic)'
alias realpath-all='echo -e "$(rp $(ls --color=never --icon=never  *))"'


### [=]==================================[=]
### [~]............ cp
### [=]==================================[=]



### [=]==================================[=]
### [~]............ rm
### [=]==================================[=]
### Confirm Before Deletion
alias rm="rm --verbose -i"
alias rmf='rm --force --verbose'
### Remove current empty directory. Execute \kbd{\cd ..; rmdir \$OLDCWD}
alias rmcdir='cd ..; rmdir --verbose $OLDPWD || cd $OLDPWD'
alias rmcwd="rmcdir"
### Remove current directory
alias rmcdir-force='cd ..; rm -I -r --verbose $OLDPWD || cd $OLDPWD'
alias rmcwd-force='cd ..; rm -I -r --verbose $OLDPWD || cd $OLDPWD'
### Remove .git folder
alias rm-git="fd --regex '\.git' --exclude='*config*' --exclude='*hook*' --type directory --hidden --exec rm '{}' --recursive --verbose"
# Remove LICENSE file
alias rm-license="rm -I -v LICENSE"

### [=]==================================[=]
### [~]............ mkdir
### [=]==================================[=]
### Create Folders
# Automatically create subfolders
alias mkdir='mkdir -p -v'
#alias md='mkdir -p -v'

### [=]==================================[=]
### [~]............ sudo
### [=]==================================[=]
## Allow mispelling of sudo "sudp"
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
## NeoFetch ##
alias nf='clear && neofetch'

### [=]==================================[=]
### [~]............... Email
### [=]==================================[=]
## Email Clients ##
alias cliemail='aerc'
alias cli-email='aerc'
alias email='aerc'
alias thunderbird="thunderbird && birdtray"

### [=]==================================[=]
### [~]............ File Explorers
### [=]==================================[=]
## File Explorers
alias fe='pcmanfm &'

### [=]==================================[=]
### [~]............ Lynx
### [=]==================================[=]
alias lynx="lynx -session=$LYNX_SESSION"

### [=]==================================[=]
### [~]............ Firefox
### [=]==================================[=]
##~ Firefox
# alias ff='firefox --ProfileManager $1 &'
# alias ffox='firefox &'
# alias firfox='firefox'
# alias ffprofile='firefox --ProfileManager'
# alias firefox-profile='firefox --ProfileManager'
# alias ffprivate='firefox --ProfileManager --private-window'
# alias ffp='firefox --ProfileManager --private-window &'
# alias firefox-private='firefox --private-window &'
# alias ffs='firefox --ProfileManager --search $1'
# alias ffsarch='firefox "https://wiki.archlinux.org/index.php?search="$1'
# alias ffh='firefox --help'
### [=]==================================[=]
### [~]........... LibreWolf
### [=]==================================[=]
## LibreWolf
# alias lw='librewolf --ProfileManager $1 &'
# alias librewolf='librewolf --ProfileManager $1 &'
# alias lwolf='librewolf &'
# alias librwolf='librewolf'
# alias lwprofile='librewolf --ProfileManager'
# alias librewolf-profile='librewolf --ProfileManager'
# alias lwprivate='librewolf --private-window'
# alias lwp='librewolf --private-window &'
# alias librewolf-private='librewolf --private-window &'
# alias lws='librewolf --search'
# alias lwarch='librewolf --search "site:archlinux.org'
# alias lwh='librewolf --help'
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
## Clipboard ##
alias clip='xclip -selection clipboard -rmlastnl'
alias copy='xclip -selection clipboard -rmlastnl'
alias xcopy='xclip -selection clipboard -rmlastnl'
alias pwd-to-clip='pwd | xclip -selection clipboard'
alias pwd2clip='pwd | xclip -selection clipboard'
### [=]==================================[=]
### [~]............ Screen Capturing
### [=]==================================[=]
### Screen Capturing
alias screencap="scrot '%Y-%m-%d_$wx$h_screencapture.png' --overwrite --select -e && 'mv $f ~/images/screencaptures/$f'"
alias sc="scrot '%Y-%m-%d_$wx$h_screencapture.png' --select -e 'mv $f $HOME/images/screencaptures/$f'"
alias scap="scrot '%Y-%m-%d_$wx$h_screencapture.png' --overwrite -e 'mv $f ~/images/screencaptures/'"
alias scrot="scrot '$HOME/pictures/screencaptures/%Y-%m-%d_%H%M%S_$wx$h_$a_Screenshot.png' --line style=dash,width=5 --select=hide --quality 100 -n \"-f '/usr/share/fonts/TTF/Inconsolata-ExtraBold.ttf/20' -x 5 -y 10 -c 0,0,0 -t '$USER $DATE'\" && echo -e \"\e[32mSaved Screenshot To Directory\e[33m:  \e[1m\e[33m'\e[3;4m\e[34m/home/dampsock/pictures/screencaptures/\e[0m\\e[33m'\e[0m\""
alias screenc="scrot '$HOME/pictures/screencaptures/%Y-%m-%d_%H%M%S_$wx$h_$a_Screenshot.png' --line style=dash,width=5 --select=hide --quality 100 -n \"-f '/usr/share/fonts/TTF/Inconsolata-ExtraBold.ttf/20' -x 5 -y 10 -c 0,0,0 -t '$USER $DATE'\" && echo -e \"\e[32mSaved Screenshot To Directory\e[33m:  \e[1m\e[33m'\e[3;4m\e[34m/home/dampsock/pictures/screencaptures/\e[0m\\e[33m'\e[0m\""

### Color Picker
alias colorpicker='gpick'
## Icon Editor: ACYLS - https://github.com/worron/ACYLS ##
alias iconedit='python3 ~/.icons/ACYLS/scripts/run.py & '
alias colorpicker-tui='rgb-tui'
### Window Spy
alias window-spy='xprop'
### Reset Wallpaper
alias wp='nitrogen --restore'
### [=]==================================[=]
### [~]............ OFSEC
### [=]==================================[=]
#salias rootkit-search='sudo rkhunter --skip-keypress --summary --check --verbose-logging'
#salias check-security='sudo rkhunter --skip-keypress --summary --check --verbose-logging && sudo lynis audit system && sudo checksec --proc-all --output=cli --verbose && tput setaf 46 && echo "\n\nDONE\n\n" && tput sgr0'
#salias clamav-update='sudo systemctl stop clamav-freshclam.service && sudo freshclam && sudo systemctl start clamav-freshclam.service'
#salias clamav-scan='sudo clamscan --infected --recursive --verbose /'
#salias get-audit-daemon-log-summary='aureport'
#salias list-file-permissions-ABSOLUTE="stat $@ --format=\"%n %A %a\""
#salias list-loginctl-seats="loginctl list-seats && echo '\n\nTo view seat status, run command using the listed seats from the previous commands output\n\n \$\t loginctl seat-status seat0\n'"
#salias Linux-Security-Auditing-Tool='lsat -v -o "/var/log/$DATE$TIME_lsat_audit.out"'
#salias audit-linux-security='lsat -v -o "$DATE$TIME_lsat_audit.out"'
#salias list-logins='lslogins'
#salias list-login-groups='lslogins --supp-groups'
#salias list-account-password-expirations='lslogins --acc-expiration'
### [=]==================================[=]
### [~]............ NMAP
### [=]==================================[=]
if command -v nmap >/dev/null 2>&1; then
  # Some useful nmap aliases for scan modes
  # Nmap options are:
  #  -sS - TCP SYN scan
  #  -v - verbose
  #  -T1 - timing of scan. Options are paranoid (0), sneaky (1), polite (2), normal (3), aggressive (4), and insane (5)
  #  -sF - FIN scan (can sneak through non-stateful firewalls)
  #  -PE - ICMP echo discovery probe
  #  -PP - timestamp discovery probe
  #  -PY - SCTP init ping
  #  -g - use given number as source port
  #  -A - enable OS detection, version detection, script scanning, and traceroute (aggressive)
  #  -O - enable OS detection
  #  -sA - TCP ACK scan
  #  -F - fast scan
  #  --script=vuln - also access vulnerabilities in target
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
alias -s routersploit='clear && rsf'
if command -v msfconsole >/dev/null 2>&1; then
  alias msf='sudo msfconsole'
fi
### [=]==================================[=]
### [~].......... PASSWORDS
### [=]==================================[=]
### Password Strength Checker
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
if command docker >/dev/null 2>&1; then
  alias docker-run-interactive="docker run --interactive --tty"
  alias docker-lazy='lazydocker'
  alias dockers="docker search --no-trunc"
  #salias audit-docker-security='docker-bench-security'
fi
if command figlet-gallery >/dev/null 2>&1; then
  alias figlet-preview="figlet-gallery"
fi
alias list--proprietary-software='absolutely-proprietary'
### System Usage Monitors
alias ram-usage="free -th"
alias all-the-tops="$SCRIPTS/bash/all-the-tops/all-the-tops.sh"
alias colortop='vtop'
### [~]............ https://github.com/soxofaan/duviz
alias disk-usage="dfrs --human-readable --total --color=always --columns=filesystem,bar,used_percentage,used,available_percentage,available,capacity,type,mounted_on 2>/dev/null"
alias disk-usage-2="dfc 2>/dev/null"
alias watch-disk-usage="watch -c --interval 0.5 --no-title --differences dfrs --human-readable --total --color=always --columns=filesystem,bar,used_percentage,used,available_percentage,available,capacity,type,mounted_on"
alias watch-disk-usage-2="watch -c --interval 0.5 --no-title --differences dfc -c always"
# watch command interval (seconds)
export WATCH_INTERVAL=1
export WATCH_FAST_INTERVAL=0.1
alias watch="watch --precise --interval $WATCH_INTERVAL"
alias watch-fast="watch --precise --interval $WATCH_FAST_INTERVAL"
### Python HTTP Server
alias http-server='python -m http.server'
alias xterm='xterm -fg white -bg black -cr red -bd blue'
alias ssh-audit='$HOME/.local/lib/python3.9/site-packages/ssh_audit/ssh_audit.py'
alias ssh-copypublickey='copysshkeypublic'
alias ssh-showpublickey='cat ~/.ssh/id_rsa.pub'
alias tmux-ssh="tmux new-session ssh"
### [=]==================================[=]
### [~]............ VNC
### [=]==================================[=]
alias vncviewer-custom='vncviewer --DotWhenNoCursor --UpdateScreenshot --PasswordStoreOffer --AutoReconnect --FullScreen --SecurityNotificationTimeout=0 --ToolbarIconSize=16 --SessionRecordAllowUserControl -FullScreen -AutoReconnect --KeepAliveResponseTimeout=30 --KeepAliveInterval=30 --NotificationPos=2 &'
alias vnc-server-start="x11vnc -nevershared -forever -usepw &"
### [=]==================================[=]
### [~]............ MPV
### [=]==================================[=]
### [=]==================================[=]
### [~]............ Linode
### [=]==================================[=]
alias lin='linode-cli'
alias linode-list="linode-cli linodes list"
### [=]==================================[=]
### [~]............ man
### [=]==================================[=]
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
# By default, NetworkManager stores passwords in clear text in the connection files at /etc/NetworkManager/system-connections/.
# To print the stored passwords, use the following command:
#salias get-wifipasswords="grep -r '^psk=' /etc/NetworkManager/system-connections/"
### [=]==================================[=]
### [~]........... FireJail
### [=]==================================[=]
## Firejail
alias fj='firejail'
## FireJail FireFox
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
#alias reboot="clear ; echo -e \"\e[35mRebooting in \e[31m3 \e[35mseconds \e[31m... \e[0m\" ; sleep 3 ; clear ; echo -e \"\e[31m$(cat $ZSH_ASCII_ART_DIR/alien-flamethrower.txt --plain --paging never)\n$(cat $ZSH_ASCII_ART_DIR/REBOOTING.txt --plain --paging never)\e[0m\" ; sleep 1.5 ; reboot"
### [=]==================================[=]
### [~]............. BOXES
### [=]==================================[=]
###{{{ boxes

### toilet --filter border TEXT

#alias boxes-little="little_boxes"
#alias box-draw-stdin="little_boxes --charset thick --title $DATE"
#alias box-draw-stdin-right-aligned="boxes -d parchment -p h5 | boxes -s $(tput cols) -c x -a hr -i none | sed -e 's/^x/ /'"
#alias box-draw-stdin-center-aligned="boxes -d parchment -p h5 | boxes -s $(tput cols) -c x -a hc -i none | cut -c 2-"
#alias box-draw-stdin-center-aligned-twisted="boxes -d twisted -p h5 | boxes -s $(tput cols) -c x -a hc -i none | cut -c 2-"

### boxes examples

# 	$  figlet "boxes . . . !" | lolcat -f | boxes -d unicornthink

#	$  echo $USER | figlet -f "ANSI Shadow" | boxes -d bear | lolcat

#	$   echo $USER | figlet -f "pagga" | boxes -d bear | lolcat

#	$   df -h | little_boxes -t $HOST -a | lolcat

### [x]==================================[x]
###}}}
alias stat-permission-pwd="stat --printf='%a %A %n\t\t\t\t%F\n' *"
alias stat-permission="stat --printf='%a %A %n\t\t\t\t%F\n'"
alias stat-permissions-custom="find $1 -type $2 -exec stat --printf='%A %a %n' {} \;"
alias stat-permissions-path-files="find $1 -type f -exec stat --printf='%A %a %n' {} \;"
alias stat-permissions-type-etc="find /etc -type $2 -exec stat --printf='%A %a %n' {} \;"
alias stat-permissions-type-etcback="find $etcbackup -type $2 -exec stat --printf='%A %a %n' {} \;"
alias stat-permissions-files-pwd-1="find . -maxdepth 1 -type f -exec stat --printf='%A %a %n' {} \;"
alias stat-permissions-dir-pwd-1="find . -maxdepth 1 -type d -exec stat --printf='%A %a %n' {} \;"
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
alias lllll=" echo -e '\n\e[0;1;38;5;198m═══════════════════════════════════════════════════════════════════════════════════\e[0m\n' ; dfc -c always -d -T -s -q name ; echo -e '\n\e[0;1;38;5;82m═══════════════════════════════════════════════════════════════════════════════════\e[0m\n' ; lsd --long -A --sort=size --reverse --total-size ; echo -e '\n\e[0;1;38;5;198m═══════════════════════════════════════════════════════════════════════════════════\e[0m\n'"
alias m="man"
alias iptables-watch="sudo watch --differences --differences --color --interval 1 iptables -vnL --line-numbers"
alias html2md="html2text --mark-code --unicode-snob --body-width=0 --open-quote '**' --close-quote '**' --reference-links --pad-tables --images-to-alt --no-wrap-links --hide-strikethrough --decode-errors=ignore"
alias difff="diff --color=always --minimal --suppress-common-lines --side-by-side --ignore-all-space"
alias kernel-command-line-parameters="cat /proc/cmdline"
# Count Files
alias count='find . -type f | wc -l'

