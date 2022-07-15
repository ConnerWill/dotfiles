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
[[ -n "$(command -v kitty)" ]] \
  && kitty + complete setup zsh | source /dev/stdin

## Completion for hugo
[[ -n "$(command -v hugo)" ]] \
  && hugo completion zsh | source /dev/stdin


# Completion problems
#
# Many completion problems, including the infamous command not found: compdef, can be solved by resetting the completion system.
#
#     First, try to remove your completion cache with rm ~/.zcompdump*, close and reopen your shells.
#
#     If you still have problems, try fully resetting the completion system, as explained by @dragon788:
#
#     compaudit | xargs chmod g-w,o-w
#     compaudit | xargs chown "$USER"
#     rm ~/.zcompdump*
#     exec zsh
