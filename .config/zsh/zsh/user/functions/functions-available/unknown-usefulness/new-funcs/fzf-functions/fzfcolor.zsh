function fzfcolor () {

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
	local fg=#ffffff 
	local bg=#0f0f11 
	local previewbg=#202323 
	local promptpointer=#fc0505 
	local query=#f4e400 
	local infocolor=#0285f7 
	local hlplus=#66f400 
	local hl=#8c3f3f 
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


	fzf \
	    --extended \
	    --no-sort \
		--multi \
		--keep-right \
		--header-first \
        --header-lines=0 \
		--preview "bat --color=always --theme=Dracula {} 2&>/dev/null" \
        --preview-window "right:80%" \
        --height=90% \
        --margin 1% \
        --padding 1% \
        --border \
        --filepath-word \
        --info=inline \
        --prompt="> " \
        --pointer="[>" \
        --marker="✔ " \
        --tabstop=4 \
        --scroll-off=0  \
        --hscroll-off=100  \
        --ansi  \
        --color='bg:#1A1A1A,bg+:#333333,info:#999999,border:#999999,spinner:#F5F5F5'  \
        --color='hl+:#BD2C00,hl:#4078C0,fg:#C1C1C1,fg+:#FFFFFF,header:#666666,preview-bg:#333333'  \
        --color='header:#666666,query:#4183c4,pointer:#BD2C00,marker:#6CC644,prompt:#F5F5F5' \
        --color='gutter:#141414' \
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
}
