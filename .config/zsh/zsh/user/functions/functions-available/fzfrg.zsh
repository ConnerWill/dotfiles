#shellcheck disable=2148,2283
#=======================================================================================
function fzfrg() {
	# ===============================
	#		KEYS
	# -------------------------------
	#    ctrl-e: Edit with $EDITOR
	#    ctrl-v: View with $ECHOCMD
	#    ctrl-p: View with $PAGER
	# -------------------------------
	# ===============================
	#🖧
	#🦠
	STRING_PROMPT="🖳  﫦"
	STRING_POINTER="🦠"
	STRING_HEADER="    "
	# ===============================
	#    	     Color Config
	# ===============================
	COLOR_BG='#0e1224'
	COLOR_BGP='#181d31'

	# COLOR_FG='#98a0c5'
  # COLOR_FG='#898fbc'
  # COLOR_FG='#676f9a'
	# COLOR_FG='#565f89'
	# COLOR_FG='#454e78'
  COLOR_FG='#323a5c'
	# COLOR_FG='#2a3150'
	COLOR_FGP='#00FFFF'

	COLOR_PREVIEW_FG='#c0caf5'
	COLOR_PREVIEW_BG='#202646'


	COLOR_INFO='#00FFFF'
	COLOR_HL='#cf04fa' #fb3b4b' #EE004F #AA00FF
	COLOR_HLP='#53FFAD' #4eff6a #FF00FF
	COLOR_HEADER='#0077FF'
	COLOR_POINTER='#53FFAD'
	COLOR_MARKER='#00FF00'
	COLOR_PROMPT='#AA00FF'

    #
    # none = "NONE",
    # bg_dark = "#0e1224", -- Color of side panels
    # bg = "#13172a", -- Main background color
    # bg_highlight = "#181d31",
    # terminal_black = "#202646",
    # fg = "#c0caf5", -- plain text color
    # fg_dark = "#98a0c5",
    # fg_gutter = "#2a3150",
    # dark3 = "#323a5c",
    # comment = "#454e78",
    # dark5 = "#404770",
    # blue0 = "#1a59f1",
    # blue = "#75a2f7",
    # cyan = "#7dffff",
    # blue1 = "#1ac3ff",
    # blue2 = "#5fb9e7",
    # blue5 = "#409aff",
    # blue6 = "#a4c9Fa",
    # blue7 = "#114bb0", -- select highlight bg color
    # magenta = "#cf04fa",
    # magenta2 = "#ed0eee",
    # purple = "#9923ff",
    # orange = "#ff9e54",
    # yellow = "#c9eb20",
    # green = "#4eff6a", -- select highlight fg color
    # green1 = "#73e0aa", -- Green text color #73ddaa
    # green2 = "#41b6a5",
    # teal = "#18a7b5", -- #0abc9c
    # red = "#ff7690",
    # red1 = "#fb3b4b",
    # git = { change = "#6183bb", add = "#449dab", delete = "#914c54", conflict = "#bb7a61" },
    # gitSigns = { add = "#164846", change = "#394b70", delete = "#823c41" },
    # colors.bg = "#1a1b26"
    # colors.bg_dark = "#16161e"
	# ===============================
	#		  Localize Variableles
	# ===============================
	local CATCMD ECHOCMD RG_PREFIX FZF_DEFAULT_COMMAND INITIAL_QUERY
	# ===============================
	# 	         Commands
	# ===============================
	CATCMD="bat --color=always --paging=never --plain --terminal-width 100"
	ECHOCMD="echo"
	PAGER="less"
	EDITOR="nvim"
	# ===============================
	# 	     Test Variables
	# ===============================
	[[ -z "$EDITOR" ]]  \
		&& EDITOR="nvim"
	
	[[ -z "$CATCMD" ]] \
		&& CATCMD="cat"

	[[ -z "$ECHOCMD" ]] \
		&& ECHOCMD="echo"
	
	[[ -z "$PAGER" ]] \
		&& PAGER="less"
	
#>/dev/null 2>&1

	INITIAL_QUERY=""
	RG_PREFIX="rg --hidden --colors 'match:style:underline' --colors 'match:style:bold' --colors 'match:fg:yellow' --colors 'match:style:intense' --colors 'line:fg:blue' --colors 'column:fg:blue' --colors 'path:style:bold' --colors 'path:style:intense' --colors 'path:fg:white' --no-line-number --no-heading --color=always --smart-case  --with-filename"
	#RG_PREFIX="rg --column --hidden --colors 'match:style:underline' --colors 'match:style:bold' --colors 'match:style:intense' --colors 'line:fg:blue' --colors 'column:fg:blue' --line-number --no-heading --color=always --smart-case "
	FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'"
	# ===============================
	#		          Run FZF
	# ===============================
		# --preview-window hidden \
		# --preview-window='right' \
	fzf \
		--multi \
		--ansi \
		--delimiter=":" \
		--preview "${CATCMD} {1} 2>/dev/null"\
		--preview-window hidden \
		--color=bg:${COLOR_BG},bg+:${COLOR_BGP},info:${COLOR_INFO} \
		--color=hl:${COLOR_HL},fg:${COLOR_FG},header:${COLOR_HEADER},fg+:${COLOR_FGP} \
		--color=pointer:${COLOR_POINTER},marker:${COLOR_MARKER} \
		--color=prompt:${COLOR_PROMPT},hl+:${COLOR_HLP} \
		--color=preview-fg:${COLOR_PREVIEW_FG},preview-bg:${COLOR_PREVIEW_BG} \
		--bind "change:reload:${RG_PREFIX} {q} || true" \
		--bind "ctrl-p:execute(${PAGER} {1})" \
		--bind 'ctrl-/:toggle-preview' \
		--bind 'pgdn:preview-page-down'  \
		--bind 'pgup:preview-page-up'  \
		--bind 'home:last'  \
		--bind 'end:first'  \
		--bind "ctrl-e:execute(${EDITOR} {1})" \
		--prompt "${STRING_PROMPT}" \
		--header "${STRING_HEADER}" \
		--pointer "${STRING_POINTER}" \
		--query "${INITIAL_QUERY}"
}

#=======================================================================================
#
#	fzf \
#		--multi \
#		--ansi \
#		--color='bg:#090909,bg+:#202020,info:#BDBB72' \
#		--color='hl:#EE004F,fg:#D9D9D9,header:#012345,fg+:#FFFFFF' \
#		--color='pointer:#53FFAD,marker:#00FF00' \
#		--color='prompt:#98BEDE,hl+:#1AFF7F' \
#		--bind "change:reload:${RG_PREFIX} {q} || true" \
#		--bind "ctrl-p:execute(${PAGER} {})" \
#		--bind "ctrl-v:toggle:preview:${ECHOCMD} {}" \
#		--bind "ctrl-e:execute(${EDITOR} {})" \
#		--preview-window hidden \
#		--query "${INITIAL_QUERY}"
#}
