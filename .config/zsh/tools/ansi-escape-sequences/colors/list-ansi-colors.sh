echo -e '\033[?47h' # save screen
sleep 1

ansitestONE() {
	for a in 0 1 4 5 7; do
	      echo "a=$a " 
	      for (( f=0; f<=9; f++ )) ; do
	              for (( b=0; b<=9; b++ )) ; do
	                      #echo -ne "f=$f b=$b" 
	                      echo -ne "\\033[${a};3${f};4${b}m"
	                      echo -ne "\\\\\\\\033[${a};3${f};4${b}m"
	                      echo -ne "\\033[0m "
	              done
	      echo
	      done
	      echo
	done
	echo
}

ansitestTWO() {
	for b in {0..7} 9; do
	  for f in {0..7} 9; do
	      for attr in "" bold; do
	         echo -e "$(tput setab $b; tput setaf $f; [ -n "$attr" ] && tput $attr) $f ON $b $attr $(tput sgr0)"
	      done
	  done
	done
}

home() {
  # yes, actually not much shorter ;-)
  tput home
}


clear
sleep 1



#echo -e '\033[?47h' # save screen

ansitestONE
sleep 1
ansitestTWO

read -p "PRESS ANY KEY   :   "
sleep 0.5
echo -e '\033[?47l' # restore screen
