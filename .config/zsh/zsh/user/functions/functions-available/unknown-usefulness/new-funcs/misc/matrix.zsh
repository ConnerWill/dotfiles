#matrix () { echo -e "[1;40m" clear while : do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 )) sleep 0.05 done | awk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4; letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "[%s;%sH[2;32m%s",o,x,letter; printf "[%s;%sH[1;37m%s[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}' }




function matrix () {


    local white="7"
    local grey="8"
    local red="9"
    local magenta="13"
    local yellow="3"
    local blue="12"
    local cyan="14"

    local matrix_text_color="$red"


                                echo -e "\e[1;$matrix_text_colorm"
                                clear
                                while :
                                do
                                    echo "$LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 ))"
                                    sleep 0.05
                                done \
                                    | awk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4;        letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}'
}
