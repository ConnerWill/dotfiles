#shellcheck disable=2148,2283
#=======================================================================================
function fzfrg() {
  ## Check depends
	[[ -z "${commands[rg]}"  ]] && printf "\e[0;1;38;5;196mCommand not found:\t%s\n" "rg"  >&2 && return 1
	[[ -z "${commands[fzf]}" ]] && printf "\e[0;1;38;5;196mCommand not found:\t%s\n" "fzf" >&2 && return 1

	# ===============================
	#		KEYS
	# -------------------------------
	#    ctrl-e: Edit with $EDITOR
	#    ctrl-v: View with $ECHOCMD
	#    ctrl-p: View with $PAGER
	# -------------------------------
	# ===============================
	 STRING_PROMPT="🖳  﫦"
	STRING_POINTER="🦠"
   STRING_HEADER="    "
	# ===============================
	#    	     Color Config
	# ===============================
          COLOR_BG='#0E1224'        COLOR_BGP='#181D31'
          COLOR_FG='#BBBBBB'        COLOR_FGP='#00FFFF'
          # COLOR_FG='#323A5C'        COLOR_FGP='#00FFFF'
  COLOR_PREVIEW_FG='#C0CAF5' COLOR_PREVIEW_BG='#202646'
      COLOR_BORDER='#8800EE'       COLOR_INFO='#00FFFF'
          COLOR_HL='#CF04FA'        COLOR_HLP='#53FFAD'
      COLOR_PROMPT='#AA00FF'     COLOR_HEADER='#0077FF'
     COLOR_POINTER='#53FFAD'     COLOR_MARKER='#00FF00'

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

  EDITOR="${EDITOR:-${commands[nvim]:-${commands[vim]}}}"
  PAGER="${PAGER:-${commands[bat]:-${commands[less]:-cat}}}"
  CAT="${CAT:-${commands[bat]:-${commands[cat]}}}"
  ECHOCMD="${ECHOCMD:-echo}"
  local EDITOR CAT PAGER ECHOCMD

  INITIAL_QUERY="${*}"

	RG_PREFIX="rg --hidden --colors 'match:style:underline' --colors 'match:style:bold' --colors 'match:fg:yellow' --colors 'match:style:intense' --colors 'line:fg:blue' --colors 'column:fg:blue' --colors 'path:style:bold' --colors 'path:style:intense' --colors 'path:fg:white' --no-line-number --no-heading --color=always --smart-case  --with-filename"

	#RG_PREFIX="rg --hidden --line-number --colors 'path:style:bold' --colors 'path:style:intense' --colors 'path:fg:gray' --colors 'match:style:underline' --colors 'match:style:bold' --colors 'match:fg:yellow' --colors 'match:style:intense' --colors 'line:fg:blue' --colors 'column:fg:blue' --no-heading --color=always --with-filename --iglob '*.cache*' --iglob '*cache*' --iglob '.cache' --iglob '*.bak' --iglob '*history*' --iglob '*history' --iglob '*compdump*' --iglob '*compcache*' --engine=auto --trim --smart-case"
	#RG_PREFIX="rg --column --hidden --colors 'match:style:underline' --colors 'match:style:bold' --colors 'match:style:intense' --colors 'line:fg:blue' --colors 'column:fg:blue' --line-number --no-heading --color=always --smart-case "

	FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'"
	# ===============================
	#		          Run FZF
	# ===============================
  tput smcup
  clear
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
		--color=border:${COLOR_BORDER} \
		--color=preview-fg:${COLOR_PREVIEW_FG},preview-bg:${COLOR_PREVIEW_BG} \
		--bind "change:reload:${RG_PREFIX} '{q}' || true" \
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

   tput rmcup
	}
#=======================================================================================
