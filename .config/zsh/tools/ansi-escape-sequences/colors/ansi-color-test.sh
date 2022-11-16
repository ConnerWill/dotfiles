function ansitest(){
      for a in 0 1 2 3 4 5 6 7 8 9 ; do
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
ansitest | less --RAW-CONTROL-CHARS --CLEAR-SCREEN
