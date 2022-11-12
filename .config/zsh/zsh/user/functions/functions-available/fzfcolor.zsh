
#shellcheck disable=2148,2283
function fzfcolor () {

   STRING_PROMPT="🖳  﫦"
	STRING_POINTER="🦠"
   STRING_HEADER="    "

	# ===============================
	#    	     Color Config
	# ===============================
          COLOR_BG='#0E1224'        COLOR_BGP='#181D31'
          COLOR_FG='#323A5C'        COLOR_FGP='#00FFFF'
  COLOR_PREVIEW_FG='#C0CAF5' COLOR_PREVIEW_BG='#202646'
      COLOR_BORDER='#8800EE'       COLOR_INFO='#00FFFF'
          COLOR_HL='#CF04FA'        COLOR_HLP='#53FFAD'
      COLOR_PROMPT='#AA00FF'     COLOR_HEADER='#0077FF'
     COLOR_POINTER='#53FFAD'     COLOR_MARKER='#00FF00'


typeset -a COLOR_SCHEME
    # COLOR_SCHEME[0]='bg:${COLOR_BG},bg+:${COLOR_BGP},info:${COLOR_INFO},hl:${COLOR_HL},fg:${COLOR_FG},header:${COLOR_HEADER},fg+:${COLOR_FGP},pointer:${COLOR_POINTER},marker:${COLOR_MARKER},prompt:${COLOR_PROMPT},hl+:${COLOR_HLP},border:${COLOR_BORDER},preview-fg:${COLOR_PREVIEW_FG},preview-bg:${COLOR_PREVIEW_BG}'
    # COLOR_SCHEME[1]='fg:#00FFFF,bg:#101010,hl:#4909bb,hl+:#ff00ff,preview-fg:#ffffff,preview-bg:#020202,gutter:#000000,header:#666666,border:#900aff'
	  # COLOR_SCHEME[2]='hl:#00ffff,hl+:#ff00ff,fg:#505050,fg+:#00ffff,bg:#010101,bg+:#202020,query:#00ff00,info:#9090a0,spinner:#ff00ff,border:#ff00ff,preview-fg:#ffffff,preview-bg:#200050,gutter:#101010,pointer:#ff00ff,info:#020202'
	  COLOR_SCHEME='hl:#00ffff,hl+:#ff00ff,fg:#505050,fg+:#00ffff,bg:#010101,bg+:#202020,query:#00ff00,info:#9090a0,spinner:#ff00ff,border:#ff00ff,preview-fg:#ffffff,preview-bg:#200050,gutter:#101010,pointer:#ff00ff,info:#020202'
    # size=${#array[@]}
    # index=$((RANDOM % size))
    # COLOR_SCHEME=${array[$index]}

    INITIAL_QUERY="${*}"
	local tiebreak="end"
	local margin="1"
	local padding="1"
	local border=horizontal
	local layout=default
	local infostring=default
	local borderprompt="[:"
	local pointer="[>"
	local marker="*]"
	local header="fzf search"
	local ctrlA="select-all"
	local ctrlD="deselect-all"
	local ctrlP="toggle-preview"
	local ctrlR="replace-query"
	local altEnter="execute(read -p 'Run script?' answer && bash {})"
	local enter="execute(bat --color=always --paging=always {})"
	local home="preview-top"
	local end="preview-bottom"
	local ctrlSpace="select"
	local escape="cancel"

   tput smcup
   clear
	fzf \
	    --extended \
	    --no-sort \
		--multi \
		--keep-right \
		--header-first \
        --header-lines=0 \
		--preview "bat --color=always {} 2&>/dev/null" \
        --preview-window "right:80%" \
        --height=90% \
        --margin 1% \
        --padding 1% \
        --border \
        --filepath-word \
        --info=inline \
    		--prompt "${STRING_PROMPT}" \
		  --header "${STRING_HEADER}" \
		  --pointer "${STRING_POINTER}" \
		  --query "${INITIAL_QUERY}" \
        --tabstop=2 \
        --scroll-off=0  \
        --hscroll-off=100  \
        --ansi  \
        --color="${COLOR_SCHEME}" \
        --bind 'pgdn:preview-page-down'  \
        --bind 'pgup:preview-page-up'  \
        --bind 'shift-up:preview-top'  \
        --bind 'shift-down:preview-bottom'  \
        --bind 'home:last'  \
        --bind 'end:first'  \
        --bind 'ctrl-y:yank'  \
        --bind 'backward-eof:change-preview-window(hidden)'  \
        --bind 'ctrl-l:clear-query'  \
        --bind 'tab:select'  \
        --bind 'ctrl-v:toggle-preview'  \
        --bind 'ctrl-/:change-preview-window(up,border-horizontal|up,40%,border-horizontal|left|left,border-left,40%|down|down,40%,border-horizontal|down,10%,border-horizontal|hidden|right,40%|right,70%|right,90%)' \
        --bind 'ctrl-space:select'  \
        --bind 'ctrl-a:select-all'  \
        --bind 'ctrl-d:deselect-all'  \
        --bind 'ctrl-e:execute($EDITOR {})'  \
    	--bind "enter:execute(bat --color=always --paging=always {} &>/dev/null &)"  \
		--bind "esc:accept-non-empty"

   tput rmcup
}
