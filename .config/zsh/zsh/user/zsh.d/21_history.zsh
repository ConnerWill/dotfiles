




# $HISTFILE belongs in the data home, not with the configs
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh-history/history"
[[ ! -f "$HISTFILE" ]] \
  && mkdir -p "$HISTFILE:h" \
  && touch "$HISTFILE"

# you can set $SAVEHIST and $HISTSIZE to anything greater than the ZSH defaults
# (1000 and 2000 respectively), but if not we make them way bigger.
[[ $SAVEHIST -gt 1000 ]] || SAVEHIST=20000
[[ $HISTSIZE -gt 2000 ]] || HISTSIZE=100000

# make the history command more useful
alias history="fc -li"










