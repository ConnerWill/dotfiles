#shellcheck disable=2148,2139,2059,1050,1140

## ALIASES FOR BUILTIN TOOLS (coreutils)
##
## If not a coreutil, set alias in './71_vendor_aliases.zsh' file.

alias e="${EDITOR}"

## To use doas instead of suddo...
## Set the environment variable 'USEDOAS' to any value (Default: false)
#export USEDOAS=true
### [=]==================================[=]
### [~]............ SUDO
### [=]==================================[=]
if [[ "${commands[sudo]}" ]] && [[ -z "${USEDOAS}" ]]; then
    export SUDOCMD="${${SUDOCMD}:-sudo}"
    alias suso="${SUDOCMD}"
    alias sudu="${SUDOCMD}"
    alias sydo="${SUDOCMD}"
    alias sudk="${SUDOCMD}"
    alias sudp="${SUDOCMD}"
    alias 'sud['="${SUDOCMD}"
    alias suno="${SUDOCMD}"
fi

### [=]==================================[=]
### [~]............ SUDOEDIT
### [=]==================================[=]
if [[ "${commands[sudoedit]}" ]] && [[ -z "${USEDOAS}" ]]; then
    alias sudoe="sudoedit"
fi

### [=]==================================[=]
### [~]............ DOAS
### [=]==================================[=]
if [[ "${commands[doas]}" ]] && [[ -n "${USEDOAS}" ]]; then
    export DOASCMD="doas"
    export SUDOCMD="${DOASCMD}"
    alias sudo="${DOASCMD}"
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
# alias 'cd-1'="cd ${OLDPWD}"
# alias cdold="cd ${OLDPWD}"
alias cdtemp="${TEMPDIR}"
alias cd-temp="${TEMPDIR}"


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

### [=]==================================[=]
### [~]............ CLEAR
### [=]==================================[=]
alias cl="clear"
alias cls='clear'
alias cler='clear'
alias cleart='clear'


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
alias chmod-exec-1="find $1 -maxdepth 1 -type $2 -exec chmod --verbose $3 {} \;"
alias chmod-exec-x="find $1 -maxdepth $2 -type $3 -exec chmod --verbose $4 {} \;"
alias chmod-exec="find $1 -type $2 -exec chmod --verbose $3 {} \;"
alias chmod-files-etc-1="find /etc -maxdepth 1 -type f -exec chmod --verbose 644 {} \;"
alias chmod-permissions-dir-etc-1="find /etc -maxdepth 1 -type d -exec chmod --verbose 644 {} \;"
alias chmod-ref-recur="chmod --preserve-root --verbose --recursive --reference $1 $2"
alias chmod-ref="chmod --preserve-root --verbose --reference $1 $2"
alias chmod-dir-775-1="find $1 -maxdepth 1 -type d -exec chmod --verbose 775 {} \;"
alias chmod-files-644-1="find $1 -maxdepth 1 -type f -exec chmod --verbose 644 {} \;"

### [=]==================================[=]
### [~]......... PWD/REALPATH
### [=]==================================[=]
alias rp='realpath'
alias rp-pwd='rp --no-symlinks $(ls --group-dirs=first --classic)'
alias rp-all='rp-pwd .*'
alias realpath-all='echo -e "$(rp $(ls --color=never --icon=never  *))"'
alias rl="readlink"

alias ram-usage="free -th"

alias duhs='du -h --summarize'

### [=]==================================[=]
### [~]............ WATCH
### [=]==================================[=]
alias watch="watch -n 0.1 --color"

### [=]==================================[=]
### [~]............ SSH
### [=]==================================[=]
alias ssh-showpublickey="${PAGER} ${SSH_DIR:-~/.ssh}/*.pub"

### [=]==================================[=]
### [~]............ MAN
### [=]==================================[=]
alias m="man"
alias zshall="man zshall"
alias man-search='man --all --wildcard'
alias man-search-name='man --all --names-only --regex'

### [=]==================================[=]
### [~]............ CHMOD
### [=]==================================[=]

alias lastlogin="loginctl"

if [[ "${commands[iptables]}" ]]; then
    alias iptables-watch="${SUDOCMD} watch --differences --color --interval 1 iptables -vnL --line-numbers"
fi

if [[ "${commands[ip]}" ]]; then
    alias ip='ip -color=auto'
fi


alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias difff="diff --color=always --minimal --suppress-common-lines --side-by-side --ignore-all-space"
alias kernel-command-line-parameters="cat /proc/cmdline"
alias wget="wget --hsts-file ${WGETHSTS:-${HOME}/.cache/.wget-hsts}"
