#!/bin/zsh
#shellcheck disable=2148

### Testing/Attempt of adding list of files to zsh array

function ssss(){

 #ssss=$("d")
 #ls -1 | xargs

# $listdir=$(find "${ZDOTDIR}/zsh/user/zsh.d" -type f)


  local zdir zdir_list
  zdir="${zdir/#$HOME/~}"
  #zdir_list=(${(s:/:)zdir})
  #zdir_list=('/' $zdir_list)
  zdir_list=( "${(s:/:)${zdir/#$HOME/~}}" )





#find "${ZDOTDIR}/zsh/user/zsh.d" -type f -print0 | xargs -0 -I{} 'echo {}'


#  echo "$ssss"
}

ssss



# Example to show how to append piped/redirected input to arg array
#
# More info:
# `man test` (lookup -t flag)
# `man zshbuiltins` (lookup set builtin)
#
# piped_input_example
# piped_input_example --flag arg
# piped_input_example --opt1 -x -y -z param1 param2 <<< "zzz"
# echo "abc" | piped_input_example --opt1 -x -y -z param1 param2
# printf "%s\n" abc def | piped_input_example --opt1 -x -y -z param1 param2

function piped_input_example {
  local piped=()
  if [[ ! -t 0 ]]; then
    # handle both <redirected or piped| input
    local data
    while IFS= read -r data || [[ -n "$data" ]]; do
      piped+=($data)
    done
  fi

  echo "regular args ($#): $@"
  echo "piped args ($#piped): $piped"

  echo "setting new arg array..."
  (( $#piped )) && set -- "$@" "$piped[@]"
  echo "new arg array ($#): $@"
}


sleep 1
piped_input_example
sleep 1
piped_input_example --flag arg
sleep 1
piped_input_example --opt1 -x -y -z param1 param2 <<< "zzz"
sleep 1
echo "abc" | piped_input_example --opt1 -x -y -z param1 param2
sleep 1
printf "%s\n" abc def | piped_input_example --opt1 -x -y -z param1 param2

