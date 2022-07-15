
function fzfcolor(){
	## ---------------------------------------------------------------
	## 			Formatting Definitions
	## ---------------------------------------------------------------
	# -  margin		%
	# -  padding		%
	#
	# -  border
	#	rounded     	Border with rounded corners (default)
	#	sharp       	Border with sharp corners
	#	horizontal  	Horizontal lines above and below the finder
	#	vertical    	Vertical lines on each side of the finder
	#	top
	#	bottom
	#	left
	#	right
	#	none
	#
	# -  layout
	#	default       	Display from the bottom of the screen
	#	reverse       	Display from the top of the screen
	#	reverse-list  	Display from the top of the screen, prompt at the bottom
	#
	# -  info
	#	default       	Display on the next line to the prompt
	#	inline        	Display on the same line
	#	hidden        	Do not display finder info
	## ---------------------------------------------------------------


	## ---------------------------------------------------------------
	## 			Color Definitions
	## ---------------------------------------------------------------
	# -  fg         	Text
	# -  bg         	Background
	# -  preview-fg 	Preview window text
	# -  preview-bg 	Preview window background
	# -  hl         	Highlighted substrings
	# -  fg+        	Text (current line)
	# -  bg+        	Background (current line)
	# -  gutter     	Gutter on the left (defaults to bg+)
	# -  hl+        	Highlighted substrings (current line)
	# -  query      	Query string
	# -  disabled   	Query string when search is disabled
	# -  info       	Info line (match counters)
	# -  border     	Border around the window (--border and --preview)
	# -  prompt     	Prompt
	# -  pointer    	Pointer to the current line
	# -  marker     	Multi-select marker
	# -  spinner    	Streaming input indicator
	# -  header     	Header
	## ---------------------------------------------------------------


	## ---------------------------------------------------------------
	## 			Keybinding Definitions
	## ---------------------------------------------------------------
	# - See man fzf
	## ---------------------------------------------------------------


	## ---------------------------------------------------------------
	##			  Define Variables
	## ---------------------------------------------------------------

	tiebreak="end"

	## Define formatting
	margin="1"
	padding="1"
	border=horizontal
	layout=default
	infostring=default

	borderprompt='🔎 '
	pointer='⮀'
	marker="»"
	header="Fuzzy Search"

	## Define colors
	fg=#ffffff
	bg=#0f0f11
	previewbg=#202323
	promptpointer=#fc0505
	query=#f4e400
	infocolor=#0285f7
	hlplus=#66f400
	hl=#8c3f3f

	## Define Keybindings
	ctrlA="select-all"
	ctrlD="deselect-all"
	# ctrlE=""
	# ctrlC=""
	# ctrlH=""
	# ctrlO=""
	ctrlP="toggle-preview"
	# ctrlQ=""
	ctrlR="replace-query"
	# ctrlT=""
	# ctrlV=""
	# ctrlX=""
	altEnter="execute(read -p 'Run script?' answer && bash {})"
	enter="execute(bat --color=always --paging=always {})"
	home="preview-top"
	end="preview-bottom"
	ctrlSpace="select"
	escape="cancel"
	## ---------------------------------------------------------------
	## 			'fzf' Command
	## ---------------------------------------------------------------
	## ===============================================================

	fzf \
		--margin $margin% \
		--padding $padding% \
		--border=$border \
		--prompt=$borderprompt \
		--pointer=$pointer \
		--marker=$marker \
		--header=$header \
		--color "fg:$fg,bg:$bg,preview-bg:$previewbg,prompt:$promptpointer,query:$query,info:$infocolor,hl+:$h1plus,hl:$hl" \
		--tiebreak=$tiebreak \
		--preview "bat --color=always {}" \
		--multi --bind "ctrl-a:$ctrlA" \
		--multi --bind "ctrl-d:$ctrlD" \
		--multi --bind "ctrl-p:$ctrlP" \
		--multi --bind "ctrl-r:$ctrlR" \
		--multi --bind "enter:$enter" \
		--multi --bind "alt-enter:$altEnter" \
		--multi --bind "home:$home" \
		--multi --bind "end:$end" \
		--multi --bind "ctrl-space:$ctrlSpace" \
		--multi --bind "esc:$escape"



	## ===============================================================
	# ---------------------------------------------------------------


	## ---------------------------------------------------------------
	##			  Unset Variables
	## ---------------------------------------------------------------

	## Unset formatting
	unset margin
	unset padding
	unset border
	unset layout
	unset info

	## Unset colors
	unset fg
	unset bg
	unset previewbg
	unset promptpointer
	unset query
	unset info
	unset hlplus
	unset hl

	## Unset keybindings
	unset ctrlA
	unset ctrlP
	unset ctrlR
	unset enter
	unset home
	unset end
	unset ctrlSpace
	unset escape

	## ---------------------------------------------------------------

}
