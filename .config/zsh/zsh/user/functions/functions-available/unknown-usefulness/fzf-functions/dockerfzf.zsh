


function dockerfzf(){
  
  dockersearch="$1"
  [[ -z "$dockersearch" ]] \
    && dockersearch="docker"

  DOCKER_PREFIX="docker search --no-trunc --limit=100"
  INITIAL_QUERY="$dockersearch"
  FZF_DEFAULT_COMMAND="$DOCKER_PREFIX '$INITIAL_QUERY'" 

  docker search \
    --no-trunc \
    --limit=100 "$dockersearch" \
      | fzf \
        --bind "change:reload:($DOCKER_PREFIX {q})" \
        --ansi \
        --query "$INITIAL_QUERY" \
        --preview="{}" \
        --preview-window=down,1
}
