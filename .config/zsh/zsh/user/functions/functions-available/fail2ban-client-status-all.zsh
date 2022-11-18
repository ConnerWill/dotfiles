
function fail2ban-client-status-all(){
  sudo echo -n ""
 local PAGER="${PAGER:-less --RAW-CONTROL-CHARS}"
  sudo fail2ban-client status \
    | grep 'Jail list:' \
      | cut -f2- \
        | xargs \
          --delimiter=, \
          --no-run-if-empty \
          -I{} \
            sh -c "printf '\n\nFail2Ban: \e[0;1;38;5;82m{}\e[0m\n' ; sudo fail2ban-client status {}" \
              | "${PAGER}"
}




function fail2ban-client-dump(){
 sudo echo -n ""
 local PAGER="${PAGER:-less --RAW-CONTROL-CHARS}"
 headertitle='$(printf "\e[0;1;4;38;5;46mFail2Ban:\t\e[1;38;5;87mDUMP\e[0m\n\n\n" ${headertitle})'
 output=$(sudo fail2ban-client -t --dp)
 export jails=$(sudo fail2ban-client status | grep 'Jail list:' | cut -f2- | sed -e 's/\,//g' -e 's/\s/\|/g')

 
 printf "\e[0;1;4;38;5;46mFail2Ban:\t\e[1;38;5;87mDUMP\e[0m\n\n\e[1;38;5;93mJAILS:\e[0m\t\e[0;38;5;190m%s\e[0m\n\n\e[0;1;38;5;33mfail2ban \e[0;1;38;5;201mdump\e[0m\n\n%s\n" "${jails}" "${output}" \
	   | "${PAGER}"
	 #| grep -E "($jails)"  \
}
