#!/bin/zsh
#shellcheck disable=2148


####
### Testing/Attempt of adding components of PWD to an zsh associative array
##
##  $   current_PWD="$HOME/a/b/c/d/e"; print -l $current_PWD
##        /
##        home
##        user
##        a
##        b
##        c
##        d
##        e
###
####

function ssss(){
  local zdir zdir_list pwd_list
  zdir="$(pwd)"
  #zdir_list=(${(s:/:)zdir}); zdir_list=('/' $zdir_list)
  zdir_list=( "${(s:/:)${zdir}}" )
  #print -l "${zdir_list[@]}"
  #print -l "${zdir_list}"
  pwd_list=( "${(s:/:)${PWD/#$HOME/\$\{HOME\}}}" )
  print -l "${pwd_list[@]}" ## Multiple lines
  echo
  print "${pwd_list[@]}"    ## Single Line
}
ssss
