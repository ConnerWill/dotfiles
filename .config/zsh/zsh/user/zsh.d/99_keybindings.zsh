#shellcheck disable=1072,1073,1123,2148

#######################################################################################
#   You may read this file into your .zshrc or another startup file with
#   the `source' or `.' commands, then reference the key parameter in bindkey commands,
#   like this:
#
#(or)    source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE
#(or)    source ${ZDOTDIR:-$HOME}/keybindings/$TERM-$VENDOR-$OSTYPE
#        [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
#        [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
#
#######################################################################################
## https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
## https://raw.githubusercontent.com/sorin-ionescu/prezto/master/modules/editor/init.zsh
## http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
## http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
## http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
#######################################################################################

### [=]===========================================================[=]
###	[~] ------------------- ZSH KEYBINDINGS ----------------------[~]
### [=]===========================================================[=]
[[ ! -o AUTOCD ]] || setopt autocd

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
    bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
    bindkey -M viins "${terminfo[kpp]}" up-line-or-history
    bindkey -M vicmd "${terminfo[kpp]}" up-line
fi

## vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

## Ctrl-n accepts current selection and continutes menu completion for next selection
bindkey -M menuselect "^n" accept-and-menu-complete

## PgUp PgDown in menu completion
bindkey -M menuselect "${terminfo[kpp]}" backward-word ## PgUp
bindkey -M menuselect "${terminfo[knp]}" forward-word  ## PgDown

## gg to go to top of menu completion
bindkey -M menuselect 'gg' backward-word

## G to go to bottom of menu completion
bindkey -M menuselect 'G' forward-word

# Remove bindings to ctrl+r
bindkey -r '^r'

# Autoload history-search-multi-word
zle -N history-search-multi-word
zle -N history-search-multi-word-backwards history-search-multi-word
zle -N history-search-multi-word-pbackwards history-search-multi-word
zle -N history-search-multi-word-pforwards history-search-multi-word
bindkey "^R" history-search-multi-word
bindkey "^h" history-search-multi-word
bindkey "^H" history-search-multi-word
bindkey "^r" history-search-multi-word ## This will bind to Ctrl-R
bindkey -M viins "^r" history-search-multi-word ## This will bind to Ctrl-R
bindkey -M emacs "^r" history-search-multi-word ## This will bind to Ctrl-R

zstyle ":history-search-multi-word" page-size "20"
zstyle ":history-search-multi-word" highlight-color "fg=cyan,bold,bg=black"
# zstyle ":plugin:history-search-multi-word" synhl "yes"
# zstyle ":plugin:history-search-multi-word" clear-on-cancel "no"
