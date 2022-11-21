###
### ZSHENV
###
#
## XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

### ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSHRC="$ZDOTDIR/.zshrc"

### LOCALE
export LC_ALL="en_US.UTF-8"

## No global files
setopt NOGLOBALRCS
#setopt PROMPT_SUBST
#setopt PROMPT
