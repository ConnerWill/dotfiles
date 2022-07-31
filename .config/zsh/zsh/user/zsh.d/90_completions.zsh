# shellcheck disable=1091,2296,2086,2016
[[ -z "${ZCOMPCACHE_PATH}" ]] \
  && ZCOMPCACHE_PATH="${XDG_CACHE_HOME}/zsh/zcompcache" \
  && export ZCOMPCACHE_PATH

## load completions system

zmodload -i zsh/complist
autoload -Uz compinit && compinit -u
autoload -Uz bashcompinit && bashcompinit

## Completion for kitty
[[ -n "$(command -v kitty)" ]] \
  && kitty + complete setup zsh \
  | source /dev/stdin

## Completion for hugo
[[ -n "$(command -v hugo)" ]] \
  && hugo completion zsh \
  | source /dev/stdin


#zstyle :compinstall filename '~/.zshrc'
zstyle    ':completion:*:*:cdr:*:*'     menu selection
zstyle    ':chpwd:*'                    recent-dirs-max 0
zstyle    ':completion:*'               completer _complete _match _approximate
zstyle    ':completion:*:match:*'       original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle    ':completion:*:matches'       group 'yes'
zstyle    ':completion:*:options'       description 'yes'
zstyle    ':completion:*:options'       auto-description '%d'
zstyle    ':completion:*:corrections'   format ' %F{green}-- %d (errors: %e) --%f'
zstyle    ':completion:*:descriptions'  format ' %K{black}%F{blue}⬛⬛ %d ⬛⬛%f%k'
zstyle    ':completion:*:messages'      format ' %F{yellow}⬛⬛ %d ⬛⬛%f'
zstyle    ':completion:*:warnings'      format ' %F{red}-- no matches found --%f'
zstyle    ':completion:*:default'       list-prompt '%S%M matches%s'
zstyle    ':completion:*:functions'     ignored-patterns '(_*|pre(cmd|exec))'
zstyle    ':completion:*'               format ' %K{black}%F{blue}⬛⬛ %d ⬛⬛%f%k'
zstyle    ':completion:*'               group-name ''
zstyle    ':completion:*'               verbose yes
zstyle    ':completion:*'               matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle    ':completion:*'               use-cache true
zstyle    ':completion:*'               rehash true
zstyle    ':completion:*'               menu select
zstyle    ':completion:*'               list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' completer _complete _ignored
# zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:]}={[:upper:]}'
# zstyle :compinstall filename "$ZSHRC"
# zstyle ':completion:*' menu select
# setopt completealiases

# shellcheck disable=2034
# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

# Load a few modules
# is4 && for mod in parameter complist deltochar mathfunc ; do
#     zmodload -i zsh/${mod} 2>/dev/null
#     grml_status_feature mod:$mod $?
# done && builtin unset -v mod

# autoload zsh modules when they are referenced
zmodload -a  zsh/stat    zstat
zmodload -a  zsh/zpty    zpty
zmodload -ap zsh/mapfile mapfile

# completion system
COMPDUMPFILE=${COMPDUMPFILE:-${ZDOTDIR:-${HOME}}/.zcompdump}
typeset -a tmp
zstyle -a ':grml:completion:compinit' arguments tmp
compinit -d ${COMPDUMPFILE} "${tmp[@]}"
unset tmp

# shellcheck disable=2298
# We can use a cache in order to speed things up
ZCOMPCACHE_PATH=${ZCOMPCACHE_PATH:-${$XDG_CACHE_HOME:-~/.cache}zsh/.cache/zcompcache}
[[ ! -d ${ZCOMPCACHE_PATH:h} ]] \
  && command mkdir -pv "${ZCOMPCACHE_PATH:h}"
zstyle ':completion:*' use-cache  yes
zstyle ':completion:*:complete:*' cache-path "${ZCOMPCACHE_PATH}"

# completion system
# note: use 'zstyle' for getting current settings
#       press ^xh (control-x h) for getting tags in context;
#       ^x? (control-x ?) to run complete_debug with trace output
function comp_setup () {
    (( ${+_comps} )) || return 1                                                             # Make sure the completion system is initialised
    [[ -z "${NOMENU}" ]]                                  \
      && zstyle ':completion:*'            menu select=5  \
      || setopt no_auto_menu                                                                 # if there are more than N options allow selecting from a menu
    zstyle ':completion:*'                 verbose true                                      # provide verbose completion information
    zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'                      # match uppercase from lowercase
    zstyle ':completion:*'                 group-name ''
    zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'   # allow one error for every three characters typed in approximate completer
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'                  # Ignore completion functions for commands you don't have:
    zstyle ':completion:*:options' auto-description '%d'
    zstyle ':completion:*:*:cd:*:directory-stack' menu yes select                            # automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'  # don't complete backup files as executables
    zstyle ':completion:*:correct:*'       insert-unambiguous true                           # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*'       original true
    zstyle ':completion:correct:'          prompt '🖳 correct to: %e'
    zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
    zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}                    # activate color-completion
    zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'  # format on completion
    zstyle ':completion:*:expand:*'        tag-order all-expansions                          # insert all expansions for expand completer
    zstyle ':completion:*:history-words'   list false
    zstyle ':completion:*:history-words'   menu yes                                          # activate menu
    zstyle ':completion:*:history-words'   remove-all-dups yes                               # ignore duplicate entries
    zstyle ':completion:*:history-words'   stop yes
    zstyle ':completion:*:messages'        format '%d'
    zstyle ':completion:*:matches'         group 'yes'                                       # separate matches into groups
    zstyle ':completion:*:manuals'         separate-sections true                            # complete manual by their section
    zstyle ':completion:*:manuals.*'       insert-sections   true
    zstyle ':completion:*:man:*'           menu yes select
    zstyle ':completion:*:options'         auto-description '%d'
    zstyle ':completion:*:options'         description 'yes'                                 # describe options in full
    zstyle ':completion:*:processes'       command 'ps -au$USER'                             # on processes completion complete all user processes
    zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'       # Provide more processes in completion of programs like killall:
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters                      # offer indexes before parameters in subscripts
    zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'                        # command for process lists, the local web server details and host completion
    zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs                               # Don't complete uninteresting users
    zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d' # set format for warnings
    zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'                     # define files to ignore for zcompile
    # zstyle ':completion:*'                 special-dirs ..                                   # provide '../' as a completion
    # recent (as of Dec 2007) zsh versions are able to provide descriptions
    # for commands (read: 1st word in the line) that it will list for the user
    # to choose from. The following disables that, because it's not exactly fast.
    #zstyle ':completion:*:-command-:*:'    verbose false

    function _force_rehash () { # run rehash on completion so new installed program are found automatically:
        (( CURRENT == 1 )) && rehash
        return 1
    }
    ## correction
    # some people don't like the automatic correction - so run 'NOCOR=1 zsh' to deactivate it
    if [[ "$NOCOR" -gt 0 ]] ; then
        zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _files _ignored
        setopt nocorrect
    else
        # try to be smart about when to use what completer...
        setopt correct
        zstyle -e ':completion:*' completer '
            if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
                _last_try="$HISTNO$BUFFER$CURSOR"
                reply=(_complete _match _ignored _prefix _files)
            else
                if [[ $words[1] == (rm|mv) ]] ; then
                    reply=(_complete _files)
                else
                    reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
                fi
            fi'
    fi

    # host completion
    [[ -r ~/.ssh/config ]] \
      && _ssh_config_hosts=(${${(s: :)${(ps:\t:)${${(@M)${(f)"$(<$HOME/.ssh/config)"}:#Host *}#Host }}}:#*[*?]*}) \
      || _ssh_config_hosts=()

    [[ -r ~/.ssh/known_hosts ]] \
      && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) \
      || _ssh_hosts=()

    [[ -r /etc/hosts ]] \
      && [[ "$NOETCHOSTS" -eq 0 ]] \
      && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(grep -v '^0\.0\.0.\0\|^127\.0\.0\.1\|^::1 ' /etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} \
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

  # # Search path for sudo completion
    # zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
    #                                            /usr/local/bin  \
    #                                            /usr/sbin       \
    #                                            /usr/bin        \
    #                                            /sbin           \
    #                                            /bin            \
    #                                            /usr/X11R6/bin
    # use generic completion system for programs not yet defined; (_gnu_generic works
    # with commands that provide a --help option with "standard" gnu-like output.)
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
  )
  for compcom in ${compcom_list}; do
    [[ -z ${_comps[$compcom]} ]] && compdef _gnu_generic ${compcom}
  done
  unset compcom compcom_list

  # see upgrade function in this file
  compdef _hosts upgrade


  dotf >/dev/null 2>&1 && compdef dotf=git
}
comp_setup ; unfunction comp_setup

###{{{
## add an autoload function path, if directory exists
## http://www.zsh.org/mla/users/2002/msg00232.html
## functionsd="$ZSH_CONFIG/functions.d"
## if [[ -d "$functionsd" ]] {
##     fpath=( $functionsd $fpath )
##     autoload -U $functionsd/*(:t)
## }
#
#
# ## auto rehash commands
# ## http://www.zsh.org/mla/users/2011/msg00531.html
# zstyle ':completion:*' rehash true
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path "$ZCOMPCACHE_PATH"
# zstyle ':completion:*' menu select                      # for all completions: menuselection
# zstyle ':completion:*' group-name ''                    # for all completions: grouping the output
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}   # for all completions: color
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;47    # for all completions: selected item
# zstyle ':completion:*' special-dirs true                # completion of .. directories
#
# ### fault tolerance
# zstyle ':completion:*' completer _complete _correct _approximate
# # (1 error on 3 characters)
# zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
#
# # case insensitivity
# #zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# zstyle ":completion:*" matcher-list 'm:{A-Zöäüa-zÖÄÜ}={a-zÖÄÜA-Zöäü}'
#
# # for all completions: grouping / headline / ...
# zstyle ':completion:*:messages' format $'\e[01;35m -- %d -- \e[00;00m'
# zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found -- \e[00;00m'
# zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d -- \e[00;00m'
# # https://thevaluable.dev/zsh-completion-guide-examples/
# zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
#
# # statusline for many hits
# zstyle ':completion:*:default' select-prompt $'\e[01;35m -- Match %M    %P -- \e[00;00m'
#
# # for all completions: show comments when present
# zstyle ':completion:*' verbose yes
#
# # in menu selection strg+space to go to subdirectories
# #bindkey -M menuselect '^@' accept-and-infer-next-history
#
# # case-insensitive -> partial-word (cs) -> substring completion:
# zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#
# # caching of completion stuff
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path "$ZSH_CACHE"
#
# # ~dirs: reorder output sorting: named dirs over userdirs
# zstyle ':completion::*:-tilde-:*:*' group-order named-directories users
#
# # ssh: reorder output sorting: user over hosts
# zstyle ':completion::*:ssh:*:*' tag-order "users hosts"
#
# # kill: advanced kill completion
#
# zstyle ':completion::*:kill:*:*' command 'ps xf -U $USER -o pid,%cpu,cmd'
# zstyle ':completion::*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'
#
# # rm: advanced completion (e.g. bak files first)
# zstyle ':completion::*:rm:*:*' file-patterns '*.o:object-files:object\ file *(~|.(old|bak|BAK)):backup-files:backup\ files *~*(~|.(o|old|bak|BAK)):all-files:all\ files'
#
# # vi: advanced completion (e.g. tex and rc files first)
# zstyle ':completion::*:vi:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'
#
# Completion problems
# Many completion problems, including the infamous command not found: compdef, can be solved by resetting the completion system.
#     First, try to remove your completion cache with rm ~/.zcompdump*, close and reopen your shells.
#     If you still have problems, try fully resetting the completion system, as explained by @dragon788:
#
#         compaudit | xargs chmod g-w,o-w
#         compaudit | xargs chown "$USER"
#         rm ~/.zcompdump*
#         exec zsh

###}}}
# https://thevaluable.dev/zsh-completion-guide-examples/
# https://raw.githubusercontent.com/Phantas0s/.dotfiles/master/zsh/completion.zsh


