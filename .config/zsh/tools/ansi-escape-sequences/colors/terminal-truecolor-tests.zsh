
function check-if-truecolor(){
clear
awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'
###
printf "\t\t\t\t\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n"
###
printf "\t\t\t\t\x1b[38;5;24;100;48;2;77;37;200mTRUECOLOR\x1b[0m\n"
awk 'BEGIN{
    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
    for (colnum = 0; colnum<77; colnum++) {
        r = 255-(colnum*255/76);
        g = (colnum*510/76);
        b = (colnum*255/76);
        if (g>255) g = 510-g;
        printf "\033[48;2;%d;%d;%dm", r,g,b;
        printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
        printf "%s\033[0m", substr(s,colnum+1,1);
    }
    printf "\n";
}'
}








                        #
                        # case $TERM in
                        #   iterm            |\
                        #   linux-truecolor  |\
                        #   screen-truecolor |\
                        #   tmux-truecolor   |\
                        #   xterm-truecolor  )    export COLORTERM=truecolor ;;
                        #   vte*)
                        # esac
                        #
                        #
