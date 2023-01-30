#!/bin/env bash

function center(){
  termwidth="$(tput cols)"
  padding="$(printf '%0.1s' ={1..500})"
  printf '\x1B[0;38;5;201m%*.*s \x1B[0;38;5;190m%s \x1B[0;38;5;201m%*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

center "Something I want to print"
