#shellcheck disable=2148

function shellcheck-harden(){
  draw_entire_line
  printf "ShellHarden\n"
  draw_entire_line

  shellharden \
    --suggest \
    --syntax-suggest "${@}"

  draw_entire_line

  draw_entire_line
  printf "ShellCheck\n"
  draw_entire_line

  shellcheck             \
    --enable=all         \
    --list-optional      \
    --check-sourced      \
    --external-sources   \
    --wiki-link-count=20 \
    --format=tty         \
    --color=always "${@}"

  draw_entire_line
}
