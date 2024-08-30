function count-characters(){
  local input_item num_characters
  for input_item in "${@}"; do
    num_characters=$(printf "%s" "${input_item}" | wc --chars)
    printf "%s :\t%s\n" "${input_item}" "${num_characters}"
  done
}
