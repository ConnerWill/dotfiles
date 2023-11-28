#shellcheck disable=2148

function shellcheck-harden(){
  draw_entire_line
  shellharden --suggest --syntax-suggest "${@}"
  draw_entire_line
  shellcheck --check-sourced --enable=all --color=always --external-sources --format=tty --wiki-link-count=20 "${@}"
  draw_entire_line
  shellcheck --check-sourced --enable=all --list-optional --color=always --external-sources --format=tty --wiki-link-count=20 "${@}"
  draw_entire_line
}
