

function typeclipboard(){

	xclip -selection clipboard -out \
		| tr \\n \\r \
		| xdotool selectwindow windowfocus type \
			--clearmodifiers \
			--delay 25 \
			--window %@ \
			--file -
}
