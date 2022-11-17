# shellcheck disable=1091,2296,2086,2016,1072,1058,1036,1073

## Load Completions System
## Autoload zsh modules when they are referenced
zmodload -i zsh/complist
autoload -Uz compinit && compinit -u
autoload -Uz bashcompinit && bashcompinit
zmodload -a  zsh/stat    zstat
zmodload -a  zsh/zpty    zpty
zmodload -ap zsh/mapfile mapfile

## Shellcheck disable=2034
## Automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH; typeset -a tmp

export ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-${XDG_CACHE_HOME}/zsh}"
export ZCOMPCACHE="${ZCOMPCACHE:-${ZSH_CACHE_DIR}/zcompcache}"
export ZCOMPDUMP=${ZCOMPDUMP:-${ZSH_CACHE_DIR}/zcompdump}

# shellcheck disable=2298
# We can use a cache in order to speed things up
[[ ! -d "${ZSH_CACHE_DIR}" ]] && mkdir -pv "${ZSH_CACHE_DIR}"

# glob qualifiers description:
#   N    turn on NULL_GLOB for this expansion
#   .    match only plain files
#   m-1  check if the file was modified today
# see "Filename Generation" in zshexpn(1)
run_compdump=1
for match in "${ZCOMPDUMP}"(N.m-1); do
    run_compdump=0; break
done; unset match

if (( run_compdump )){
    printf "\e[0;38;5;8mRebuilding zsh completion dump\e[0m:\t"
    compinit -D -d "${ZCOMPDUMP}"; compdump; sleep 0.5
    print "\e[2K\r\e[2K\e[1A" ## Move curser up 1 line
} else {
    compinit -C -d "${ZCOMPDUMP}" "${tmp[@]}" # -C flag disables some checks performed by compinit - they are not needed because we already have a fresh compdump
}; unset tmp run_compdump

function comp_setup () {
    (( ${+_comps} )) || return 1                                                             # Make sure the completion system is initialised
    [[ -z "${NOMENU}" ]] &&    zstyle ':completion:*'                              menu select=2 || setopt no_auto_menu      # if there are more than N options allow selecting from a menu
    zstyle ':chpwd:*'                                   recent-dirs-max 0
    zstyle ':completion:*'                              completer _complete _match _approximate
    zstyle ':completion:*'                              format '%K{black}%F{blue}░░▒▒▓▓██ %d ██▓▓▒▒░░%f%k' ## %K{black}%F{blue}━━━ %d ━━━%f%k'
    zstyle ':completion:*'                              group-name ''
    zstyle ':completion:*'                              list-colors ${(s.:.)LS_COLORS}
    zstyle ':completion:*'                              matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    zstyle ':completion:*'                              menu select
    zstyle ':completion:*'                              rehash true
    zstyle ':completion:*'                              use-cache true
    zstyle ':completion:*'                              use-cache yes
    zstyle ':completion:*'                              verbose true                                                    ## Provide verbose completion information
    zstyle ':completion:*'                              verbose yes                                                     ## Provide verbose completion information
    zstyle ':completion:*:*:-subscript-:*'              tag-order indexes parameters                                    ## Offer indexes before parameters in subscripts
    zstyle ':completion:*:*:cd:*:directory-stack'       menu yes select                                                 ## Automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
    zstyle ':completion:*:*:cdr:*:*'                    menu selection
    zstyle ':completion:*:*:zcompile:*'                 ignored-patterns '(*~|*.zwc)'                                   ## Define files to ignore for zcompile
    zstyle ':completion:*:approximate:'                 max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'      ## Allow one error for every three characters typed in approximate completer
    zstyle ':completion:*:complete:*'                   cache-path "${ZCOMPCACHE}"
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'                             ## Don't complete backup files as executables
    zstyle ':completion:*:correct:*'                    insert-unambiguous true                                         ## Start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*'                    original true
    zstyle ':completion:*:corrections'                  format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
    zstyle ':completion:*:corrections'                  format ' %F{yellow}-- %d (errors: %e) %f'
    zstyle ':completion:*:default'                      list-colors ${(s.:.)LS_COLORS}                                  ## Activate color-completion
    zstyle ':completion:*:default'                      list-prompt '%S%M matches%s'
    zstyle ':completion:*:descriptions'                 format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'                ## Format on completion
    zstyle ':completion:*:descriptions'                 format ' %K{black}%F{blue}⬛⬛ %d ⬛⬛%f%k'
    zstyle ':completion:*:descriptions'                 format '%U%B%d%b%u'
    zstyle ':completion:*:expand:*'                     tag-order all-expansions                                        ## Insert all expansions for expand completer
    zstyle ':completion:*:functions'                    ignored-patterns '(_*|pre(cmd|exec))'
    zstyle ':completion:*:history-words'                list false
    zstyle ':completion:*:history-words'                menu yes                                                        ## Activate menu
    zstyle ':completion:*:history-words'                remove-all-dups yes                                             ## Ignore duplicate entries
    zstyle ':completion:*:history-words'                stop yes
    zstyle ':completion:*:man:*'                        menu yes select
    zstyle ':completion:*:manuals'                      separate-sections true                                          ## Complete manual by their section
    zstyle ':completion:*:manuals.*'                    insert-sections   true
    zstyle ':completion:*:match:*'                      original only
    zstyle ':completion:*:matches'                      group 'yes'                                                     ## Separate matches into groups
    zstyle ':completion:*:messages'                     format ' %F{yellow}⬛⬛ %d ⬛⬛%f'
    zstyle ':completion:*:messages'                     format '%d'
    zstyle ':completion:*:options'                      auto-description '%d'
    zstyle ':completion:*:options'                      description 'yes'                                               ## Describe options in full
    zstyle ':completion:*:processes'                    command 'ps -au$USER'                                           ## On processes completion complete all user processes
    zstyle ':completion:*:processes-names'              command 'ps c -u ${USER} -o command | uniq'                     ## provide more processes in completion of programs like killall:
    zstyle ':completion:*:urls'                         local 'www' '/var/www/' 'public_html'                           ## Command for process lists, the local web server details and host completion
    zstyle ':completion:*:warnings'                     format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'               ## Set format for warnings
    zstyle ':completion:*:warnings'                     format ' %F{red}-- no matches found --%f'
    zstyle ':completion::(^approximate*):*:functions'   ignored-patterns '_*'                                           ## Ignore completion functions for commands you don't have:
    zstyle ':completion:correct:'                       prompt '🖳 correct to: %e'
    zstyle -a ':grml:completion:compinit'               arguments tmp
    zstyle -e ':completion:*:approximate:*'             max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
    zstyle ':completion:*:*:*:users'                    ignored-patterns                                                                        \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon dbus distcache dovecot fax ftp games gdm gkrellmd gopher hacluster       \
        haldaemon halt hsqldb ident junkbust ldap lp mail mailman mailnull mldonkey mysql nagios named netdump news nfsnobody nobody nscd       \
        ntp nut nx openvpn operator pcap postfix postgres privoxy pulse pvm quagga radvd rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs ## Don't complete uninteresting users

    # Run rehash on completion so new installed program are found automatically:
    function _force_rehash() { (( CURRENT )) && rehash; return 1; }

    ## Correction
    #NOCOR=0 ## (Default: 0 (Correction enabled))
    if (( NOCOR )) { # set 'NOCOR=0' to deactivate it
        zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _files _ignored
        setopt nocorrect
    } else {
        setopt correct
        correction_codeblock='if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] { _last_try="$HISTNO$BUFFER$CURSOR"; reply=(_complete _match _ignored _prefix _files) } else { if [[ $words[1] == (rm|mv) ]] { reply=(_complete _files) } else { reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files); }; }'
        zstyle -e ':completion:*' completer ${correction_codeblock}
    }

    ## Host Completion
    ## Define variable 'NOHOSTSCOMPL' to disable completing hosts
    ## Define variable 'NOETCHOSTS' to disable completing hosts from /etc/hosts
    #NOHOSTSCOMPL=true ## (Default: <undefined>)
    #NOETCHOSTS=true   ## (Default: <undefined>)
    # if [[ -z "${NOHOSTSCOMPL}" ]] {
      SSH_DIR="${SSH_DIR:-${HOME}/.ssh}"
      SSH_USER_CONFIG="${SSH_DIR:-${HOME}/.ssh/config}"
      SSH_USER_KNOWNHOSTS="${SSH_DIR:-${HOME}/.ssh/known_hosts}"

      [[ -r "${SSH_USER_CONFIG}" ]]                                                                                    \
        && _ssh_config_hosts=(${${(s: :)${(ps:\t:)${${(@M)${(f)"$(<$HOME/.ssh/config)"}:#Host *}#Host }}}:#*[*?]*})   \
        || _ssh_config_hosts=()

      [[ -r "${SSH_USER_KNOWNHOSTS}" ]]                                           \
        && _ssh_hosts=(${${${${(f)"$(<$SSH_DIR/known_hosts)"}:#[\|]*}%%\ *}%%,*}) \
        || _ssh_hosts=()

      [[ -r /etc/hosts ]]                                                                                                                                 \
        && [[ "$NOETCHOSTS" -eq 0 ]]                                                                                                                      \
        && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(grep -v '^0\.0\.0\.0\|^127\.0\.0\.1\|^::1 ' /etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}}   \
        || _etc_hosts=()

      local localname
      localname="$(uname -n)"
      hosts=(
              "${localname}"
              "${_ssh_config_hosts[@]}"
              "${_ssh_hosts[@]}"
              "${_etc_hosts[@]}"
              localhost
      )
      zstyle ':completion:*:hosts' hosts "${hosts[@]}"
      typeset -a compcom_list
      compcom_list=(
                     cp
                     deborphan
                     df
                     feh
                     fetchipac
                     gpasswd
                     head
                     hnb
                     ipacsum
                     mv
                     pal
                     stow
                     uname
                     gping
      )
      for compcom in "${compcom_list[@]}"; do
          [[ -z ${_comps[$compcom]} ]] && compdef _gnu_generic "${compcom}"
      done

      ## See upgrade function in this file
      unset compcom compcom_list
      compdef _hosts upgrade
  }
# }

    # Completion for dotf command (dotfiles)
    dotf >/dev/null 2>&1 && compdef dotf=git
    dotfiles >/dev/null 2>&1 && compdef dotf=git

comp_setup
unfunction comp_setup










        # if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
        #     _last_try="$HISTNO$BUFFER$CURSOR"
        #     reply=(_complete _match _ignored _prefix _files)
        # else
        #     if [[ $words[1] == (rm|mv) ]] ; then
        #         reply=(_complete _files)
        #     else
        #         reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
        #     fi
        # fi'
