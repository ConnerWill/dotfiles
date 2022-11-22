#!/bin/bash

# Source progress bar
source ./progress_bar.sh
#
# [[ -d $PWD/temp-deletethis ]] || rm -rvf $PWD/temp-deletethis



generate_some_output_and_sleep() {
    # [[ -d /tmp/temp-deletethis ]] || mkdir -pv $PWD/temp-deletethis
    ls -la $HOME
    # head -c 10000 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-' > $PWD/temp-deletethis/$1
    # cat $PWD/temp-deletethis/$1
    #
    # echo "Here is some output"
    # head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-'
    # head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-'
    # head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-'
    # head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-'
    echo -e "\n\n------------------------------------------------------------------"
    echo -e "\n\n Now sleeping briefly \n\n"
    sleep 0.1
}


main() {
    # Make sure that the progress bar is cleaned up when user presses ctrl+c
    enable_trapping
    # Create progress bar
    setup_scroll_area
    for i in {1..99}
    do
        if [ $i = 50 ]; then
            echo "waiting for user input"
            block_progress_bar $i
            read -p "User input: "
        else
            generate_some_output_and_sleep $i
            draw_progress_bar $i
        fi
    done
    destroy_scroll_area
}

main
