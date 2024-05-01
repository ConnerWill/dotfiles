# shellcheck disable=1072,2148

function cd-repo(){
  cd $(git rev-parse --show-toplevel)
}
