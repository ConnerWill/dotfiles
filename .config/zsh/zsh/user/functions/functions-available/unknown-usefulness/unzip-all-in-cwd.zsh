function unzip-all-in-cwd(){
  clear
  local cccc="$(pwd)"
  for zipa in ${cccc}/*.zip; do
    unzip -v -n "$zipa" && rm -f -v "$zipa"
  done
}
