#!/shellcheck/disable=1

# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename "$ZSHRC"
zstyle ':completion:*' menu select
setopt completealiases

autoload bashcompinit
bashcompinit

autoload -Uz compinit; compinit
autoload -U compinit
compinit -u
compinit

## call to kitty to load the zsh completions after the call to compinit.
autoload -Uz compinit
compinit

## Completion for kitty
# shellcheck disable=1091
[[ -n "$(command -v kitty)" ]] \
  && kitty + complete setup zsh | source /dev/stdin

## Completion for hugo
# shellcheck disable=1091
[[ -n "$(command -v hugo)" ]] \
  && hugo completion zsh | source /dev/stdin





# add an autoload function path, if directory exists
# http://www.zsh.org/mla/users/2002/msg00232.html
# functionsd="$ZSH_CONFIG/functions.d"
# if [[ -d "$functionsd" ]] {
#     fpath=( $functionsd $fpath )
#     autoload -U $functionsd/*(:t)
# }

# load completions system
# zmodload -i zsh/complist
#
# # auto rehash commands
# # http://www.zsh.org/mla/users/2011/msg00531.html
# zstyle ':completion:*' rehash true
#
#
# export ZCOMPCACHE_PATH="$XDG_CACHE_HOME/zsh/zcompcache"
#
# # cache
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path "$ZCOMPCACHE_PATH"
#
# # for all completions: menuselection
# zstyle ':completion:*' menu select
#
# # for all completions: grouping the output
# zstyle ':completion:*' group-name ''
#
# # for all completions: color
# # shellcheck disable=2296,2086
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#
# # for all completions: selected item
# # shellcheck disable=2296,2086
# #zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;47
#
# # completion of .. directories
# # shellcheck disable=1091
# zstyle ':completion:*' special-dirs true
#
# # fault tolerance
# zstyle ':completion:*' completer _complete _correct _approximate
# # (1 error on 3 characters)
# # shellcheck disable=2016
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
# bindkey -M menuselect '^@' accept-and-infer-next-history
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
# # shellcheck disable=2016
# zstyle ':completion::*:kill:*:*' command 'ps xf -U $USER -o pid,%cpu,cmd'
# zstyle ':completion::*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'
#
# # rm: advanced completion (e.g. bak files first)
# zstyle ':completion::*:rm:*:*' file-patterns '*.o:object-files:object\ file *(~|.(old|bak|BAK)):backup-files:backup\ files *~*(~|.(o|old|bak|BAK)):all-files:all\ files'
#
# # vi: advanced completion (e.g. tex and rc files first)
# zstyle ':completion::*:vi:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'
#
# zstyle :compinstall filename '~/.zshrc'
#
# autoload -Uz compinit && compinit
#
# # Completion problems
# # Many completion problems, including the infamous command not found: compdef, can be solved by resetting the completion system.
# #     First, try to remove your completion cache with rm ~/.zcompdump*, close and reopen your shells.
# #     If you still have problems, try fully resetting the completion system, as explained by @dragon788:
# #
# #         compaudit | xargs chmod g-w,o-w
# #         compaudit | xargs chown "$USER"
# #         rm ~/.zcompdump*
# #         exec zsh
# # https://thevaluable.dev/zsh-completion-guide-examples/
# # https://raw.githubusercontent.com/Phantas0s/.dotfiles/master/zsh/completion.zsh
