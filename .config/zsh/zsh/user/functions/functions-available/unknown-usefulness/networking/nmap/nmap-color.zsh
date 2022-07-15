function nmapcolor(){clear ; sudo nmap -vvv -A "$1" | rainbow --config="$XDG_CONFIG_HOME/rainbow/nmap.cfg"}
