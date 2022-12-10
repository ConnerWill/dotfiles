ansi_color_5() {
  local r=$1 # 0 .. 5
  local g=$2 # 0 .. 5
  local b=$3 # 0 .. 5

  echo -e $(( 16+ $r*36 + $g*6 + $b))
}

ansi_color_bg_5 () {
  echo -e "\e[38;5;$(ansi_color_5 $1 $2 $3)m"
}
ansi_color_fg_5 () {
  echo -e "\e[48;5;$(ansi_color_5 $1 $2 $3)m"
}

ansi_reset() {
  echo -e "\e[0m"
}


printf "\n"
for r in {0..5}; do
  for g in {0..5}; do
    for b in {0..5}; do

      printf "  "

      if [[ $r > 3 || $g > 3 ]]; then
        bg_color='0 0 0'
      else
        bg_color='5 5 5'
      fi

      printf "$(ansi_color_fg_5 $r $g $b)$(ansi_color_bg_5 $bg_color) %3d " $(ansi_color_5 $r $g $b)

    done
    printf $(ansi_reset)
    printf "\n"
  done
  printf "\n"
done
