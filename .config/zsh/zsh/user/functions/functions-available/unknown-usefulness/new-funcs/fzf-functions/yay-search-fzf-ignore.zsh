function yay-search-fzf-ignore(){

  local searchterm="$1"
  local ignoreterm="$2"

  [[ -z "$searchterm" ]] \
    && echo "ERROR\tNo Search Query\n\nUsage:\n\t\$  $0 <search> [ignore]\n" \
      && return 1

  [[ -z "$ignoreterm" ]] \
    && local ignoreterm="randomfuckingtext"
#    && echo "ERROR\tNo Search Query\n\nUsage:\n\t\$  $0 <search> [ignore]\n" \

  yay \
    -Ss \
    --color always \
    --sortby votes \
    --list \
    --singlelineresults \
    "$1" 2&>1 \
      | grep \
        --invert-match \
        "$ignoreterm" 2&>1 \
          | fzf \
            --ansi \
            --no-mouse \
            --margin=1,1,1,1 \
            --exit-0 \
  || echo "ERROR\tUnknown Error\n\nUsage:\n\t\$  $0 <search> [ignore]\n" \

}
