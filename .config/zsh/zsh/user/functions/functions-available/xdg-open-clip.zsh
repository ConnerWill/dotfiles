function xdg-open-clip(){
  [[ "${commands[termux-open]}" ]] && urlopener="termux-open"
  [[ "${commands[xdg-open]}" ]] && urlopener="xdg-open"
  [[ "${commands[termux-clipboard-get]}" ]] && clipboardgetter="termux-clipboard-get"
  [[ "${commands[xset]}" ]] && clipboardgetter="xset -p"

  clipb="$(${clipboardgetter})

  "${urlopener}" "${clipb}"
}
