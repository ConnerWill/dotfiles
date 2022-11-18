
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
