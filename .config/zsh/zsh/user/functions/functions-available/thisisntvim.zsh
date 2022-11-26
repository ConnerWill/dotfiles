function thisisntvim(){
  printf "\e[2K\e[1A\e[2K\r\e[0;1;38;5;201mTHIS IS NOT VIM\e[0;38;5;87m\t:)\e[0m\n"
}
alias ':wq'="thisisntvim"; alias ':wq!'="thisisntvim"
alias ':q'="thisisntvim" ; alias ':q!'="thisisntvim"
