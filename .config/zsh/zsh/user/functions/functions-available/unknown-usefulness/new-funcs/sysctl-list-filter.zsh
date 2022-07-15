function sysctl-list-filter(){
 clear
 echo -e "\n===================================="
 echo -e "\t$1"
 echo -e "====================================\n"

 sudo sysctl -a | grep "$1" | sort --reverse

 echo -e "\n===================================="
 echo -e "\t$1"
 echo -e "====================================\n"
}
