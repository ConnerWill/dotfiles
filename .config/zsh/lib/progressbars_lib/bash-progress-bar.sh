#!/bin/bash

progress_bar_speed=0.01
pause_before_time=0.15
pause_after_time=0.2

function percentage_progress_bar(){
    printf "This is a progress bar with \e[0;1;38;5;190mpercentage\e[0m\n"
    sleep $pause_before_time
    local bar
    bar=''
    for (( x=50; x <= 100; x++ )); do
        sleep $progress_bar_speed
        bar="${bar}="
        echo -ne "$bar ${x}%\r"
    done
    sleep $pause_after_time
    echo -ne "\e[2K" ## Clear line
    echo -ne "\e[1A" ## Move curser up 1 line
    echo -ne "\e[2K" ## Clear line
    echo -ne "\r"    ## Move cursor to beginning of line
}

function color_progress_bar(){
    printf "\e[0;38;5;255mThis is a progress bar with \e[0;1;38;5;201mcolor\e[0m\n"
    sleep $pause_before_time
    local left barr
    barr=''
    for (( y=50; y <= 100; y++ )); do
        sleep $progress_bar_speed
        barr="${barr} "
        echo -ne "\r\e[43m$barr\e[0m"
        left="$(( 100 - $y ))"
        printf " %${left}s"; echo -n "${y}%"
    done
    sleep $pause_after_time
    echo -ne "\e[2K" ## Clear line
    echo -ne "\e[1A" ## Move curser up 1 line
    echo -ne "\e[2K" ## Clear line
    echo -ne "\r"    ## Move cursor to beginning of line
}

function rainbow_progress_bar(){
    printf "\e[0;38;5;255mThis is a progress bar with \e[0;1;38;5;46mmore \e[0;1;38;5;93mcolor\e[0m\n"
    sleep $pause_before_time
    local left barr
    barr=''
    echo -ne "\e[?25l" # hide cursor
    for (( y=50; y <= 100; y++ )); do
        sleep $progress_bar_speed
        barr="${barr} "
        echo -ne "\r\e[48;5;${y}m$barr\e[0m"
        left="$(( 100 - y ))"
        printf " %${left}s"; echo -ne "\e[38;5;${left}m${y}%\e[0m"
    done
    echo -e "\e[?25h" ## Show cursor
    sleep $pause_after_time
    echo -ne "\e[2K" ## Clear line
    echo -ne "\e[1A"  ## Move curser up 1 line
    echo -ne "\e[2K"  ## Clear line
    echo -ne "\r"     ## Move cursor to beginning of line
}

function wide_rainbow_progress_bar(){
    printf "\e[0;38;5;255mThis is a progress bar with \e[0;1;38;5;46mmore \e[0;1;38;5;93mcolor\e[0m\n"
    sleep $pause_before_time
    local left barr
    barr=''
    echo -ne "\e[?25l" # hide cursor
    for (( y=$(( COLUMNS / 2 )); y <= COLUMNS; y++ )); do
        sleep $progress_bar_speed
        barr="${barr} "
        echo -ne "\r\e[48;5;${y}m$barr\e[0m"
        left="$(( 100 - y ))"
        printf " %${left}s"; echo -ne "\e[38;5;${left}m${y}%\e[0m"
    done
    echo -e "\e[?25h" ## Show cursor
    sleep $pause_after_time
    echo -ne "\e[2K" ## Clear line
    echo -ne "\e[1A"  ## Move curser up 1 line
    echo -ne "\e[2K"  ## Clear line
    echo -ne "\r"     ## Move cursor to beginning of line
}

percentage_progress_bar
color_progress_bar
rainbow_progress_bar
wide_rainbow_progress_bar
