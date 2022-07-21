function _nitrogen_set_wallpaper(){
    local wallpaper_dir="$HOME/pictures/wallpaper"

    nitrogen --set-tiled "$wallpaper_dir/Backgrounds/Night-Bridge.jpg"
    sleep 1
    
    nitrogen --set-tiled "$wallpaper_dir/space-wallpaper/deepspace/deepspace2.jpg"
    sleep 1

    nitrogen --set-tiled "$wallpaper_dir/Backgrounds/black-wallpaper.jpg"

}
alias nitrogen-set-wallpaper="_nitrogen_set_wallpaper"
