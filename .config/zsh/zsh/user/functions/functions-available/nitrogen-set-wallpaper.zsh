#!/bin/bash

function nitrogen-set-wallpaper(){
    local wallpaper_dir="${HOME}/pictures/wallpaper"
    [[ -z "${DISPLAY}" ]] && print "You are not in an X11 session!\n" && return 1
    command -v nitrogen >/dev/null 2>1 && print "Cannot find 'nitrogen' in your PATH!\n" && return 1
    [[ ! -d "${wallpaper_dir}" ]] && print "'%s' is not a directory!\n" "${wallpaper_dir}" && return 1
    sleep 1; nitrogen --set-tiled "${wallpaper_dir/Backgrounds/Night-Bridge.jpg}"
    sleep 1; nitrogen --set-tiled "${wallpaper_dir/space-wallpaper/deepspace/deepspace2.jpg}"
    sleep 1; nitrogen --set-tiled "${wallpaper_dir/Backgrounds/black-wallpaper.jpg}"
}
