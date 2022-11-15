#!/bin/bash
 # # "\e[?25l" ## Hide Cursor
 # "\e[?25h" ## Restore Cursor
 # "\e[1A"   ## Move curser up 1 line
 # "\e[2K"   ## Clear line
 # "\r"      ## Move cursor to beginning of line
 # "\e[2K"   ## Clear line
 # "\r"      ## Move cursor to beginning of line


#   Created by: Ian Brown (ijbrown@hotmail.com)
#   Please share with me your modifications
# Note: From http://stackoverflow.com/questions/11592583/bash-progress-bar
# Functions

trapentered(){ printf "\e[0m\e[2K\n\n\n"; exit;}
trap 'trapentered' SIGHUP SIGINT

PUT        (){ echo -en "\033[${1};${2}H";}
DRAW       (){ echo -en "\033%";echo -en "\033(0";}
WRITE      (){ echo -en "\033(B";}
HIDECURSOR (){ echo -en "\033[?25l";}
NORM       (){ echo -en "\033[?12l\033[?25h";}

randomcolor=$(shuf -i 0-255 -n 1)
randomcolor1=$(shuf -i 0-255 -n 1)
randomcolor2=$(shuf -i 0-255 -n 1)
function showBar {
#        randomcolor=$(shuf -i 0-255 -n 1)
        barcolor="${1}" ## random colors
        barcolor='190'  ## yellow
        titlecolor="\e[0;1;38;5;${randomcolor1}m"
        bordercolor="\e[0;1;38;5;${randomcolor2}m"
        barcolor="\e[0;1;38;5;${randomcolor};48;5;${randomcolor}m"
        # barcolor="\e[0;1;38;5;${randomcolor};48;${randomcolor}m"
        percDone=$(echo 'scale=2;'$1/$2*100 | bc)
        halfDone=$(echo $percDone/2 | bc)           #I prefer a half sized bar graph
        barLen=$(echo ${percDone%'.00'})
        halfDone=$(( halfDone + 6 ))

        printf "\e[1m"
        PUT 7 28; printf "${bordercolor}%4.4s  %%" "${barLen%}"        #Print the percentage
        PUT 5 "${halfDone}";  printf "${barcolor} \033[0m" #Draw the bar
        # PUT 5 "${halfDone}";  printf "\033[1;38;5;${barcolor}48;5;${barcolor}m \033[0m" #Draw the bar
        printf "\e[0m"
        }
# Start Script
clear
HIDECURSOR
echo -e ""
echo -e ""
DRAW    #magic starts here - must use caps in draw mode \033[0;1;4;38;5;46m
printf "          ${titlecolor}PLEASE WAIT WHILE SCRIPT IS IN PROGRESS\033[0m\n"
printf "    ${bordercolor}lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk\n"
printf "    ${bordercolor}x                                                   x\n"
printf "    ${bordercolor}mqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqj\n"
WRITE
#
# Insert your script here
for (( i=0; i<=50; i++ ))
do
    showBar $i 50  #Call bar drawing function "showBar"
    sleep .2
done
# End of your script
# Clean up at end of script
PUT 10 12
echo -e ""
NORM
