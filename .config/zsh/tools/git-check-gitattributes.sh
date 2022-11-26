#!/bin/bash                               

function git-check-missing-gitattributes(){
  local missing_attributes
  missing_attributes=$(git ls-files | git check-attr -a --stdin | grep "text: auto")
  [[ -n "${missing_attributes}" ]] \
    && printf "\t\e[0;38;5;196mUnable to detect a '\e[0;1;3;4;38;5;93m.gitattributes\e[0;38;5;196m' rule in the following files:\e[0m\n" \
    && echo "$missing_attributes" \
      | xargs -I{} --no-run-if-empty sh -c "printf '\t\t\e[0;3;38;5;190m{}\e[0m\n'" \
    || printf "\n\e[0;38;5;46mAll files have a corresponding rule in \e[0;1;38;5;93m.gitattributes\e[0m\n"
} 
# command1 && command2 | command3"   \

