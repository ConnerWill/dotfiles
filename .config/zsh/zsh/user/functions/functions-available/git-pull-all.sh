

function showerrrrrrrrr(){
echo -e "\e[0;1;38;5;196mThis Function is Not Complete\e[0m" \
  ; return 1

}
showerrrrrrrrr


function git-pull-all(){
  CWD="$(pwd)"
  echo "$CWD"
  restoreCWD="$CWD"
  echo -e "\e[0;1;38;5;190mThis will run '\e[0;1;38;5;82mgit pull\e[0;1;38;5;190m' on every git repository below the current directory:\e[0m"
  echo -e "\t\e[1;38;5;13m$CWD\e[0m"
  echo -e "\e[0;1;38;5;190mDo you want to do this?\tPress '\e[0;1;38;5;82my\e[0;1;38;5;190m'\e[0m"
  read -r -s -q YESS
  if [[ "$YESS" == "y" ]]; then
   # for repoinCWD in "$CWD"*/*; do
   find "${CWD}" -type d -print0 -exec sh -c 'i="$1"; cd "$(realpath $i)" && echo "git pull" || echo "fail"' shell {} \;   
      

#    && echo -e '\e[0;1;38;5;82mUpdating {}\e[0m && 
#    || echo -e \e[0;1;38;5;196mCannot cd to {}\e[0m"

# done
  else
    echo -e "\e[0;1;38;5;82goodbye\e[0m"
    return 0
  fi
  cd "$restoreCWD" \
    || return 1
  return 0  
  local CWD
  local restoreCWD
}
