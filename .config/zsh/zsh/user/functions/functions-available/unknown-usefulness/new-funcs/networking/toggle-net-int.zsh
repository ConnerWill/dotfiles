# nmcli usage to toggle net int

NetInterface="enp5s0"
#export LC_ALL=C

NetIntUUID=$(nmcli -p -f general device show $NetInterface | grep GENERAL.CON-UUID | awk '{print $2}')
enable_disable_NetInt (){
   result=$(nmcli dev | grep $NetInterface | grep -w "connected")
   if [ -n "$result" ]; then
       nmcli device disconnect $NetInterface > /dev/null 2>&1
   else
       nmcli device connect $NetInterface > /dev/null 2>&1
   fi
}


check_connection_status (){
   checkConnection=$(nmcli dev | grep $NetInterface | grep -w "connected")
   if [ -n "$result" ]; then
		ConnectionStatus='\e[38;5;112mConnected\e[0m'
		ConnectionColor="40"
   else
       ConnectionStatus='\e[21m\e[38;5;124mDisconnected\e[0m'
   fi
}

show_connection_status (){
	echo -e "$NetInterface : $ConnectionStatus\e[0m"
}






enable_disable_NetInt
check_connection_status
show_connection_status


