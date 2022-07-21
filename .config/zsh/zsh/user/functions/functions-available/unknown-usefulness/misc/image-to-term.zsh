#function ImageToTerminal () {
#
#	# Define path to image
#	ImageToConvert=$HOME/pictures/wallpaper/camaroZ28/MidnightPark_vinette.png
#
#
#	termi --width 50 --height 50 --depth 24 # Define settings
#	resizeWidthFactor=2
#	resizeHeightFactor=2
#	Depth=24
#	width=$(tput cols) ## Measure size of terminal
#	height=$(tput lines)
#	resizedWidth=$((width / resizeWidthFactor)) # Resize dimensions based on window size
#	resizedHeight=$((height / resizeWidthFactor))
##	clear
#	termi --scale lanczos --width $resizedWidth --height $resizedHeight --depth $Depth "$ImageToConvert" # Convert image to terminal image
#	unset resizeHeightFa
#	unset resizeWidthFactor
#	unset resizeHeightFactor
#	unset Depth
#	unset width
#	unset height
#	unset resizedWidth
#	unset resizedHeight
#
#}
