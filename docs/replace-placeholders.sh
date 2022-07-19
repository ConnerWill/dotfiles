function replace-placeholders(){
  local searchstring 
  local _find_and_replace_no_replace_input_error
  local _find_and_replace_no_search_input_error
  local currentworkingdir
  local yesorno
  _find_and_replace_no_search_input_error='No Search String Received'
  _find_and_replace_no_replace_input_error='No Replace String Received'
  currentworkingdir="$(pwd)"

  searchstring="$1"
  [[ -z "$searchstring" ]] \
    && printf '\e[0;1;48;5;196;38;5;15m ERROR \e[0;38;5;190m  %s\e[0;1;38;5;201m :(\e[0m\n' "$_find_and_replace_no_search_input_error" \
      && return 1
  replacestring="$2"
  [[ -z "$replacestring" ]] \
    && printf '\e[0;1;48;5;196;38;5;15m ERROR \e[0;38;5;190m  %s\e[0;1;38;5;201m :(\e[0m\n' "$_find_and_replace_no_replace_input_error" \
      && return 1

  printf '\e[0;1;48;5;21;38;5;15m CONFIRM \e[0;38;5;15m  Replace all occurrences of \e[0;1;38;5;57m"%s" \e[0;38;5;15mwith \e[0;1;38;5;87m"%s" \e[0;38;5;15min all files below \e[0;1;38;5;201m"%s" \e[0;38;5;15m?\e[0m\n' "$searchstring" "$replacestring" "$currentworkingdir" 
  read -s -t 10 -r yesorno \
    || yesorno=""
 
  if [[ "$currentworkingdir" == '/' ]] || [[ "$currentworkingdir" == '/usr' ]] || [[ "$currentworkingdir" == '/etc' ]]; then 
    printf '\e[0;1;48;5;196;38;5;15m ERROR \e[0m  Prohibitted Directory!\n'
    return 1
  else
    if [[ "$yesorno" == "y" ]] || [[ "$yesorno" == "Y" ]]; then
      printf '\n\e[0;1;48;5;93;38;5;87m RUNNING \e[0m\n'
      find . -type f -exec grep --ignore-case --files-with-matches "$searchstring" '{}' \; | xargs -I {} sed --debug -i "s/$searchstring/$replacestring/g" '{}' \
        && printf '\e[0;1;48;5;82;38;0;m DONE \e[0m\n' \
          && return 0 \
        || printf '\e[0;1;48;5;196;38;5;15m ERROR \e[0m $?\n' \
          || return 1
    elif [[ "$yesorno" == "" ]]; then
      printf '\e[0;1;48;5;12;38;5;15m TIMEOUT \e[0m\n'
      printf '\e[0;1;48;5;93;38;5;15m EXITING \e[0m\n'
    elif [[ "$yesorno" == "n" ]] || [[ "$yesorno" == "N" ]]; then
      printf '\e[0;1;48;5;93;38;5;15m EXITING \e[0m\n'
      return 0
    else
      printf '\e[0;1;48;5;9;38;5;15m UNKNOWN \e[0;1;38;5;11m  "%s"\e[0m\n' "$yesorno"
      printf '\e[0;1;48;5;93;38;5;15m EXITING \e[0m\n'
      return 1 
    fi
  fi

}
printf '\n\e[0;38;5;15mRun the command:\n\n\t\e[0;38;5;245m$  \e[0;1;38;5;190mreplace-placeholders \e[0;3;38;5;201m<SEARCH> \e[0;3;38;5;51m<REPLACE>\e[0m\n\n' \

#### OLD VERSION ####
# #!/bin/bash
# PLACEHOLDER="dotfiles"
# NEWREPONAME=""
# FILENAME="README-test.md"
# function _replace_placeholder_template(){
#   
#   [[ -z "$PLACEHOLDER" ]] \
#     && printf "'PLACEHOLDER' is undefined\n" \
#     && return 1
#   
#   [[ ! -f "$FILENAME" ]] \
#     && printf "Cannot find '%s'\n" "$FILENAME" \
#     && return 1
#   
#   [[ -z "$NEWREPONAME" ]] \
#     && read -r -p "Enter the name of your project: " NEWREPONAME
#   
#   printf "Press 'Y/y' to replace placeholder '%s' with '%s' in '%s'\n" "$PLACEHOLDER" "$NEWREPONAME" "$FILENAME" 
#   read -r -s -t 10 CONFIRMREPLACE
#
#   [[ ! "$CONFIRMREPLACE" == "y" || ! "$CONFIRMREPLACE" == "Y" ]] \
#     &&  printf "Exiting ...\n" \
#     && return 0 
#
#   sed -i -e "s/${PLACEHOLDER}/${NEWREPONAME}/g" ${FILENAME} \
#     && printf "DONE :)\n" \
#     && return 0 \
#     || return 1 
# }
# _replace_placeholder_template

