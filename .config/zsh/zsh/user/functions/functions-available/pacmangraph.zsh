

function pacmangraph(){
  local OUTPUTPACGRAPHDIR="$HOME/Pictures/pacgraph/output/$(date +'%Y%m%d')"
  [[ ! -d "$OUTPUTPACGRAPHDIR" ]] \
    && mkdir -v -p "$OUTPUTPACGRAPHDIR"

  [[ ! -d "$OUTPUTPACGRAPHDIR" ]] \
    && echo "CANNOT CREATE OUTPUT DIR '$OUTPUTPACGRAPHDIR'" \
      && return 1

  pacgraph -f "$OUTPUTPACGRAPHDIR/$(date +'%Y%m%d')-pacgraph" \
    --svg \
      --explicits \
        -b "#010101" \
        -l "#5075DF" \
        -t "#00C8CA" \
        -d "#B50AB7" \
      -p 10 75 \
  && eog "$OUTPUTPACGRAPHDIR/$(date +'%Y%m%d')-pacgraph.svg"
}
