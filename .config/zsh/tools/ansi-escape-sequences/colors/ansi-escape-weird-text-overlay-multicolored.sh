


# Sequence 
sequence='\n\t\e[3;4;58;5;13;1;38;5;14m'
echo -e "\e[1;3;4;58;5;21m                                         "
echo -e "\e[1;3;4;58;5;21m                                         "
echo -e "\e[1;3;4;58;5;46;38;5;196m   Example:                              \e[0m"

echo -e "${sequence}   $USER  \e[0m\n"

echo -e ' \t\e[3;4;58;5;13;1;38;5;14m    TEXT    \e[0m\n\t'

# Show Code                                                                    
echo -e -n "\e[3;4;58;5;46;1;38;5;196m  ANSI:                                  \e[0m\n\n\t"
echo '\e[3;4;58;5;13;1;38;5;14m\e[0m'

echo -e -n "\n\e[3;4;58;5;46;1;38;5;196m  Command:                               \e[0m\n\n $  "
echo 'echo -e "\t\e[3;4;58;5;13;1;38;5;14m  TEXT  \e[0m\n\n\t"'



# Diagram
echo -e "\n\e[1;3;4;58;5;46;38;5;196m Breakdown:                              \e[0m"
echo '
                under-
                line       text
     Esc-, i u  color  b   color
         | | | ___|___ | ____|___
         V v V [Green] V [ Red  ]
        \e[3;4;58;5;46;1;38;5;196m
'
echo -e "\e[1;3;4;58;5;21m                                         "
echo -e "\e[1;3;4;58;5;21m                                         "




#                under-
#                line       text
#     Esc-, i u  color  b   color
#         | | | ___|___ | ____|___
#         V v V [Green] V [ Red  ]
#        \e[3;4;58;5;46;1;38;5;196m
