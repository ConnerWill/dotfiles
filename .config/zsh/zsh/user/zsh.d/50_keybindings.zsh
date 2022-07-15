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


###     [=]===========================================================[=]
### 	[~] ------------------- ZSH KEYBINDINGS ----------------------[~]
###     [=]===========================================================[=]

setopt autocd
bindkey -e

## Press 'CTRL-x-z' to display keybindings
alias show-keybindings="echo Press  CTRL-x-z  to display keybindings."

# keybindings.zsh

# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
# https://raw.githubusercontent.com/sorin-ionescu/prezto/master/modules/editor/init.zsh
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
        echoti smkx
    }
    function zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi


############################
# Emacs shift-select mode for Zsh - select text in the command line using Shift
# as in many text editors, browsers and other GUI programs.
#
# Version: 0.1.1
# Homepage: <https://github.com/jirutka/zsh-shift-select>

# Move cursor to the end of the buffer.
# This is an alternative to builtin end-of-buffer-or-history.
function end-of-buffer() {
	CURSOR=${#BUFFER}
	zle end-of-line -w  # trigger syntax highlighting redraw
}
zle -N end-of-buffer

# Move cursor to the beginning of the buffer.
# This is an alternative to builtin beginning-of-buffer-or-history.
function beginning-of-buffer() {
	CURSOR=0
	zle beginning-of-line -w  # trigger syntax highlighting redraw
}
zle -N beginning-of-buffer

# Kill the selected region and switch back to the main keymap.
function shift-select::kill-region() {
	zle kill-region -w
	zle -K main
}
zle -N shift-select::kill-region

# Deactivate the selection region, switch back to the main keymap and process
# the typed keys again.
function shift-select::deselect-and-input() {
	zle deactivate-region -w
	# Switch back to the main keymap (emacs).
	zle -K main
	# Push the typed keys back to the input stack, i.e. process them again,
	# but now with the main keymap.
	zle -U "$KEYS"
}
zle -N shift-select::deselect-and-input

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
	for	kcap   seq          seq_mac    widget (             # key name
		kLFT   '^[[1;2D'    x          backward-char        # Shift + LeftArrow
		kRIT   '^[[1;2C'    x          forward-char         # Shift + RightArrow
		kri    '^[[1;2A'    x          up-line              # Shift + UpArrow
		kind   '^[[1;2B'    x          down-line            # Shift + DownArrow
		kHOM   '^[[1;2H'    x          beginning-of-line    # Shift + Home
		kEND   '^[[1;2F'    x          end-of-line          # Shift + End
#		x      '^[[97;6u'   x          beginning-of-line    # Shift + Alt + A
#		x      '^[[101;6u'  x          end-of-line          # Shift + Alt + E
		x      '^[[1;4D'    '^[[1;4D'  backward-word        # Shift + Alt + LeftArrow
		x      '^[[1;4C'    '^[[1;4C'  forward-word         # Shift + Alt + RightArrow
		x      '^[[1;4H'    '^[[1;4H'  beginning-of-buffer  # Shift + Alt + Home
		x      '^[[1;4F'    '^[[1;4F'  end-of-buffer        # Shift + Alt + End
	); do
		# Use alternative sequence (Option instead of Ctrl) on macOS, if defined.
		[[ "$OSTYPE" = darwin* && "$seq_mac" != x ]] && seq=$seq_mac

		zle -N shift-select::$widget shift-select::select-and-invoke
		bindkey -M emacs ${terminfo[$kcap]:-$seq} shift-select::$widget
		bindkey -M shift-select ${terminfo[$kcap]:-$seq} shift-select::$widget
	done

	# Bind keys in the shift-select keymap.
	for	kcap   seq        widget (                          # key name
		kdch1  '^[[3~'    shift-select::kill-region         # Delete
		bs     '^?'       shift-select::kill-region         # Backspace
	); do
		bindkey -M shift-select ${terminfo[$kcap]:-$seq} $widget
	done
}
############################



# Use emacs key bindings
#bindkey -e

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
    bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
    bindkey -M viins "${terminfo[kpp]}" up-line-or-history
    bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
    bindkey -M emacs "${terminfo[knp]}" down-line-or-history
    bindkey -M viins "${terminfo[knp]}" down-line-or-history
    bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search

    bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search

    bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
    bindkey -M emacs "${terminfo[khome]}" beginning-of-line
    bindkey -M viins "${terminfo[khome]}" beginning-of-line
    bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
    bindkey -M emacs "${terminfo[kend]}"    end-of-line
    bindkey -M viins "${terminfo[kend]}"    end-of-line
    bindkey -M vicmd "${terminfo[kend]}"    end-of-line
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
bindkey '^r' history-incremental-search-backward

# [Space] - don't do history expansion
bindkey ' ' magic-space


# [Ctrl-x Ctrl-e] - Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# [Alt-m] - file rename magick
bindkey "^[m" copy-prev-shell-word


# [Alt-3] - Toggle comments on current line
# If there is no `#` character at the beginning of the current line, add one. If
# there is one, remove it. The `INTERACTIVE_COMMENTS` option must be set for
# this to have any usefulness. ( See also pound-insert (unbound) (#) (unbound) )
bindkey -M viins "^[3" vi-pound-insert
bindkey -M emacs "^[3" vi-pound-insert
bindkey -M vicmd "^[3" vi-pound-insert

# [Alt-#] - 
bindkey "^[#" push-input

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


# Keyboard shortcut problems
#
# Example:
#
# bindkey '^L' clear-screen
#
# Two main things could go wrong:
#
#     The key sequence (^L in the example) does not match the key sequence being sent to the terminal:
#
#     You can see the exact sequence a keyboard shortcut sends by pressing CTRL+V and then the keyboard shortcut. For example: CTRL+V, CTRL+L will output ^L (^ represents the Control key).
#
#     The command executed (clear-screen in the example) has an error. In that case, post both the key binding and the definition of the command (if exists) like so:
#
#         key binding: bindkey '^[[1;6D'
#         will print "^[[1;6D" insert-cycledleft
#
#         command definition: which insert-cycledleft
#         will print insert-cycledleft () { ... }
#
#         Notice that sometimes the command is a builtin zle widget and so the which command won't work. If that's the case, just post the key binding and we'll figure it out.
#






### Prepend text example
  ## Prepend 'nvim' to buffer if it currently doesnt contain 'nvim'
  #  prepend-nvim() {
  #    if [[ $BUFFER != "nvim "* ]]; then
  #      BUFFER="nvim $BUFFER"; CURSOR+=5
  #    fi
  #  }
  #  zle -N prepend-nvim
  ## Now assign widget to a key; in this example 'Alt+e'
  #  bindkey "^[e" prepend-vim










#    USER-DEFINED WIDGETS
#           User-defined widgets, being implemented as shell functions, can execute any normal  shell  com‐
#           mand.  They can also run other widgets (whether built-in or user-defined) using the zle builtin
#           command. The standard input of the function is redirected from /dev/null  to  prevent  external
#           commands from unintentionally blocking ZLE by reading from the terminal, but read -k or read -q
#           can be used to read characters.  Finally, they can examine and edit the ZLE buffer being edited
#           by reading and setting the special parameters described below.
#
#           These  special parameters are always available in widget functions, but are not in any way spe‐
#           cial outside ZLE.  If they have some normal value outside ZLE, that value is temporarily  inac‐
#           cessible,  but  will  return  when the widget function exits.  These special parameters in fact
#           have local scope, like parameters created in a function using local.
#
#           Inside completion widgets and traps called while ZLE is active, these parameters are  available
#           read-only.
#
#           Note  that  the parameters appear as local to any ZLE widget in which they appear.  Hence if it
#           is desired to override them this needs to be done within a nested function:
#
#                  widget-function() {
#                    # $WIDGET here refers to the special variable
#                    # that is local inside widget-function
#                    () {
#                       # This anonymous nested function allows WIDGET
#                       # to be used as a local variable.  The -h
#                       # removes the special status of the variable.
#                       local -h WIDGET
#                    }
#                  }

#
#   Special Widgets
#       There  are a few user-defined widgets which are special to the shell.  If they do not exist, no
#       special action is taken.  The environment provided is identical to that for any  other  editing
#       widget.
#
#       zle-isearch-exit
#              Executed  at  the end of incremental search at the point where the isearch prompt is re‐
#              moved from the display.  See zle-isearch-update for an example.
#
#       zle-isearch-update
#              Executed within incremental search when the display is about to be redrawn.   Additional
#              output below the incremental search prompt can be generated by using `zle -M' within the
#              widget.  For example,
#
#                     zle-isearch-update() { zle -M "Line $HISTNO"; }
#                     zle -N zle-isearch-update
#
#              Note the line output by `zle -M' is not deleted on exit from incremental  search.   This
#              can be done from a zle-isearch-exit widget:
#
#                     zle-isearch-exit() { zle -M ""; }
#                     zle -N zle-isearch-exit
#
#       zle-line-pre-redraw
#              Executed whenever the input line is about to be redrawn, providing an opportunity to up‐
#              date the region_highlight array.
#
#       zle-line-init
#              Executed every time the line editor is started to read a new line of input.  The follow‐
#              ing example puts the line editor into vi command mode when it starts up.
#
#                     zle-line-init() { zle -K vicmd; }
#                     zle -N zle-line-init
#
#              (The  command  inside  the  function  sets  the keymap directly; it is equivalent to zle
#              vi-cmd-mode.)
#
#       zle-line-finish
#              This is similar to zle-line-init but is executed every time the line editor has finished
#              reading a line of input.
#
#       zle-history-line-set
#              Executed when the history line changes.
#
#       zle-keymap-select
#              Executed  every  time  the keymap changes, i.e. the special parameter KEYMAP is set to a
#              different value, while the line editor is active.  Initialising the keymap when the line
#              editor starts does not cause the widget to be called.
#
#              The value $KEYMAP within the function reflects the new keymap.  The old keymap is passed
#              as the sole argument.
#
#              This can be used for detecting switches between the vi command (vicmd) and insert  (usu‐
#              ally main) keymaps.
#
#
#
#
#
# Completion
#       accept-and-menu-complete
#              In a menu completion, insert the current completion into the buffer, and advance to  the
#              next possible completion.
#
#       complete-word
#              Attempt completion on the current word.
#
#       delete-char-or-list (^D) (unbound) (unbound)
#              Delete  the  character  under the cursor.  If the cursor is at the end of the line, list
#              possible completions for the current word.
#
#       expand-cmd-path
#              Expand the current command to its full pathname.
#
#       expand-or-complete (TAB) (unbound) (TAB)
#              Attempt shell expansion on the current word.  If that fails, attempt completion.
#
#       expand-or-complete-prefix
#              Attempt shell expansion on the current word up to cursor.
#
#       expand-history (ESC-space ESC-!) (unbound) (unbound)
#              Perform history expansion on the edit buffer.
#
#       expand-word (^X*) (unbound) (unbound)
#              Attempt shell expansion on the current word.
#
#       list-choices (ESC-^D) (^D =) (^D)
#              List possible completions for the current word.
#
#       list-expand (^Xg ^XG) (^G) (^G)
#              List the expansion of the current word.
#
#       magic-space
#              Perform history expansion and insert a space into the buffer.  This is  intended  to  be
#              bound to space.
#
#       menu-complete
#             Like complete-word, except that menu completion is used.  See the MENU_COMPLETE option.
#
#       menu-expand-or-complete
#              Like expand-or-complete, except that menu completion is used.
#
#       reverse-menu-complete
#              Perform menu completion, like menu-complete, except that if a menu completion is already
#              in progress, move to the previous completion rather than the next.
#
#       end-of-list
#              When a previous completion displayed a list below the prompt, this widget can be used to
#              move the prompt below the list.
#
#   Miscellaneous
#       accept-and-hold (ESC-A ESC-a) (unbound) (unbound)
#              Push the contents of the buffer on the buffer stack and execute it.
#
#       accept-and-infer-next-history
#              Execute  the  contents  of the buffer.  Then search the history list for a line matching
#              the current one and push the event following onto the buffer stack.
#
#       accept-line (^J ^M) (^J ^M) (^J ^M)
#              Finish editing the buffer.  Normally this causes the buffer to be executed  as  a  shell
#              command.
#
#
#       accept-line-and-down-history (^O) (unbound) (unbound)
#              Execute the current line, and push the next history event on the buffer stack.
#
#       auto-suffix-remove
#              If  the  previous  action added a suffix (space, slash, etc.) to the word on the command
#              line, remove it.  Otherwise do nothing.  Removing the suffix ends any active  menu  com‐
#              pletion or menu selection.
#
#              This widget is intended to be called from user-defined widgets to enforce a desired suf‐
#              fix-removal behavior.
#
#       auto-suffix-retain
#              If the previous action added a suffix (space, slash, etc.) to the word  on  the  command
#              line,  force  it  to be preserved.  Otherwise do nothing.  Retaining the suffix ends any
#              active menu completion or menu selection.
#
#              This widget is intended to be called from user-defined widgets to enforce a desired suf‐
#              fix-preservation behavior.
#       recursive-edit
#              Only useful from a user-defined widget.  At this point in the function, the  editor  re‐
#              gains  control  until one of the standard widgets which would normally cause zle to exit
#              (typically an accept-line caused by hitting the return key) is executed.  Instead,  con‐
#              trol  returns to the user-defined widget.  The status returned is non-zero if the return
#              was caused by an error, but the function still continues executing and  hence  may  tidy
#              up.   This  makes  it  safe for the user-defined widget to alter the command line or key
#              bindings temporarily.
#
#              The following widget, caps-lock, serves as an example.
#
#                     self-insert-ucase() {
#                       LBUFFER+=${(U)KEYS[-1]}
#                     }
#
#                     integer stat
#
#                     zle -N self-insert self-insert-ucase
#                     zle -A caps-lock save-caps-lock
#                     zle -A accept-line caps-lock
#
#                     zle recursive-edit
#                     stat=$?
#
#                     zle -A .self-insert self-insert
#                     zle -A save-caps-lock caps-lock
#                     zle -D save-caps-lock
#
#                     (( stat )) && zle send-break
#
#                     return $stat
#
#              This causes typed letters to be inserted capitalised until either accept-line (i.e. typ‐
#              ically  the  return key) is typed or the caps-lock widget is invoked again; the later is
#              handled by saving the old definition of caps-lock as save-caps-lock and  then  rebinding
#              it  to  invoke accept-line.  Note that an error from the recursive edit is detected as a
#              non-zero return status and propagated by using the send-break widget.
#
#
#
#       run-help (ESC-H ESC-h) (unbound) (unbound)
#              Push the buffer onto the buffer stack, and execute the command `run-help cmd', where cmd
#              is the current command.  run-help is normally aliased to man.
#
#
#
#       undefined-key
#              This  command is executed when a key sequence that is not bound to any command is typed.
#              By default it beeps.
#
#
#
#
#
#
#
#       what-cursor-position (^X=) (ga) (unbound)
#              Print the character under the cursor, its code as an octal, decimal and hexadecimal num‐
#              ber,  the  current cursor position within the buffer and the column of the cursor in the
#              current line.
#
#       where-is
#              Read the name of an editor command and print the listing of key  sequences  that  invoke
#              the  specified  command.   A  restricted  set  of  editing functions is available in the
#              mini-buffer.  Keys are looked up in the special command keymap, and if not  found  there
#              in the main keymap.
#
#       which-command (ESC-?) (unbound) (unbound)
#              Push  the  buffer  onto  the  buffer stack, and execute the command `which-command cmd'.
#              where cmd is the current command.  which-command is normally aliased to whence.
#
#
#
#
#
#
#       If  zle_highlight  is not set or no value applies to a particular context, the defaults applied
#       are equivalent to
#
#              zle_highlight=(region:standout special:standout
#              suffix:bold isearch:underline paste:standout)
#
#       i.e. both the region and special characters are shown in standout mode.
#
#       Within widgets, arbitrary regions may be highlighted by setting the special array parameter re‐
#       gion_highlight; see above.
#
#
#       
#COMPLETION WIDGET EXAMPLE
#       The first step is to define the widget:
#
#              zle -C complete complete-word complete-files
#
#       Then the widget can be bound to a key using the bindkey builtin command:
#
#              bindkey '^X\t' complete
#
#       After that the shell function complete-files will be invoked after typing  control-X  and  TAB.
#       The function should then generate the matches, e.g.:
#
#              complete-files () { compadd - * }
#
#       This function will complete files in the current directory matching the current word.
#
#
#
#
#
#
#       environ
#              The environ style is used when completing  for  `sudo'.   It  is  set  to  an  array  of
#              `VAR=value'  assignments to be exported into the local environment before the completion
#              for the target command is invoked.
#              zstyle ':completion:*:sudo::' environ \
#                PATH="/sbin:/usr/sbin:$PATH" HOME="/root"
#
#
#
#
#       fake-always
#              This  works  identically to the fake style except that the ignored-patterns style is not
#              applied to it.  This makes it possible to override a set of matches completely  by  set‐
#              ting the ignored patterns to `*'.
#
#              The  following  shows  a way of supplementing any tag with arbitrary data, but having it
#              behave for display purposes like a separate tag.  In this example we use the features of
#              the tag-order style to divide the named-directories tag into two when performing comple‐
#              tion with the standard completer complete for arguments of cd.  The  tag  named-directo‐
#              ries-normal  behaves  as normal, but the tag named-directories-mine contains a fixed set
#              of directories.  This has the effect of adding the match group `extra directories'  with
#              the given completions.
#
#                     zstyle ':completion::complete:cd:*' tag-order \
#                       'named-directories:-mine:extra\ directories
#                       named-directories:-normal:named\ directories *'
#                     zstyle ':completion::complete:cd:*:named-directories-mine' \
#                       fake-always mydir1 mydir2
#                     zstyle ':completion::complete:cd:*:named-directories-mine' \
#                       ignored-patterns '*'
# file-list
#              This style controls whether files completed using the standard builtin mechanism are  to
#              be listed with a long list similar to ls -l.  Note that this feature uses the shell mod‐
#              ule zsh/stat for file information; this loads the builtin stat which  will  replace  any
#              external  stat  executable.  To avoid this the following code can be included in an ini‐
#              tialization file:
#
#                     zmodload -i zsh/stat
#                     disable stat
#
#              The style may either be set to a `true' value (or `all'), or one of the values  `insert'
#              or  `list',  indicating that files are to be listed in long format in all circumstances,
#              or when attempting to insert a file name, or when listing file names without  attempting
#              to insert one.
#
#              More  generally,  the  value may be an array of any of the above values, optionally fol‐
#              lowed by =num.  If num is present it gives the maximum number of matches for which  long
#              listing style will be used.  For example,
#
#                     zstyle ':completion:*' file-list list=20 insert=10
#
#              specifies  that long format will be used when listing up to 20 files or inserting a file
#              with up to 10 matches (assuming a listing is to be shown at all, for example on  an  am‐
#              biguous completion), else short format will be used.
#
#                     zstyle -e ':completion:*' file-list \
#                            '(( ${+NUMERIC} )) && reply=(true)'
#
#              specifies  that  long  format will be used any time a numeric argument is supplied, else
#              short format.
#
#
#
#       file-patterns
#              This is used by the standard function for completing filenames, _files.  If the style is
#              unset  up  to three tags are offered, `globbed-files',`directories' and `all-files', de‐
#              pending on the types of files   expected  by  the  caller  of  _files.   The  first  two
#              (`globbed-files'  and  `directories') are normally offered together to make it easier to
#              complete files in sub-directories.
#
#              The file-patterns style provides alternatives to the default tags, which are  not  used.
#              Its  value  consists  of elements of the form `pattern:tag'; each string may contain any
#              number of such specifications separated by spaces.
#
#              The pattern is a pattern that is to be used to generate filenames.   Any  occurrence  of
#              the  sequence  `%p' is replaced by any pattern(s) passed by the function calling _files.
#              Colons in the pattern must be preceded by a backslash to make them distinguishable  from
#              the colon before the tag.  If more than one pattern is needed, the patterns can be given
#              inside braces, separated by commas.
#
#              The tags of all strings in the value will be offered by _files and used when looking  up
#              other  styles.   Any  tags  in the same word will be offered at the same time and before
#              later words.  If no `:tag' is given the `files' tag will be used.
#
#              The tag may also be followed by an optional second colon and a description,  which  will
#              be  used  for  the `%d' in the value of the format style (if that is set) instead of the
#              default description supplied by the completion function.  If the description given  here
#              contains itself a `%d', that is replaced with the description supplied by the completion
#              function.
#
#              For example, to make the rm command first complete only names of object files  and  then
#              the names of all files if there is no matching object file:
#
#                     zstyle ':completion:*:*:rm:*:*' file-patterns \
#                         '*.o:object-files' '%p:all-files'
#
#              To  alter the default behaviour of file completion -- offer files matching a pattern and
#              directories on the first attempt, then all files -- to offer only matching files on  the
#              first attempt, then directories, and finally all files:
#
#                     zstyle ':completion:*' file-patterns \
#                         '%p:globbed-files' '*(-/):directories' '*:all-files'
#
#              This  works  even  where there is no special pattern: _files matches all files using the
#              pattern `*' at the first step and stops when it sees this pattern.  Note  also  it  will
#              never try a pattern more than once for a single completion attempt.
#
#              During  the execution of completion functions, the EXTENDED_GLOB option is in effect, so
#              the characters `#', `~' and `^' have special meanings in the patterns.
#
#
#
#
#
#
#
#
#       group-name
#              The  completion  system  can  group different types of matches, which appear in separate
#              lists.  This style can be used to give the names of groups for particular tags.  For ex‐
#              ample, in command position the completion system generates names of builtin and external
#              commands, names of aliases, shell functions and parameters and reserved words as  possi‐
#              ble completions.  To have the external commands and shell functions listed separately:
#
#                     zstyle ':completion:*:*:-command-:*:commands' \
#                            group-name commands
#                     zstyle ':completion:*:*:-command-:*:functions' \
#                            group-name functions
#
#              As a consequence, any match with the same tag will be displayed in the same group.
#
#              If  the  name given is the empty string the name of the tag for the matches will be used
#              as the name of the group.  So, to have all different types of  matches  displayed  sepa‐
#              rately, one can just set:
#
#                     zstyle ':completion:*' group-name ''
#
#              All matches for which no group name is defined will be put in a group named -default-.
#
#       group-order
#              This style is additional to the group-name style to specify the order for display of the
#              groups defined by that style (compare tag-order, which determines which completions  ap‐
#              pear at all).  The groups named are shown in the given order; any other groups are shown
#              in the order defined by the completion function.
#
#              For example, to have names of builtin commands, shell functions  and  external  commands
#              appear in that order when completing in command position:
#
#                     zstyle ':completion:*:*:-command-:*:*' group-order \
#                            builtins functions commands
#       list-colors
#              If the zsh/complist module is loaded, this style can be used  to  set  color  specifica‐
#              tions.  This mechanism replaces the use of the ZLS_COLORS and ZLS_COLOURS parameters de‐
#              scribed in the section `The zsh/complist Module' in zshmodules(1), but the syntax is the
#              same.
#
#              If this style is set for the default tag, the strings in the value are taken as specifi‐
#              cations that are to be used everywhere.  If it is set for other tags, the specifications
#              are  used only for matches of the type described by the tag.  For this to work best, the
#              group-name style must be set to an empty string.
#
#              In addition to setting styles for specific tags, it is also possible to use group  names
#              specified explicitly by the group-name tag together with the `(group)' syntax allowed by
#              the ZLS_COLORS and ZLS_COLOURS parameters and simply using the default tag.
#
#              It is possible to use any color specifications already set up for the GNU version of the
#              ls command:
#
#                     zstyle ':completion:*:default' list-colors \
#                            ${(s.:.)LS_COLORS}
#
#              The default colors are the same as for the GNU ls command and can be obtained by setting
#              the style to an empty string (i.e. '').
#
#
#
#       list-dirs-first
#              This is used by file completion.  If set, directories to be completed are  listed  sepa‐
#              rately from and before completion for other files, regardless of tag ordering.  In addi‐
#              tion, the tag other-files is used in place of all-files for the remaining files, to  in‐
#              dicate that no directories are presented with that tag.
#
#       list-grouped
#              If  this  style  is `true' (the default), the completion system will try to make certain
#              completion listings more compact by grouping matches.  For example, options for commands
#              that  have the same description (shown when the verbose style is set to `true') will ap‐
#              pear as a single entry.  However, menu selection can be used to cycle  through  all  the
#              matches.
#
#       list-packed
#              This is tested for each tag valid in the current context as well as the default tag.  If
#              it is set to `true', the corresponding matches appear in listings as if the  LIST_PACKED
#              option were set.  If it is set to `false', they are listed normally.
#
#
#
#       list-prompt
#              If  this style is set for the default tag, completion lists that don't fit on the screen
#              can be scrolled (see the description of the zsh/complist module in zshmodules(1)).   The
#              value,  if  not  the empty string, will be displayed after every screenful and the shell
#              will prompt for a key press; if the style is set to the empty string, a  default  prompt
#              will be used.
#
#              The  value may contain the escape sequences: `%l' or `%L', which will be replaced by the
#              number of the last line displayed and the total number of lines; `%m' or `%M', the  num‐
#              ber  of  the  last match shown and the total number of matches; and `%p' and `%P', `Top'
#              when at the beginning of the list, `Bottom' when at the end and the position shown as  a
#              percentage of the total length otherwise.  In each case the form with the uppercase let‐
#              ter will be replaced by a string of fixed width, padded to the  right with spaces, while
#              the  lowercase  form  will  be  replaced by a variable width string.  As in other prompt
#              strings, the escape sequences `%S', `%s', `%B', `%b', `%U', `%u' for entering and  leav‐
#              ing  the  display  modes  standout,  bold  and underline, and `%F', `%f', `%K', `%k' for
#              changing the foreground background colour, are also available, as is the form  `%{...%}'
#              for  enclosing  escape  sequences  which display with zero (or, with a numeric argument,
#              some other) width.
#
#              After deleting this prompt the variable LISTPROMPT should be unset for  the  removal  to
#              take effect.
#
#
#
#      list-rows-first
#              This  style  is  tested  in the same way as the list-packed style and determines whether
#              matches are to be listed in a rows-first fashion as if the LIST_ROWS_FIRST  option  were
#              set.
#
#       list-suffixes
#              This  style is used by the function that completes filenames.  If it is `true', and com‐
#              pletion is attempted on a string containing multiple  partially  typed  pathname  compo‐
#              nents, all ambiguous components will be shown.  Otherwise, completion stops at the first
#              ambiguous component.
#
#       list-separator
#              The value of this style is used in completion listing to separate the string to complete
#              from  a  description  when possible (e.g. when completing options).  It defaults to `--'
#              (two hyphens).
#
#
#
#
#
#
#
#       local  This is for use with functions that complete URLs for which the corresponding files  are
#              available  directly  from the file system.  Its value should consist of three strings: a
#              hostname, the path to the default web pages for the server, and the directory name  used
#              by a user placing web pages within their home area.
#
#              For example:
#
#                     zstyle ':completion:*' local toast \
#                         /var/http/public/toast public_html
#
#              Completion   after   `http://toast/stuff/'   will   look  for  files  in  the  directory
#              /var/http/public/toast/stuff,  while completion after `http://toast/~yousir/' will  look
#              for files in the directory ~yousir/public_html.
#
#  menu   If this is `true' in the context of any of the tags defined for the  current  completion
#              menu  completion  will  be used.  The value for a specific tag will take precedence over
#              that for the `default' tag.
#
#              If none of the values found in this way is `true' but at least one is set to `auto', the
#              shell behaves as if the AUTO_MENU option is set.
#
#              If  one  of  the values is explicitly set to `false', menu completion will be explicitly
#              turned off, overriding the MENU_COMPLETE option and other settings.
#
#              In the form `yes=num', where `yes' may be any of the `true' values (`yes', `true',  `on'
#              and  `1'),  menu completion will be turned on if there are at least num matches.  In the
#              form `yes=long', menu completion will be turned on if the  list  does  not  fit  on  the
#              screen.   This  does not activate menu completion if the widget normally only lists com‐
#              pletions,  but  menu  completion  can  be  activated  in  that  case  with   the   value
#              `yes=long-list'  (Typically, the value `select=long-list' described later is more useful
#              as it provides control over scrolling.)
#
#              Similarly, with any of the `false' values (as in `no=10'), menu completion will  not  be
#              used if there are num or more matches.
#
#              The  value  of  this widget also controls menu selection, as implemented by the zsh/com‐
#              plist module.  The following values may appear either alongside or instead of the values
#              above.
#
#              If  the  value contains the string `select', menu selection will be started uncondition‐
#              ally.
#
#              In the form `select=num', menu selection will only be started if there are at least  num
#              matches.   If  the values for more than one tag provide a number, the smallest number is
#              taken.
#
#
#              Menu selection can  be  turned  off  explicitly  by  defining  a  value  containing  the
#              string`no-select'.
#
#              It  is also possible to start menu selection only if the list of matches does not fit on
#              the screen by using the value `select=long'.  To start menu selection even if  the  cur‐
#              rent widget only performs listing, use the value `select=long-list'.
#
#              To  turn on menu completion or menu selection when there are a certain number of matches
#              or the list of matches does not fit on the screen, both of `yes=' and `select='  may  be
#              given twice, once with a number and once with `long' or `long-list'.
#
#              Finally,  it is possible to activate two special modes of menu selection.  The word `in‐
#              teractive' in the value causes interactive mode to be entered immediately when menu  se‐
#              lection  is started; see the description of the zsh/complist module in zshmodules(1) for
#              a description of interactive mode.  Including the string `search' does the same for  in‐
#              cremental  search  mode.   To  select  backward  incremental  search, include the string
#              `search-backward'.
#
#
#      recursive-files
#              If this style is set, its value is an array of patterns to be  tested  against  `$PWD/':
#              note  the  trailing slash, which allows directories in the pattern to be delimited unam‐
#              biguously by including slashes on both sides.  If an ordinary file completion fails  and
#              the  word  on the command line does not yet have a directory part to its name, the style
#              is retrieved using the same tag as for the completion just attempted, then the  elements
#              tested  against  $PWD/ in turn.  If one matches, then the shell reattempts completion by
#              prepending the word on the command line with each directory in the expansion of  **/*(/)
#              in  turn.  Typically the elements of the style will be set to restrict the number of di‐
#              rectories beneath the current one to a manageable number, for example `*/.git/*'.
#
#              For example,
#
#                     zstyle ':completion:*' recursive-files '*/zsh/*'
#
#              If the current directory is  /home/pws/zsh/Src,  then  zle_trTAB  can  be  completed  to
#              Zle/zle_tricky.c.
#
#
#
#
#
#
#
#
#       remote-access
#              If  set  to `false', certain commands will be prevented from making Internet connections
#              to retrieve remote information.  This includes the completion for the CVS command.
#
#              It is not always possible to know if connections are in fact to a remote site,  so  some
#              may be prevented unnecessarily.
#
#
#
#
#
#
#
#      select-prompt
#              If  this  is  set for the default tag, its value will be displayed during menu selection
#              (see the menu style above) when the completion list does not fit  on  the  screen  as  a
#              whole.   The  same  escapes as for the list-prompt style are understood, except that the
#              numbers refer to the match or line the mark is on.  A default prompt is  used  when  the
#              value is the empty string.
#
#       select-scroll
#              This  style  is  tested  for  the  default  tag  and determines how a completion list is
#              scrolled during a menu selection (see the menu style above)  when  the  completion  list
#              does not fit on the screen as a whole.  If the value is `0' (zero), the list is scrolled
#              by half-screenfuls; if it is a positive integer, the list is scrolled by the given  num‐
#              ber  of lines; if it is a negative number, the list is scrolled by a screenful minus the
#              absolute value of the given number of lines.  The default is to scroll by single lines.
#
#       separate-sections
#              This style is used with the manuals tag when completing names of manual pages.  If it is
#              `true',  entries for different sections are added separately using tag names of the form
#              `manual.X', where X is the section number.  When the group-name style is also in effect,
#              pages from different sections will appear separately.  This style is also used similarly
#              with the words style when completing words for the dict command. It  allows  words  from
#              different  dictionary  databases  to be added separately.  The default for this style is
#              `false'.
#
#       show-ambiguity
#              If the zsh/complist module is loaded, this style can be used to highlight the first  am‐
#              biguous  character  in  completion lists. The value is either a color indication such as
#              those supported by the list-colors style or, with a value of `true', a default of under‐
#              lining  is  selected. The highlighting is only applied if the completion display strings
#              correspond to the actual matches.
#
#
#
#       show-completer
#              Tested whenever a new completer is tried.  If it is `true', the completion  system  out‐
#              puts  a progress message in the listing area showing what completer is being tried.  The
#              message will be overwritten by any output when completions are found and is removed  af‐
#              ter completion is finished.
#
#       single-ignored
#              This  is  used  by the _ignored completer when there is only one match.  If its value is
#              `show', the single match will be displayed but not inserted.  If the  value  is  `menu',
#              then the single match and the original string are both added as matches and menu comple‐
#              tion is started, making it easy to select either of them.
#
#       sort   This allows the standard ordering of matches to be overridden.
#
#              If its value is `true' or `false', sorting is enabled  or  disabled.   Additionally  the
#              values associated with the `-o' option to compadd can also be listed: match, nosort, nu‐
#              meric, reverse.  If it is not set for the context, the standard behaviour of the calling
#              widget is used.
#
#              The  style is tested first against the full context including the tag, and if that fails
#              to produce a value against the context without the tag.
#
#              In many cases where a calling widget explicitly selects a particular ordering in lieu of
#              the  default,  a  value  of `true' is not honoured.  An example of where this is not the
#              case is for command history where the default of sorting matches chronologically may  be
#              overridden by setting the style to `true'.
#
#              In  the  _expand completer, if it is set to `true', the expansions generated will always
#              be sorted.  If it is set to `menu', then the expansions are only sorted  when  they  are
#              offered as single strings but not in the string containing all possible expansions.
#
#
#
#      special-dirs
#              Normally,  the completion code will not produce the directory names `.' and `..' as pos‐
#              sible completions.  If this style is set to `true', it will add both  `.'  and  `..'  as
#              possible completions; if it is set to `..', only `..' will be added.
#
#              The  following  example sets special-dirs to `..' when the current prefix is empty, is a
#              single `.', or consists only of a path beginning with `../'.   Otherwise  the  value  is
#              `false'.
#
#                     zstyle -e ':completion:*' special-dirs \
#                        '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
#
#
#
#
#
#
#
#      squeeze-slashes
#              If  set  to  `true',  sequences of slashes in filename paths (for example in `foo//bar')
#              will be treated as a single slash.  This is the usual behaviour of UNIX paths.  However,
#              by  default  the  file  completion  function  behaves as if there were a `*' between the
#              slashes.
#
#       tag-order
#              This  provides  a  mechanism  for sorting how the tags available in a particular context
#              will be used.
#
#              The values for the style are sets of space-separated lists of tags.  The  tags  in  each
#              value  will  be  tried  at  the same time; if no match is found, the next value is used.
#              (See the file-patterns style for an exception to this behavior.)
#
#              For example:
#
#                     zstyle ':completion:*:complete:-command-:*:*' tag-order \
#                         'commands functions'
#
#              specifies that completion in command position first offers external commands  and  shell
#              functions.  Remaining tags will be tried if no completions are found.
#
#              In addition to tag names, each string in the value may take one of the following forms:
#
#              -      If any value consists of only a hyphen, then only the tags specified in the other
#                     values are generated.  Normally all tags not explicitly selected are  tried  last
#                     if  the  specified  tags  fail to generate any matches.  This means that a single
#                     value consisting only of a single hyphen turns off completion.
#
# w              ! tags...
#                     A string starting with an exclamation mark specifies names of tags that  are  not
#                     to be used.  The effect is the same as if all other possible tags for the context
#                     had been listed.
#
#              tag:label ...
#                     Here, tag is one of the standard tags and label is an  arbitrary  name.   Matches
#                     are  generated  as  normal but the name label is used in contexts instead of tag.
#                     This is not useful in words starting with !.
#
#                     If the label starts with a hyphen, the tag is prepended to the label to form  the
#                     name  used for lookup.  This can be used to make the completion system try a cer‐
#                     tain tag more than once, supplying different style settings for each attempt; see
#                     below for an example.
#              tag:label:description
#                     As before, but description will replace the `%d' in the value of the format style
#                     instead of the default description supplied by the completion  function.   Spaces
#                     in the description must be quoted with a backslash.  A `%d' appearing in descrip‐
#                     tion is replaced with the description given by the completion function.
#
#              In any of the forms above the tag may be a pattern  or  several  patterns  in  the  form
#              `{pat1,pat2...}'.   In this case all matching tags will be used except for any given ex‐
#              plicitly in the same string.
#
#
#              One use of these features is to try one tag more than once, setting other styles differ‐
#              ently on each attempt, but still to use all the other tags without having to repeat them
#              all.  For example, to make completion of function names in command position  ignore  all
#              the completion functions starting with an underscore the first time completion is tried:
#
#                     zstyle ':completion:*:*:-command-:*:*' tag-order \
#                         'functions:-non-comp *' functions
#                     zstyle ':completion:*:functions-non-comp' \
#                         ignored-patterns '_*'
#
#              On the first attempt, all tags will be offered but the functions tag will be replaced by
#              functions-non-comp.  The ignored-patterns style is set for this tag to exclude functions
#              starting with an underscore.  If there are no matches, the second value of the tag-order
#              style is used which completes functions using the default tag, this time presumably  in‐
#              cluding all function names.
#
#              The matches for one tag can be split into different groups.  For example:
#
#                     zstyle ':completion:*' tag-order \
#                         'options:-long:long\ options
#                          options:-short:short\ options
#                          options:-single-letter:single\ letter\ options'
#                     zstyle ':completion:*:options-long' \
#                          ignored-patterns '[-+](|-|[^-]*)'
#                     zstyle ':completion:*:options-short' \
#                          ignored-patterns '--*' '[-+]?'
#                     zstyle ':completion:*:options-single-letter' \
#                          ignored-patterns '???*'
#
#
#
#
#
#
#
