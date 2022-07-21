function netstat_list_number_of_connection(){
    netstat -ant \
        | awk '{print $6}' \
        | sort \
        | uniq -c \
        | sort -n
}
