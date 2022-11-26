for zlecmd in $(zle -la  | cut -d" " -f1); do printf "\n\n\n\n\e[0;1;4;38;5;46m%s\e[0m\n\n" "${zlecmd}";  which "${zlecmd}"; done


## Usage
##
##  eval $(cat PATH-TO-THIS-FILE)
##
##
