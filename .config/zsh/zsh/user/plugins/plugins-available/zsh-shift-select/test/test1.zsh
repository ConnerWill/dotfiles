

Expanding on Stephane's excellent answer from almost 3 years ago, I added some more bindings to make the behaviour (almost) completely consistent with all of Windows' standard keyboard behaviour:

    Selection is cleared when using a navigation key (arrow, home, end) WITHOUT shift
    Backspace and Del delete an active selection
    Selection is extended to the next/previous word when using Ctrl+Shift+Left/Ctrl+Shift+Right
    Shift+Home and Shift+End extend the selection to the beginning and end of line respectively. Ctrl+Shift+Home and Ctrl+Shift+End do the same.

Two things that are not exactly the same:

    Extending a selection to the next word includes trailing space, unlike windows. This could be fixed, but it doesn't bother me.
    Typing when there is an active selection will not delete it and replace it with the character you typed. This would seem to require a lot more work to remap the entire keyboard. Not worth the trouble to me.

Note that the default mintty behaviour is to bind Shift+End and Shift+Home to access the scroll back buffer. This supercedes the zsh configuration; the keys never get passed through. In order for these to work, you will need to configure a different key (or disable scroll back) in /etc/minttyrc or ~/.minttyrc. See "modifier for scrolling" here - the simplest solution is just set ScrollMod=2 to bind it to Alt instead of Shift.

So everything:
~/.minttyrc

ScrollMod=2

~/.zshrc

r-delregion() {
  if ((REGION_ACTIVE)) then
     zle kill-region
  else 
    local widget_name=$1
    shift
    zle $widget_name -- $@
  fi
}

r-deselect() {
  ((REGION_ACTIVE = 0))
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

r-select() {
  ((REGION_ACTIVE)) || zle set-mark-command
  local widget_name=$1
  shift
  zle $widget_name -- $@
}

for key     kcap   seq        mode   widget (
    sleft   kLFT   $'\e[1;2D' select   backward-char
    sright  kRIT   $'\e[1;2C' select   forward-char
    sup     kri    $'\e[1;2A' select   up-line-or-history
    sdown   kind   $'\e[1;2B' select   down-line-or-history

    send    kEND   $'\E[1;2F' select   end-of-line
    send2   x      $'\E[4;2~' select   end-of-line

    shome   kHOM   $'\E[1;2H' select   beginning-of-line
    shome2  x      $'\E[1;2~' select   beginning-of-line

    left    kcub1  $'\EOD'    deselect backward-char
    right   kcuf1  $'\EOC'    deselect forward-char

    end     kend   $'\EOF'    deselect end-of-line
    end2    x      $'\E4~'    deselect end-of-line

    home    khome  $'\EOH'    deselect beginning-of-line
    home2   x      $'\E1~'    deselect beginning-of-line

    csleft  x      $'\E[1;6D' select   backward-word
    csright x      $'\E[1;6C' select   forward-word
    csend   x      $'\E[1;6F' select   end-of-line
    cshome  x      $'\E[1;6H' select   beginning-of-line

    cleft   x      $'\E[1;5D' deselect backward-word
    cright  x      $'\E[1;5C' deselect forward-word

    del     kdch1   $'\E[3~'  delregion delete-char
    bs      x       $'^?'     delregion backward-delete-char

  ) {
  eval "key-$key() {
    r-$mode $widget \$@
  }"
  zle -N key-$key
  bindkey ${terminfo[$kcap]-$seq} key-$key
}

This covers keycodes from several different keyboard configurations I have used.

Note: the values in the "key" column don't mean anything, they are just used to build a named reference for zle. They could be anything. What is important is the seq, mode and widget columns.

Note 2: You can bind pretty much any keys you want, you just need the key codes used in your console emulator. Open a regular console (without running zsh) and type Ctrl+V and then the key you want. It should emit the code. ^[ means \E.
Share
Follow
edited Jun 9, 2018 at 14:46
user avatar
andsens
6,23644 gold badges2525 silver badges2525 bronze badges
answered Jun 17, 2015 at 18:17
user avatar
Jamie Treworgy
23.5k88 gold badges7272 silver badges117117 bronze badges

    Where can I find more documentation on shome, csleft, etc? Google is not friendly here. – 
    Myer
    Oct 13, 2015 at 12:45
    2
    How can I swap out ctrl for alt here? Also, how can I make these compatible with ubuntu and xterm as well? – 
    Myer
    Oct 13, 2015 at 12:56 

Unfortunately rebinding backspace in this way breaks typing backspace during bck-i-search. – 
Vladimir Panteleev
Oct 10, 2019 at 21:34
@VladimirPanteleev True - I can't figure out a good workaround - it seems to have special behavior (e.g. backward-delete-char which is the default binding for BS doens't act the same when called from a function in the bck-i-search context). You can still use CTRL+H as backspace; I guess one needs to decide whether BS key should work in this context or on the normal CLI. – 
Jamie Treworgy
Oct 17, 2019 at 13:57

    this helps (why is this not default?) But having alt/option instead of ctrl would help even more – 
    Havnar
    Sep 14, 2020 at 16:34

Show 1 more comment
8

Expanded on Jamie Treworgy's answer.

Includes the following functionality:

    cmd+a: select entire command-line prompt text
    cmd+x: cut (copy & delete) current command-line selection to clipboard
    cmd+c: copy current command-line selection to clipboard
    cmd+v: pastes clipboard selection
    ctrl+u: delete backwards till beginning of line
    cmd+z: undo
    cmd+shift+z: redo
    shift select:
        shift-left: select character to the left
        shift-right: select character to the right
        shift-up: select line upwards
        shift-down: select live downwards
        cmd-shift-left: select till beginning of line
        cmd-shift-right: select till end of line
        alt-shift-left: select word to the left
        alt-shift-right: select word to the right
        ctrl-shift-left: select till beginning of line
        ctrl-shift-right: select till end of line
        ctrl-shift-a: select till beginning of line
        ctrl-shift-e: select till end of line
    unselect: works as expected, on left/right, alt-left/right, cmd/ctrl-left/right, esc+esc.
    delete selection: works as expected on Delete, ctrl+d, backspace
    delete selection & insert character: works as expected for all visible ASCII characters and whitespace
    delete selection & insert clipboard: works as expected

.zshrc

# for my own convenience I explicitly set the signals
#   that my terminal sends to the shell as variables.
#   you might have different signals. you can see what
#   signal each of your keys sends by running `$> cat`
#   and pressing keys (you'll be able to see most keys)
#   also some of the signals sent might be set in your 
#   terminal emulator application/program
#   configurations/preferences. finally some terminals
#   have a feature that shows you what signals are sent
#   per key press.
#
# for context, at the time of writing these variables are
#   set for the kitty terminal program, i.e these signals  
#   are mostly ones sent by default by this terminal.
export KEY_ALT_F='ƒ'
export KEY_ALT_B='∫'
export KEY_ALT_D='∂'
export KEY_CTRL_U=$'\x15' # ^U
export KEY_CMD_BACKSPACE=$'^[b'   # arbitrary; added via kitty config (send_text)
export KEY_CMD_Z=^[[122;9u
export KEY_SHIFT_CMD_Z=^[[122;10u
export KEY_CTRL_R=$'\x12' # ^R
export KEY_CMD_C=^[[99;9u
export KEY_CMD_X=^[[120;9u
export KEY_CMD_V=^[[118;9u
export KEY_CMD_A=^[[97;9u
export KEY_CTRL_L=$'\x0c' # ^L
export KEY_LEFT=${terminfo[kcub1]:-$'^[[D'}
export KEY_RIGHT=${terminfo[kcuf1]:-$'^[[C'}
export KEY_SHIFT_UP=${terminfo[kri]:-$'^[[1;2A'}
export KEY_SHIFT_DOWN=${terminfo[kind]:-$'^[[1;2B'}
export KEY_SHIFT_RIGHT=${terminfo[kRIT]:-$'^[[1;2C'}
export KEY_SHIFT_LEFT=${terminfo[kLFT]:-$'^[[1;2D'}
export KEY_ALT_LEFT=$'^[[1;3D'
export KEY_ALT_RIGHT=$'^[[1;3C'
export KEY_SHIFT_ALT_LEFT=$'^[[1;4D'
export KEY_SHIFT_ALT_RIGHT=$'^[[1;4C'
export KEY_CMD_LEFT=$'^[[1;9D'
export KEY_CMD_RIGHT=$'^[[1;9C'
export KEY_SHIFT_CMD_LEFT=$'^[[1;10D'
export KEY_SHIFT_CMD_RIGHT=$'^[[1;10C'
export KEY_CTRL_A=$'\x01' # ^A
export KEY_CTRL_E=$'\x05' # ^E
export KEY_SHIFT_CTRL_A=$'^[[97;6u'
export KEY_SHIFT_CTRL_E=$'^[[101;6u'
export KEY_SHIFT_CTRL_LEFT=$'^[[1;6D'
export KEY_SHIFT_CTRL_RIGHT=$'^[[1;6C'
export KEY_CTRL_D=$'\x04' # ^D

# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

# copy selected terminal text to clipboard
zle -N widget::copy-selection
function widget::copy-selection {
    if ((REGION_ACTIVE)); then
        zle copy-region-as-kill
        printf "%s" $CUTBUFFER | pbcopy
    fi
}

# cut selected terminal text to clipboard
zle -N widget::cut-selection
function widget::cut-selection() {
    if ((REGION_ACTIVE)) then
        zle kill-region
        printf "%s" $CUTBUFFER | pbcopy
    fi
}

# paste clipboard contents
zle -N widget::paste
function widget::paste() {
    ((REGION_ACTIVE)) && zle kill-region
    RBUFFER="$(pbpaste)${RBUFFER}"
    CURSOR=$(( CURSOR + $(echo -n "$(pbpaste)" | wc -m | bc) ))
}

# select entire prompt
zle -N widget::select-all
function widget::select-all() {
    local buflen=$(echo -n "$BUFFER" | wc -m | bc)
    CURSOR=$buflen   # if this is messing up try: CURSOR=9999999
    zle set-mark-command
    while [[ $CURSOR > 0 ]]; do
        zle beginning-of-line
    done
}

# scrolls the screen up, in effect clearing it
zle -N widget::scroll-and-clear-screen
function widget::scroll-and-clear-screen() {
    printf "\n%.0s" {1..$LINES}
    zle clear-screen
}

function widget::util-select() {
    ((REGION_ACTIVE)) || zle set-mark-command
    local widget_name=$1
    shift
    zle $widget_name -- $@
}

function widget::util-unselect() {
    REGION_ACTIVE=0
    local widget_name=$1
    shift
    zle $widget_name -- $@
}

function widget::util-delselect() {
    if ((REGION_ACTIVE)) then
        zle kill-region
    else
        local widget_name=$1
        shift
        zle $widget_name -- $@
    fi
}

function widget::util-insertchar() {
    ((REGION_ACTIVE)) && zle kill-region
    RBUFFER="${1}${RBUFFER}"
    zle forward-char
}

#                       |  key sequence                   | command
# --------------------- | ------------------------------- | -------------

bindkey                   $KEY_ALT_F                        forward-word
bindkey                   $KEY_ALT_B                        backward-word
bindkey                   $KEY_ALT_D                        kill-word
bindkey                   $KEY_CTRL_U                       backward-kill-line
bindkey                   $KEY_CMD_BACKSPACE                backward-kill-line
bindkey                   $KEY_CMD_Z                        undo
bindkey                   $KEY_SHIFT_CMD_Z                  redo
bindkey                   $KEY_CTRL_R                       history-incremental-search-backward
bindkey                   $KEY_CMD_C                        widget::copy-selection
bindkey                   $KEY_CMD_X                        widget::cut-selection
bindkey                   $KEY_CMD_V                        widget::paste
bindkey                   $KEY_CMD_A                        widget::select-all
bindkey                   $KEY_CTRL_L                       widget::scroll-and-clear-screen

for keyname        kcap   seq                   mode        widget (

    left           kcub1  $KEY_LEFT             unselect    backward-char
    right          kcuf1  $KEY_RIGHT            unselect    forward-char

    shift-up       kri    $KEY_SHIFT_UP         select      up-line-or-history
    shift-down     kind   $KEY_SHIFT_DOWN       select      down-line-or-history
    shift-right    kRIT   $KEY_SHIFT_RIGHT      select      forward-char
    shift-left     kLFT   $KEY_SHIFT_LEFT       select      backward-char

    alt-right         x   $KEY_ALT_RIGHT        unselect    forward-word
    alt-left          x   $KEY_ALT_LEFT         unselect    backward-word
    shift-alt-right   x   $KEY_SHIFT_ALT_RIGHT  select      forward-word
    shift-alt-left    x   $KEY_SHIFT_ALT_LEFT   select      backward-word

    cmd-right         x   $KEY_CMD_RIGHT        unselect    end-of-line
    cmd-left          x   $KEY_CMD_LEFT         unselect    beginning-of-line
    shift-cmd-right   x   $KEY_SHIFT_CMD_RIGHT  select      end-of-line
    shift-cmd-left    x   $KEY_SHIFT_CMD_LEFT   select      beginning-of-line

    ctrl-e            x   $KEY_CTRL_E           unselect    end-of-line
    ctrl-a            x   $KEY_CTRL_A           unselect    beginning-of-line
    shift-ctrl-e      x   $KEY_SHIFT_CTRL_E     select      end-of-line
    shift-ctrl-a      x   $KEY_SHIFT_CTRL_A     select      beginning-of-line
    shift-ctrl-right  x   $KEY_SHIFT_CTRL_RIGHT select      end-of-line
    shift-ctrl-left   x   $KEY_SHIFT_CTRL_LEFT  select      beginning-of-line

    del               x   $KEY_CTRL_D           delselect   delete-char

    a                 x       'a'               insertchar  'a'
    b                 x       'b'               insertchar  'b'
    c                 x       'c'               insertchar  'c'
    d                 x       'd'               insertchar  'd'
    e                 x       'e'               insertchar  'e'
    f                 x       'f'               insertchar  'f'
    g                 x       'g'               insertchar  'g'
    h                 x       'h'               insertchar  'h'
    i                 x       'i'               insertchar  'i'
    j                 x       'j'               insertchar  'j'
    k                 x       'k'               insertchar  'k'
    l                 x       'l'               insertchar  'l'
    m                 x       'm'               insertchar  'm'
    n                 x       'n'               insertchar  'n'
    o                 x       'o'               insertchar  'o'
    p                 x       'p'               insertchar  'p'
    q                 x       'q'               insertchar  'q'
    r                 x       'r'               insertchar  'r'
    s                 x       's'               insertchar  's'
    t                 x       't'               insertchar  't'
    u                 x       'u'               insertchar  'u'
    v                 x       'v'               insertchar  'v'
    w                 x       'w'               insertchar  'w'
    x                 x       'x'               insertchar  'x'
    y                 x       'y'               insertchar  'y'
    z                 x       'z'               insertchar  'z'
    A                 x       'A'               insertchar  'A'
    B                 x       'B'               insertchar  'B'
    C                 x       'C'               insertchar  'C'
    D                 x       'D'               insertchar  'D'
    E                 x       'E'               insertchar  'E'
    F                 x       'F'               insertchar  'F'
    G                 x       'G'               insertchar  'G'
    H                 x       'H'               insertchar  'H'
    I                 x       'I'               insertchar  'I'
    J                 x       'J'               insertchar  'J'
    K                 x       'K'               insertchar  'K'
    L                 x       'L'               insertchar  'L'
    M                 x       'M'               insertchar  'M'
    N                 x       'N'               insertchar  'N'
    O                 x       'O'               insertchar  'O'
    P                 x       'P'               insertchar  'P'
    Q                 x       'Q'               insertchar  'Q'
    R                 x       'R'               insertchar  'R'
    S                 x       'S'               insertchar  'S'
    T                 x       'T'               insertchar  'T'
    U                 x       'U'               insertchar  'U'
    V                 x       'V'               insertchar  'V'
    W                 x       'W'               insertchar  'W'
    X                 x       'X'               insertchar  'X'
    Y                 x       'Y'               insertchar  'Y'
    Z                 x       'Z'               insertchar  'Z'
    0                 x       '0'               insertchar  '0'
    1                 x       '1'               insertchar  '1'
    2                 x       '2'               insertchar  '2'
    3                 x       '3'               insertchar  '3'
    4                 x       '4'               insertchar  '4'
    5                 x       '5'               insertchar  '5'
    6                 x       '6'               insertchar  '6'
    7                 x       '7'               insertchar  '7'
    8                 x       '8'               insertchar  '8'
    9                 x       '9'               insertchar  '9'

    exclamation-mark      x  '!'                insertchar  '!'
    hash-sign             x  '\#'               insertchar  '\#'
    dollar-sign           x  '$'                insertchar  '$'
    percent-sign          x  '%'                insertchar  '%'
    ampersand-sign        x  '\&'               insertchar  '\&'
    star                  x  '\*'               insertchar  '\*'
    plus                  x  '+'                insertchar  '+'
    comma                 x  ','                insertchar  ','
    dot                   x  '.'                insertchar  '.'
    forwardslash          x  '\\'               insertchar  '\\'
    backslash             x  '/'                insertchar  '/'
    colon                 x  ':'                insertchar  ':'
    semi-colon            x  '\;'               insertchar  '\;'
    left-angle-bracket    x  '\<'               insertchar  '\<'
    right-angle-bracket   x  '\>'               insertchar  '\>'
    equal-sign            x  '='                insertchar  '='
    question-mark         x  '\?'               insertchar  '\?'
    left-square-bracket   x  '['                insertchar  '['
    right-square-bracket  x  ']'                insertchar  ']'
    hat-sign              x  '^'                insertchar  '^'
    underscore            x  '_'                insertchar  '_'
    left-brace            x  '{'                insertchar  '{'
    right-brace           x  '\}'               insertchar  '\}'
    left-parenthesis      x  '\('               insertchar  '\('
    right-parenthesis     x  '\)'               insertchar  '\)'
    pipe                  x  '\|'               insertchar  '\|'
    tilde                 x  '\~'               insertchar  '\~'
    at-sign               x  '@'                insertchar  '@'
    dash                  x  '\-'               insertchar  '\-'
    double-quote          x  '\"'               insertchar  '\"'
    single-quote          x  "\'"               insertchar  "\'"
    backtick              x  '\`'               insertchar  '\`'
    whitespace            x  '\ '               insertchar  '\ '
) {
    eval "function widget::key-$keyname() {
        widget::util-$mode $widget \$@
    }"
    zle -N widget::key-$keyname
    bindkey $seq widget::key-$keyname
}

# suggested by "e.nikolov", fixes autosuggest completion being 
# overriden by keybindings: to have [zsh] autosuggest [plugin
# feature] complete visible suggestions, you can assign an array
# of shell functions to the `ZSH_AUTOSUGGEST_ACCEPT_WIDGETS` 
# variable. when these functions are triggered, they will also 
# complete any visible suggestion. Example:
export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
    widget::key-right
    widget::key-shift-right
    widget::key-cmd-right
    widget::key-shift-cmd-right
)

Bonus

Some people might also find these useful, though I didn't include them above, just add them to the for-loop array:

    Tab

        tab                   x  $'\x09'           insertchar  '\   '

            note that tab completion will fail

    Other

        send              kEND   $'\E[1;2F'        select      end-of-line
        send2             x      $'\E[4;2~'        select      end-of-line

        shome             kHOM   $'\E[1;2H'        select      beginning-of-line
        shome2            x      $'\E[1;2~'        select      beginning-of-line

        end               kend   $'\EOF'           deselect    end-of-line
        end2              x      $'\E4~'           deselect    end-of-line

        home              khome  $'\EOH'           deselect    beginning-of-line
        home2             x      $'\E1~'           deselect    beginning-of-line

        csend             x      $'\E[1;6F'        select      end-of-line
        cshome            x      $'\E[1;6H'        select      beginning-of-line

        cleft             x      $'\E[1;5D'        deselect    backward-word
        cright            x      $'\E[1;5C'        deselect    forward-word

        del               kdch1   $'\E[3~'         delregion   delete-char

    OLD but maybe still useful for some

Note

Certain keyboard key sequences were first configured on the terminal application (in my case iTerm2) to send the shell program specific signals. The bindings used in the above code are:

➤ iTerm2
   ➤ Preferences
     ➤ Keys
       ➤ Key Bindings:

Key Sequence 	Keybinding
cmd+shift+left 	Send Escape Sequence: a
cmd+shift+right 	Send Escape Sequence: e
ctrl+shift+a 	Send Escape Sequence: a
ctrl+shift+e 	Send Escape Sequence: e
cmd+left 	Send Hex Codes: \x01
cmd+right 	Send Hex Codes: \x05
cmd+a 	Send Escape Sequence: å
cmd+c 	Send Escape Sequence: ç
cmd+v 	Send Escape Sequence: √
cmd+x 	Send Escape Sequence: ≈
cmd+z 	Send Escape Sequence: Ω
cmd+shift+z 	Send Escape Sequence: ¸

This step binds terminal keys to shell signals, i.e tells the terminal program/application (iTerm2) what signals to send the shell program (zsh) upon pressing certain keyboard key sequences. Depending on your terminal program, and preference, you can bind your keys however you'd like, or use the default signals.

keyboard  -->  cmd+z  -->  iTerm2  -->  ^[Ω  -->  zsh  -->  undo (widget)

Then the script above binds the received signals to shell functions, called widgets. I.e we tell the shell program, to run a specified widget upon receiving a specified signal (key sequence).

So on your command-line, upon pressing keyboard key sequences, the terminal sends the appropriate signal to the shell, and the shell calls the corresponding widget (function). The functions we tell the shell to bind to are in this case functions that edit the command-line itself, as though it was a file.

The widgets defined above use zsh's builtin zle (zsh line editor) module API. For more information you can see the official documentation: ZSH ➤ 18 Zsh Line Editor, and official guide: ZSH ➤ Chapter 4: The Z-Shell Line Editor.

        A neat trick to see what signals are received by the shell is running cat and then pressing keys:

        ❯ cat
        ^[[1;2D^[[1;2C^[Ω^[≈^[ç

        That was the output for after having pressed: shift-left, shift-right, cmd+z, cmd+x, and cmd+c.

        Certain keys might not appear. In this case, check your terminal's configurations, the key might be binded to some terminal functionality (e.g. cmd+n might open up a new terminal pane, cmd+t might open up a new terminal tab).

        Also see terminfo(5), another way of finding certain keys.

Known Issues & Issue Fixes

    if you're on iTerm2, changing what cmd+v is binded to might make pasting on anything other than the command-line act different, and requires remapping on that specific program (e.g. in the search prompts for programs like less). if you want to avoid this, then don't change the mapping of iTerm2's cmd+v, and comment-out/remove the widget::paste.

    esc might clash with oh-my-zsh's sudo plugin and give weird behavior. You can comment-out/remove the esc line in the array, or suggest a fix.

    right clashes with zsh-autosuggestion, i.e it won't accept the suggestion. You can comment-out/remove right from the array, or suggest a fix. This is probably possible, I just currently don't know how, and spent enough time for now trying.

    I tried many things, I think the closest thing to working might of been something like:

    function widget::key-right() {
        REGION_ACTIVE=0
        zle autosuggest-accept
        zle forward-char
    }
    zle -N widget::key-right
    bindkey $'\eOC' widget::key-right

    But to no avail. It doesn't complete the suggestion. You could however always create a new keybinding for it:

    bindkey $'\e\'' autosuggest-accept

    I got autosuggestion-accept from the Github repo: zsh-users/zsh-autosuggestions.

    To fix right-key clashing with zsh-autosuggestion, and/or other clashes you might have, add to one of your shell initialization files (e.g. .zshrc) the following: export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(<shell-function> ...) (suggested by @e.nikolov). see above for an example.

Share
Follow
edited Feb 5 at 8:45
answered Aug 30, 2021 at 16:39
user avatar
8c6b5df0d16ade6c
86277 silver badges99 bronze badges

    1
    The autosuggest worked when I did this: export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=widget::key-right – 
    e.nikolov
    Jan 29 at 19:23 

thx it works great – 
8c6b5df0d16ade6c
Jan 30 at 5:23
1
It should probably be export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(widget::key-right widget::key-shift-right widget::key-shift-cmd-right widget::key-cmd-right). If it's not an array, there are some other compatibility issues. – 
e.nikolov
Jan 30 at 19:02
oh cool @e.nikolov, even better – 
8c6b5df0d16ade6c
Jan 31 at 6:11

