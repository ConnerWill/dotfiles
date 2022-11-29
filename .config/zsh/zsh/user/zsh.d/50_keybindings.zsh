#shellcheck disable=1072,1073,1123,2148
#######################################################################################
#   You may read this file into your .zshrc or another startup file with
#   the `source' or `.' commands, then reference the key parameter in bindkey commands,
#   like this:
#
#(or)    source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE
#(or)    source ${ZDOTDIR:-$HOME}/keybindings/$TERM-$VENDOR-$OSTYPE
#        [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
#        [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
#
#######################################################################################
## https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
## https://raw.githubusercontent.com/sorin-ionescu/prezto/master/modules/editor/init.zsh
## http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
## http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
## http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
#######################################################################################

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

### [=]===========================================================[=]
###	[~] ------------------- ZSH KEYBINDINGS ----------------------[~]
### [=]===========================================================[=]
[[ ! -o AUTOCD ]] || setopt autocd
#bindkey -e

typeset -g -A keyboardkeys
# Values are taken from terminfo. You don't need to change anything.
keyboardkeys=(
    Backspace "${terminfo[kbs]}"
    Insert    "${terminfo[kich1]}"
    Delete    "${terminfo[kdch1]}"
    Home      "${terminfo[khome]}"
    End       "${terminfo[kend]}"
    PageUp    "${terminfo[kpp]}"
    PageDown  "${terminfo[knp]}"
    Up        "${terminfo[kcuu1]}"
    Left      "${terminfo[kcub1]}"
    Down      "${terminfo[kcud1]}"
    Right     "${terminfo[kcuf1]}"
)
function bind2maps () {
    local map sequence widget
		local -a maps

		while [[ "${1}" != "--" ]]; do maps+=( "${1}" ); shift; done
    shift
    sequence="${keyboardkeys[${1}]}"
    widget="${2}"
    [[ -z "${sequence}" ]] && return 1
    for map in "${maps[@]}"; do bindkey -M "${map}" "${sequence}" "${widget}"; done
}

# If NumLock is off, translate keys to make them appear the same as with NumLock on.
bindkey -s '^[OM' '^M'  # enter
bindkey -s '^[Ok' '+'
bindkey -s '^[Om' '-'
bindkey -s '^[Oj' '*'
bindkey -s '^[Oo' '/'
bindkey -s '^[OX' '='

# If someone switches our terminal to application mode (smkx), translate keys to make
# them appear the same as in raw mode (rmkx).
bindkey -s '^[OH' '^[[H'  # home
bindkey -s '^[OF' '^[[F'  # end
bindkey -s '^[OA' '^[[A'  # up
bindkey -s '^[OB' '^[[B'  # down
bindkey -s '^[OD' '^[[D'  # left
bindkey -s '^[OC' '^[[C'  # right

# TTY sends different key codes. Translate them to regular.
bindkey -s '^[[1~' '^[[H'  # home
bindkey -s '^[[4~' '^[[F'  # end

bindkey '^?'      backward-delete-char          # bs         delete one char backward
bindkey '^[[3~'   delete-char                   # delete     delete one char forward
bindkey '^[[H'    beginning-of-line             # home       go to the beginning of line
bindkey '^[[F'    end-of-line                   # end        go to the end of line
bindkey '^[[1;5C' forward-word                  # ctrl+right go forward one word
bindkey '^[[1;5D' backward-word                 # ctrl+left  go backward one word
bindkey '^H'      backward-kill-word            # ctrl+bs    delete previous word
bindkey '^[[3;5~' kill-word                     # ctrl+del   delete next word
bindkey '^J'      backward-kill-line            # ctrl+j     delete everything before cursor
bindkey '^[[D'    backward-char                 # left       move cursor one char backward
bindkey '^[[C'    forward-char                  # right      move cursor one char forward
bindkey '^[[A'    up-line-or-beginning-search   # up         prev command in history
bindkey '^[[B'    down-line-or-beginning-search # down       next command in history









## Press 'CTRL-x-z' to display keybindings
# alias show-keybindings="echo Press  CTRL-x-z  to display keybindings."

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
# shellcheck disable=1009
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init(){ echoti smkx; }
    function zle-line-finish(){ echoti rmkx; }
    zle -N zle-line-init
		zle -N zle-line-finish
fi

if [[ -n "${DISPLAY}" ]]; then
function toggle-monitors(){
    local monitor_status monitor_action
    is-monitor-on(){
			xset q | grep 'Monitor is' | cut -d' ' -f5
		}
    monitor_status=$(is-monitor-on) ; unfunction is-monitor-on
    [[ "${monitor_status:l}" == "on"  ]] && monitor_action="off"
    [[ "${monitor_status:l}" == "off" ]] && monitor_action="on"
		xset dpms force "${monitor_action}"
  }
	zle -N toggle-monitors
	bindkey -M vicmd "^[[24;5~" toggle-monitors
fi

############################
# Emacs shift-select mode for Zsh - select text in the command line using Shift
# as in many text editors, browsers and other GUI programs.
# Homepage: <https://github.com/jirutka/zsh-shift-select>
# Move cursor to the end of the buffer. This is an alternative to builtin end-of-buffer-or-history.
function end-of-buffer() {
	CURSOR=${#BUFFER}
	zle end-of-line -w  # trigger syntax highlighting redraw
}; zle -N end-of-buffer

# Move cursor to the beginning of the buffer.
# This is an alternative to builtin beginning-of-buffer-or-history.
function beginning-of-buffer() {
	CURSOR=0
	zle beginning-of-line -w  # trigger syntax highlighting redraw
}; zle -N beginning-of-buffer

# Kill the selected region and switch back to the main keymap.
function shift-select::kill-region() {
	zle kill-region -w
	zle -K main
}; zle -N shift-select::kill-region

# Deactivate the selection region, switch back to the main keymap and process
# the typed keys again.
function shift-select::deselect-and-input() {
	zle deactivate-region -w
	zle -K main # Switch back to the main keymap (emacs).
	# Push the typed keys back to the input stack, i.e. process them again,
	# but now with the main keymap.
	zle -U "$KEYS"
}; zle -N shift-select::deselect-and-input


autoload -U transpose-lines
autoload -U transpose-words
autoload -U transpose-words-match
zle -N transpose-lines
zle -N transpose-words
zle -N transpose-words-match
bindkey -M vicmd gl transpose-lines
bindkey -M vicmd tw transpose-words
bindkey -M vicmd tm transpose-words-match

# If the selection region is not active, set the mark at the cursor position,
# switch to the shift-select keymap, and call $WIDGET without 'shift-select::'
# prefix. This function must be used only for shift-select::<widget> widgets.
function shift-select::select-and-invoke() {
	if (( !REGION_ACTIVE )); then
		zle set-mark-command -w
		zle -K shift-select
	fi
	zle ${WIDGET#shift-select::} -w
}

function {
	emulate -L zsh
	# Create a new keymap for the shift-selection mode.
	bindkey -N shift-select
	# Bind all possible key sequences to deselect-and-input, i.e. it will be used
	# as a fallback for "unbound" key sequences.
	bindkey -M shift-select -R '^@'-'^?' shift-select::deselect-and-input
	local kcap seq seq_mac widget

	# Bind Shift keys in the emacs and shift-select keymaps.
	for	kcap   seq          seq_mac    widget (
		kLFT   '^[[1;2D'    x          backward-char        # Shift + LeftArrow
		kRIT   '^[[1;2C'    x          forward-char         # Shift + RightArrow
		kri    '^[[1;2A'    x          up-line              # Shift + UpArrow
		kind   '^[[1;2B'    x          down-line            # Shift + DownArrow
		kHOM   '^[[1;2H'    x          beginning-of-line    # Shift + Home
		kEND   '^[[1;2F'    x          end-of-line          # Shift + End
		x      '^[[1;4D'    '^[[1;4D'  backward-word        # Shift + Alt + LeftArrow
		x      '^[[1;4C'    '^[[1;4C'  forward-word         # Shift + Alt + RightArrow
		x      '^[[1;4H'    '^[[1;4H'  beginning-of-buffer  # Shift + Alt + Home
		x      '^[[1;4F'    '^[[1;4F'  end-of-buffer        # Shift + Alt + End
	); do
			[[ "$OSTYPE" = darwin* && "$seq_mac" != x ]] && seq=$seq_mac
			zle 		-N shift-select::$widget shift-select::select-and-invoke
			bindkey -M emacs 				${terminfo[$kcap]:-$seq} shift-select::$widget
			bindkey -M shift-select ${terminfo[$kcap]:-$seq} shift-select::$widget
	done

	# Bind keys in the shift-select keymap.
	for	kcap   seq        widget (                          # key name
		kdch1  '^[[3~'    shift-select::kill-region           # Delete
		bs     '^?'       shift-select::kill-region           # Backspace
	); do
		bindkey -M shift-select ${terminfo[$kcap]:-$seq} $widget
	done
}

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
    bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
    bindkey -M viins "${terminfo[kpp]}" up-line-or-history
    bindkey -M vicmd "${terminfo[kpp]}" up-line
fi

# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
    bindkey -M emacs "${terminfo[knp]}" down-line-or-history
    bindkey -M viins "${terminfo[knp]}" down-line-or-history
    bindkey -M vicmd "${terminfo[knp]}" down-line
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
    bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcuu1]}" up-line
fi

# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
    bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcud1]}" down-line
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
    bindkey -M emacs "${terminfo[khome]}" beginning-of-line
    bindkey -M viins "${terminfo[khome]}" beginning-of-line
    bindkey -M vicmd "${terminfo[khome]}" beginning-of-line #beginning-of-buffer
fi

# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
    bindkey -M emacs "${terminfo[kend]}"    end-of-line
    bindkey -M viins "${terminfo[kend]}"    end-of-line
    bindkey -M vicmd "${terminfo[kend]}"    end-of-line #end-of-buffer-or-history
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
    bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
    bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
    bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char

# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
    bindkey -M emacs "${terminfo[kdch1]}" delete-char
    bindkey -M viins "${terminfo[kdch1]}" delete-char
    bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
    bindkey -M emacs "^[[3~" delete-char
    bindkey -M viins "^[[3~" delete-char
    bindkey -M vicmd "^[[3~" delete-char
    bindkey -M emacs "^[3;5~" delete-char
    bindkey -M viins "^[3;5~" delete-char
    bindkey -M vicmd "^[3;5~" delete-char
fi


# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word

# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

# [Esc-w] - Kill from the cursor to the mark
bindkey '\ew' kill-region

# [Esc-l] - run command: ls
bindkey -s '\el' 'ls\n'

# [Ctrl-r] - Search backward incrementally for a specified string.
# The string may begin with ^ to anchor the search to the beginning of the line.
# bindkey '^r' history-incremental-search-backward

# [Space] - don't do history expansion
bindkey ' ' magic-space

# [Ctrl-x Ctrl-e] - Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# [Alt-m] - file rename magick
bindkey "^[m" copy-prev-shell-word

# [Alt-3] - Toggle comments on current line
# If there is no `#` character at
# the beginning of the current line, add one.
# If there is one, remove it.
# The `INTERACTIVE_COMMENTS` option must be set for
# this to have any usefulness.
# ( See also pound-insert (unbound) (#) (unbound) )
bindkey -M emacs 	"^[3"	vi-pound-insert
bindkey -M viins 	"^[3"	vi-pound-insert
bindkey -M vicmd 	"gc" 	vi-pound-insert

bindkey -M vicmd 	"gg" 	beginning-of-buffer
bindkey -M vicmd 	"G"		end-of-buffer

if autoload -Uz surround >/dev/null 2>&1; then
	zle -N delete-surround surround
	zle -N add-surround surround
	zle -N change-surround surround
	bindkey -a 				"cs" change-surround
	bindkey -a 				"ds" delete-surround
	bindkey -a 				"ys" add-surround
	bindkey -M visual "S" add-surround
fi

# [Alt-#] -
bindkey "^[#" push-input

# Fuzzy Find suggestions fix
# start typing + [Up-Arrow] - fuzzy find history forward
# if [[ "${terminfo[kcuu1]}" != "" ]]; then
#   autoload -U up-line-or-beginning-search
#   zle -N up-line-or-beginning-search
#   bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
# fi
# # start typing + [Down-Arrow] - fuzzy find history backward
# if [[ "${terminfo[kcud1]}" != "" ]]; then
#   autoload -U down-line-or-beginning-search
#   zle -N down-line-or-beginning-search
#   bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
# fi

### zsh-change-case
# I recomend you to use the following bindkeys
#* Ctrl+K + Ctrl+U to uppercase
#* Ctrl+K + Ctrl+L to lowercase
# bindkey '^K^U' _mtxr-to-upper # Ctrl+K + Ctrl+U
# bindkey '^K^L' _mtxr-to-lower # Ctrl+K + Ctrl+L
#In case of trouble, you probably need to unbind Ctrl+K</kbd>. Just add this before the bindings you will use:
#bindkey -r '^K'
## This is a very simple plugin that binds Ctrl+h to navigating up a directory.
## It is now very easy to go up a few directories without having to type any commands.
PROG='@a = split " ";
print join " ", @a[0..($#a-1)];
if (rindex($a[$#a], "/") != -1) {
  if (scalar @a > 1) { print " "; }
  @b = split "/", $a[$#a];
  print join "/", @b[0..($#b-1)]
}'

function _up-dir {
  if [ -z $BUFFER ]; then
    parent="$(dirname $(pwd))"
    cd $parent
    zle reset-prompt
  else
    BUFFER=$(echo $BUFFER | perl -ne $PROG)
  fi
}

zle -N _up-dir
bindkey "^h" _up-dir

# function dotf-widget(){ d otf status; }
function vicmdZZ(){ zle kill-region -w; reset-prompt; }
function vi-exit(){ exit; }
zle -N vi-exit; zle -N vicmdZZ

bindkey -M vicmd 	"ZZ" vicmdZZ
bindkey -M vicmd "ZQ" vi-exit

## <BS> in vi mode does not erase
bindkey -M vicmd  "^?" vi-backward-char

# Remove bindings to ctrl+r
bindkey -r '^r'

# <M-g> dotf status
bindkey -M viins -s '^[g' 'dotf status\n'

## Key binds like those used in graphic file managers may come handy.
## The first comes back in directory history (Alt+Left),
## the second let the user go to the parent directory (Alt+Up).
## They also display the directory content.
cdPreviousDir() {
  popd; zle reset-prompt; print
  ls;   zle reset-prompt
}; zle -N cdPreviousDir

cdParentDir() {
  pushd ..; zle reset-prompt; print
  ls;       zle reset-prompt
}; zle -N cdParentDir

# cdPreviousDir() {
#   popd; zle reset-prompt; print
#   ls;   zle reset-prompt
# }; zle -N cdPreviousDir

bindkey '^[[1;3A'      cdParentDir
bindkey '^[[1;3D'      cdPreviousDir


bindkey -M vicmd "^[[B" down-line
bindkey -M vicmd "^[[A" up-line


bindkey -M viins '^[j' which-command

[[ -n ${functions[run-help]} ]] && bindkey '^[h' run-help
