[ Stack Overflow ][1]

  1. [About][2]
  2. Products 
  3. [For Teams][3]



  1. [ Stack Overflow Public questions & answers ][4]
  2. [ Stack Overflow for Teams Where developers & technologists share private knowledge with coworkers ][3]
  3. [ Talent Build your employer brand  ][5]
  4. [ Advertising Reach developers & technologists worldwide ][6]
  5. [About the company][2]



Loading…

  1. ###  [current community][1]

    * [ Stack Overflow  ][1]

[help][7] [chat][8]

    * [ Meta Stack Overflow  ][9]

###  your communities 

[Sign up][10] or [log in][11] to customize your list. 

### [more stack exchange communities][12]

[company blog][13]

  2.   3. [Log in][14]
  4. [Sign up][15]



  1. [ Home  ][16]
  2.     1. Public
    2. [ Questions ][4]
    3. [ Tags  ][17]
    4. [ Users  ][18]
    5. [ Companies  ][19]
    6. Collectives

[ ][20]

    7. [ Explore Collectives ][21]
  3. Teams

**Stack Overflow for Teams** – Start collaborating and sharing organizational knowledge.  [Create a free Team][22] [Why Teams?][23]

    1. Teams

[ ][20]

    2. [ Create free Team  ][24]



Collectives on Stack Overflow

Find centralized, trusted content and collaborate around the technologies you use most.

[ Learn more ][21]

**Teams**

Q&A for work

Connect and share knowledge within a single location that is structured and easy to search.

[ Learn more ][23]

# [Zsh zle shift selection][25]

[ Ask Question ][26]

Asked 11 years, 1 month ago

Modified [1 month ago][27]

Viewed 8k times 

19 

10

[][28]

How to use shift to select part of the commandline (like in many text editors) ?

[shell][29] [zsh][30] [zsh-zle][31]

[Share][32]

[Improve this question][33]

Follow 

[edited Mar 6, 2017 at 21:58][34]

[user avatar][35]

[paulmelnikow][35]

16.5k77 gold badges6060 silver badges112112 bronze badges

asked Mar 23, 2011 at 15:46

[user avatar][36]

[log0][36]log0

10.2k33 gold badges2424 silver badges6161 bronze badges

8

  * Which OS ? Which terminal ? Also, this might be better asked on [SuperUser][37] as it isn't programming related (but I guess programmers are more likely to use a CLI ;-)

– [DarkDust][38]

Mar 23, 2011 at 15:50

  * Well hopefully I am looking an answer not platform or terminal dependent. Then you are right for superUser but the answer is potentially a zle script so ...

– [log0][39]

Mar 23, 2011 at 16:04

  * No idea what zle is, but on Unix a "selection" is a feature implemented by each terminal. It's not a basic functionality and for example on "real" terminals like text mode consoles or hardware terminal there is no support for selection (as far as I'm aware).

– [DarkDust][38]

Mar 23, 2011 at 16:12

  * In zsh "selection" or marks are handled by zle (the zsh line editor) for what I now.

– [log0][39]

Mar 23, 2011 at 16:23

  * @Ugo How do you do selection? I do not know any default widgets neither for selections nor for marks, so it is likely handled by terminal.

– [ZyX][40]

Mar 23, 2011 at 17:56




 |  Show **3** more comments

##  5 Answers 5

Sorted by:  [ Reset to default ][41]

Highest score (default)  Trending (recent votes count more)  Date modified (newest first)  Date created (oldest first) 

Help us improve our answers.

Are the answers below sorted in a way that puts the best answer at or near the top?

Take a short survey I’m not interested

37 

[][42]

Expanding on Stephane's excellent answer from almost 3 years ago, I added some more bindings to make the behaviour (almost) completely consistent with all of Windows' standard keyboard behaviour:

  * Selection is cleared when using a navigation key (arrow, home, end) WITHOUT shift
  * `Backspace` and `Del` delete an active selection
  * Selection is extended to the next/previous word when using `Ctrl+Shift+Left`/`Ctrl+Shift+Right`
  * `Shift+Home` and `Shift+End` extend the selection to the beginning and end of line respectively. `Ctrl+Shift+Home` and `Ctrl+Shift+End` do the same.



Two things that are not exactly the same:

  * Extending a selection to the next word includes trailing space, unlike windows. This could be fixed, but it doesn't bother me.
  * Typing when there is an active selection will not delete it and replace it with the character you typed. This would seem to require a lot more work to remap the entire keyboard. Not worth the trouble to me.



Note that the default mintty behaviour is to bind `Shift+End` and `Shift+Home` to access the scroll back buffer. This supercedes the zsh configuration; the keys never get passed through. In order for these to work, you will need to configure a different key (or disable scroll back) in `/etc/minttyrc` or `~/.minttyrc`. See "modifier for scrolling" [here][43] \- the simplest solution is just set `ScrollMod=2` to bind it to `Alt` instead of `Shift`.

So everything:

### ~/.minttyrc
[code] 
    ScrollMod=2
    
[/code]

### ~/.zshrc
[code] 
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
    
[/code]

This covers keycodes from several different keyboard configurations I have used.

**Note:** the values in the "key" column don't mean anything, they are just used to build a named reference for zle. They could be anything. What is important is the `seq`, `mode` and `widget` columns.

**Note 2:** You can bind pretty much any keys you want, you just need the key codes used in your console emulator. Open a regular console (without running zsh) and type **Ctrl+V** and then the key you want. It should emit the code. `^[` means `\E`.

[Share][44]

[Improve this answer][45]

Follow 

[edited Jun 9, 2018 at 14:46][46]

[user avatar][47]

[andsens][47]

6,23644 gold badges2525 silver badges2525 bronze badges

answered Jun 17, 2015 at 18:17

[user avatar][48]

[Jamie Treworgy][48]Jamie Treworgy

23.5k88 gold badges7272 silver badges117117 bronze badges

6

  * Where can I find more documentation on `shome`, `csleft`, etc? Google is not friendly here.

– [Myer][49]

Oct 13, 2015 at 12:45

  * 2

How can I swap out ctrl for alt here? Also, how can I make these compatible with ubuntu and xterm as well?

– [Myer][49]

Oct 13, 2015 at 12:56

  * Unfortunately rebinding backspace in this way breaks typing backspace during `bck-i-search`.

– [Vladimir Panteleev][50]

Oct 10, 2019 at 21:34

  * @VladimirPanteleev True - I can't figure out a good workaround - it seems to have special behavior (e.g. `backward-delete-char` which is the default binding for BS doens't act the same when called from a function in the `bck-i-search` context). You can still use CTRL+H as backspace; I guess one needs to decide whether BS key should work in this context or on the normal CLI.

– [Jamie Treworgy][51]

Oct 17, 2019 at 13:57

  * this helps (why is this not default?) But having alt/option instead of ctrl would help even more

– [Havnar][52]

Sep 14, 2020 at 16:34




 |  Show **1** more comment

8 

[][53]

Expanded on Jamie Treworgy's answer.

Includes the following functionality:

  * `cmd+a`: select entire command-line prompt text
  * `cmd+x`: cut (copy & delete) current command-line selection to clipboard
  * `cmd+c`: copy current command-line selection to clipboard
  * `cmd+v`: pastes clipboard selection
  * `ctrl+u`: delete backwards till beginning of line
  * `cmd+z`: undo
  * `cmd+shift+z`: redo
  * **shift select** : 
    * `shift-left`: select character to the left
    * `shift-right`: select character to the right
    * `shift-up`: select line upwards
    * `shift-down`: select live downwards
    * `cmd-shift-left`: select till beginning of line
    * `cmd-shift-right`: select till end of line
    * `alt-shift-left`: select word to the left
    * `alt-shift-right`: select word to the right
    * `ctrl-shift-left`: select till beginning of line
    * `ctrl-shift-right`: select till end of line
    * `ctrl-shift-a`: select till beginning of line
    * `ctrl-shift-e`: select till end of line
  * **unselect** : works as expected, on `left/right`, `alt-left/right`, `cmd/ctrl-left/right`, `esc+esc`.
  * **delete selection** : works as expected on `Delete`, `ctrl+d`, `backspace`
  * **delete selection & insert character**: works as expected for all visible ASCII characters and whitespace
  * **delete selection & insert clipboard**: works as expected



* * *

##### `.zshrc`
[code] 
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
    
[/code]

* * *

##### Bonus

Some people might also find these useful, though I didn't include them above, just add them to the for-loop array:

  1. Tab
[code]         tab                   x  $'\x09'           insertchar  '\   '
    
[/code]

>     * note that tab completion will fail

  2. Other
[code]         send              kEND   $'\E[1;2F'        select      end-of-line
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
    
[/code]




* * *

> OLD but maybe still useful for some

##### Note

Certain keyboard key sequences were first configured on the terminal application (in my case iTerm2) to send the shell program specific signals. The bindings used in the above code are:
[code] 
    ➤ iTerm2
       ➤ Preferences
         ➤ Keys
           ➤ Key Bindings:
    
[/code]

Key Sequence      | Keybinding                
------------------|---------------------------
`cmd+shift+left`  | Send Escape Sequence: `a` 
`cmd+shift+right` | Send Escape Sequence: `e` 
`ctrl+shift+a`    | Send Escape Sequence: `a` 
`ctrl+shift+e`    | Send Escape Sequence: `e` 
`cmd+left`        | Send Hex Codes: `\x01`    
`cmd+right`       | Send Hex Codes: `\x05`    
`cmd+a`           | Send Escape Sequence: `å` 
`cmd+c`           | Send Escape Sequence: `ç` 
`cmd+v`           | Send Escape Sequence: `√` 
`cmd+x`           | Send Escape Sequence: `≈` 
`cmd+z`           | Send Escape Sequence: `Ω` 
`cmd+shift+z`     | Send Escape Sequence: `¸` 



This step binds terminal keys to shell signals, i.e tells the terminal program/application (iTerm2) what signals to send the shell program (`zsh`) upon pressing certain keyboard key sequences. Depending on your terminal program, and preference, you can bind your keys however you'd like, or use the default signals.
[code] 
    keyboard  -->  cmd+z  -->  iTerm2  -->  ^[Ω  -->  zsh  -->  undo (widget)
    
[/code]

Then the script above binds the received signals to shell functions, called widgets. I.e we tell the shell program, to run a specified widget upon receiving a specified signal (key sequence).

So on your command-line, upon pressing keyboard key sequences, the terminal sends the appropriate signal to the shell, and the shell calls the corresponding widget (function). The functions we tell the shell to bind to are in this case functions that edit the command-line itself, as though it was a file.

The widgets defined above use `zsh`'s builtin `zle` (zsh line editor) module API. For more information you can see the official documentation: [ZSH ➤ 18 Zsh Line Editor][54], and official guide: [ZSH ➤ Chapter 4: The Z-Shell Line Editor][55].

>   * A neat trick to see what signals are received by the shell is running `cat` and then pressing keys:
[code] >     ❯ cat
>     ^[[1;2D^[[1;2C^[Ω^[≈^[ç
>     
[/code]
> 
> That was the output for after having pressed: `shift-left`, `shift-right`, `cmd+z`, `cmd+x`, and `cmd+c`.
> 
> Certain keys might not appear. In this case, check your terminal's configurations, the key might be binded to some terminal functionality (e.g. `cmd+n` might open up a new terminal pane, `cmd+t` might open up a new terminal tab).
> 
> Also see `terminfo(5)`, another way of finding certain keys.
> 
> 


* * *

#### Known Issues & Issue Fixes

  * if you're on iTerm2, changing what `cmd+v` is binded to might make pasting on anything other than the command-line act different, and requires remapping on that specific program (e.g. in the search prompts for programs like `less`). if you want to avoid this, then don't change the mapping of iTerm2's `cmd+v`, and comment-out/remove the `widget::paste`.

  * `esc` might clash with `oh-my-zsh`'s `sudo` plugin and give weird behavior. You can comment-out/remove the `esc` line in the array, or suggest a fix.

  * ~~`right` clashes with `zsh-autosuggestion`, i.e it won't accept the suggestion. You can comment-out/remove `right` from the array, or suggest a fix. This is probably possible, I just currently don't know how, and spent enough time for now trying.

I tried many things, I think the closest thing to working might of been something like:
[code]     function widget::key-right() {
        REGION_ACTIVE=0
        zle autosuggest-accept
        zle forward-char
    }
    zle -N widget::key-right
    bindkey $'\eOC' widget::key-right
    
[/code]

But to no avail. It doesn't complete the suggestion. You could however always create a new keybinding for it:
[code]     bindkey $'\e\'' autosuggest-accept
    
[/code]

I got `autosuggestion-accept` from the Github repo: [zsh-users/zsh-autosuggestions][56].~~

To fix right-key clashing with `zsh-autosuggestion`, and/or other clashes you might have, add to one of your shell initialization files (e.g. `.zshrc`) the following: `export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(<shell-function> ...)` (suggested by [@e.nikolov][57]). see above for an example.




[Share][58]

[Improve this answer][59]

Follow 

[edited Feb 5 at 8:45][60]

answered Aug 30, 2021 at 16:39

[user avatar][61]

[8c6b5df0d16ade6c][61]8c6b5df0d16ade6c

86277 silver badges99 bronze badges

4

  * 1

The autosuggest worked when I did this: `export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=widget::key-right`

– [e.nikolov][62]

Jan 29 at 19:23

  * thx it works great

– [8c6b5df0d16ade6c][63]

Jan 30 at 5:23

  * 1

It should probably be `export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(widget::key-right widget::key-shift-right widget::key-shift-cmd-right widget::key-cmd-right)`. If it's not an array, there are some other compatibility issues.

– [e.nikolov][62]

Jan 30 at 19:02

  * oh cool @e.nikolov, even better

– [8c6b5df0d16ade6c][63]

Jan 31 at 6:11




Add a comment  | 

23 

[][64]
[code] 
    shift-arrow() {
      ((REGION_ACTIVE)) || zle set-mark-command
      zle $1
    }
    shift-left()  shift-arrow backward-char
    shift-right() shift-arrow forward-char
    shift-up()    shift-arrow up-line-or-history
    shift-down()  shift-arrow down-line-or-history
    zle -N shift-left
    zle -N shift-right
    zle -N shift-up
    zle -N shift-down
    
    bindkey $terminfo[kLFT] shift-left
    bindkey $terminfo[kRIT] shift-right
    bindkey $terminfo[kri]  shift-up
    bindkey $terminfo[kind] shift-down
    
[/code]

That assumes your terminal sends a different escape sequence upon `Shift-Arrows` from the one sent upon `Arrow` and that your terminfo database is properly populated with corresponding kLFT and kRIT capabilities, and that you're using emacs style key binding.

Or, to factorize the code a bit:
[code] 
    shift-arrow() {
      ((REGION_ACTIVE)) || zle set-mark-command
      zle $1
    }
    for key  kcap seq        widget (
        left  LFT $'\e[1;2D' backward-char
        right RIT $'\e[1;2C' forward-char
        up    ri  $'\e[1;2A' up-line-or-history
        down  ind $'\e[1;2B' down-line-or-history
      ) {
      functions[shift-$key]="shift-arrow $widget"
      zle -N shift-$key
      bindkey ${terminfo[k$kcap]-$seq} shift-$key
    }
    
[/code]

Above, hardcoded sequences for cases where the terminfo database doesn't have the information (using `xterm` sequences).

[Share][65]

[Improve this answer][66]

Follow 

[edited Feb 17, 2021 at 10:17][67]

answered Aug 30, 2012 at 9:18

[user avatar][68]

[Stephane Chazelas][68]Stephane Chazelas

5,48322 gold badges2929 silver badges2929 bronze badges




Add a comment  | 

1 

[][69]

All solutions on this page are either incomplete or too invasive, so they negatively interfere with other plugins (e.g. zsh-autosuggestions or zsh-syntax-highlighting). I have therefore come up with a different approach that works significantly better.

<https://github.com/jirutka/zsh-shift-select/>

This plugin does not override any existing widgets and binds only shifted keys. It creates a new shift-select keymap that is automatically activated when the shift selection is invoked (using any of the defined shifted keys) and deactivated (the current keymap switches back to main) on any key that is not defined in the shift-select keymap. Thanks to this approach, it does not interfere with other plugins (for example, it works with zsh-autosuggestions without any change).

[Share][70]

[Improve this answer][71]

Follow 

answered Mar 13 at 0:41

[user avatar][72]

[Jakub Jirutka][72]Jakub Jirutka

9,44144 gold badges4040 silver badges3434 bronze badges




Add a comment  | 

0 

[][73]

Thanks for this answers, i take peace of all and do my script to select and copy just using keyboard.

if someone wanna filter to things be more clean i will appreciate.

its a part of ~/.zshrc file into home user folder.
[code] 
    alias pbcopy="xclip -selection clipboard"
    
    shift-arrow() {
    
    
    ((REGION_ACTIVE)) || zle set-mark-command 
      zle $1
    }
    for key  kcap seq        widget (
        left  LFT $'\e[1;2D' backward-char
        right RIT $'\e[1;2C' forward-char
        up    ri  $'\e[1;2A' up-line-or-history
        down  ind $'\e[1;2B' down-line-or-history
        super sup $'\ec' widget::copy-selection
      ) {
      functions[shift-$key]="shift-arrow $widget"
      zle -N shift-$key
      bindkey ${terminfo[k$kcap]-$seq} shift-$key
    }
     
    zle -N widget::copy-selection
    
    
    # copy selected terminal text to clipboard
    function widget::copy-selection {
        if ((REGION_ACTIVE)); then
            zle copy-region-as-kill
                printf "%s" $CUTBUFFER | pbcopy
        fi
    }
    
[/code]

i used de windows+c button to copy selected characters. I'm using ubuntu 20.04 and configured keyboard option to using win button like meta! After this in preferences of terminator i change paste shortcut to windows+v, jts because a think its be more faster like control+x and COntrol+v

[Share][74]

[Improve this answer][75]

Follow 

answered Sep 20, 2021 at 3:07

[user avatar][76]

[José Augusto][76]José Augusto

12111 silver badge88 bronze badges




Add a comment  | 

##  Your Answer 

Thanks for contributing an answer to Stack Overflow!

  * Please be sure to _answer the question_. Provide details and share your research!



But _avoid_ …

  * Asking for help, clarification, or responding to other answers.
  * Making statements based on opinion; back them up with references or personal experience.



To learn more, see our [tips on writing great answers][77].

Draft saved

Draft discarded

### Sign up or [log in][78]

Sign up using Google 

Sign up using Facebook 

Sign up using Email and Password 

Submit

### Post as a guest

Name

Email

Required, but never shown

### Post as a guest

Name

Email

Required, but never shown

Post Your Answer  Discard 

By clicking “Post Your Answer”, you agree to our [terms of service][79], [privacy policy][80] and [cookie policy][81]

##  Not the answer you're looking for? Browse other questions tagged [shell][29] [zsh][30] [zsh-zle][31] or [ask your own question][26]. 

The Overflow Blog 

  * [Empathy for the Dev: Avoiding common pitfalls when communicating with developers][82]

  * [Episode 436: Meet the design system that lets us customize and theme Stack...][83]

Featured on Meta 

  * [How might the Staging Ground & the new Ask Wizard work on the Stack Exchange...][84]

  * [Question Close Reasons project - Introduction and Feedback][85]

  * [An A/B test has gone live for a "Trending" sort option for answers][86]

  * [Overhauling our community's closure reasons and guidance][87]




[Visit chat][88]

#### Linked

[ 3 ][89] [How do I highlight text for copying and pasting in the VS Code terminal?][90]

[ 2 ][91] [Zsh shift+control+arrows][92]

#### Related

[ 1001 ][93] [Shell command to sum integers, one per line?][94]

[ 762 ][95] [How can I reverse the order of lines in a file?][96]

[ 2514 ][97] [How to mkdir only if a directory does not already exist?][98]

[ 2805 ][99] [In the shell, what does " 2>&1 " mean?][100]

[ 2537 ][101] [How do I split a string on a delimiter in Bash?][102]

[ 1517 ][103] [How to specify the private SSH-key to use when executing shell command on Git?][104]

[ 2147 ][105] [How do I set a variable to the output of a command in Bash?][106]

[ 2125 ][107] [How to delete from a text file, all lines that contain a specific string?][108]

[ 3088 ][109] [How do I copy a folder from remote to local using scp?][110]

[ 674 ][111] [zsh compinit: insecure directories][112]

####  [ Hot Network Questions ][113]

  * [ Why would far-left groups oppose Macron’s re-election? ][114]
  * [ Čech cohomology is isomorphic to singular cohomology ][115]
  * [ What is the French for 310? ][116]
  * [ Alien diplomat unable to lie settles bet about the most wonderful planet in the galaxy ][117]
  * [ Is DMCA takedown applicable for MIT License? ][118]
  * [ Pinging sound on new radial front wheel ][119]
  * [ Origin of the "angry/excited" meaning of "go nonlinear" ][120]
  * [ When do you receive the benefit to not leaving traces with Pass Without Trace? ][121]
  * [ Do the laws of war cover misinformation and psychological warfare? ][122]
  * [ The silhouette of a hand holding a cylindrical glass jar, in the background is the Milky Way ][123]
  * [ What might I do about the 1/4 to 3/4" gaps at the edges of my blacktop driveway? ][124]
  * [ Is a fused disconnect essential for mini-split outdoor unit? ][125]
  * [ Is this polynomial a square? ][126]
  * [ Why does a function has to be differentiable so many times to be considered smooth? ][127]
  * [ Best Way to Repair Damage to Exterior Door Shell ][128]
  * [ What is The Most Probable Way The USA Can Become A Dictatorship? ][129]
  * [ What is an easy way to transform an equality into a replacement rule ][130]
  * [ Can I write a FULL OUTER JOIN without OR IS NULL? ][131]
  * [ How can I propagate const when returning a std::vector<int*> from a const method? ][132]
  * [ Why does Job say 'shall I return there' in Job 1:21? ][133]
  * [ How do you deal with disrepectful/angry coworker? ][134]
  * [ Pros/Cons of 3D printed part cooling mods ][135]
  * [ Sailing from north east Russia to Pakistan in a straight line ][136]
  * [ Dental insurance isn't really a type of insurance? ][137]

more hot questions 

[ Question feed ][138]

#  Subscribe to RSS 

Question feed 

To subscribe to this RSS feed, copy and paste this URL into your RSS reader.

lang-sh

[][1]

##### [Stack Overflow][1]

  * [Questions][4]
  * [Help][139]



##### [Products][140]

  * [Teams][23]
  * [Advertising][6]
  * [Collectives][141]
  * [Talent][5]



##### [Company][2]

  * [About][2]
  * [Press][142]
  * [Work Here][143]
  * [Legal][144]
  * [Privacy Policy][80]
  * [Terms of Service][145]
  * [Contact Us][146]
  * Cookie Settings
  * [Cookie Policy][81]



##### [Stack Exchange Network][147]

  * [ Technology ][148]
  * [ Culture & recreation ][149]
  * [ Life & arts ][150]
  * [ Science ][151]
  * [ Professional ][152]
  * [ Business ][153]
  * [ API ][154]
  * [ Data ][155]



  * [Blog][156]
  * [Facebook][157]
  * [Twitter][158]
  * [LinkedIn][159]
  * [Instagram][160]



Site design / logo © 2022 Stack Exchange Inc; user contributions licensed under [cc by-sa][161]. rev 2022.4.21.42004

Your privacy 

By clicking “Accept all cookies”, you agree Stack Exchange can store cookies on your device and disclose information in accordance with our [Cookie Policy][81]. 

Accept all cookies  Customize settings 

 

   [1]: https://stackoverflow.com
   [2]: https://stackoverflow.co/
   [3]: /teams
   [4]: /questions
   [5]: https://stackoverflow.co/talent
   [6]: https://stackoverflow.co/advertising
   [7]: https://stackoverflow.com/help
   [8]: https://chat.stackoverflow.com/?tab=site&host=stackoverflow.com
   [9]: https://meta.stackoverflow.com
   [10]: https://stackoverflow.com/users/signup?ssrc=site_switcher&returnurl=https%3a%2f%2fstackoverflow.com%2fquestions%2f5407916%2fzsh-zle-shift-selection
   [11]: https://stackoverflow.com/users/login?ssrc=site_switcher&returnurl=https%3a%2f%2fstackoverflow.com%2fquestions%2f5407916%2fzsh-zle-shift-selection
   [12]: https://stackexchange.com/sites
   [13]: https://stackoverflow.blog
   [14]: https://stackoverflow.com/users/login?ssrc=head&returnurl=https%3a%2f%2fstackoverflow.com%2fquestions%2f5407916%2fzsh-zle-shift-selection
   [15]: https://stackoverflow.com/users/signup?ssrc=head&returnurl=https%3a%2f%2fstackoverflow.com%2fquestions%2f5407916%2fzsh-zle-shift-selection
   [16]: /
   [17]: /tags
   [18]: /users
   [19]: https://stackoverflow.com/jobs/companies?so_medium=stackoverflow&so_source=SiteNav
   [20]: javascript:void(0)
   [21]: /collectives
   [22]: https://try.stackoverflow.co/why-teams/?utm_source=so-owned&utm_medium=side-bar&utm_campaign=campaign-38&utm_content=cta
   [23]: https://stackoverflow.co/teams
   [24]: https://stackoverflow.com/teams/create/free?utm_source=so-owned&utm_medium=side-bar&utm_campaign=campaign-38&utm_content=cta (Stack Overflow for Teams is a private, secure spot for your organization's questions and answers.)
   [25]: /questions/5407916/zsh-zle-shift-selection
   [26]: /questions/ask
   [27]: ?lastactivity (2022-03-13 00:41:58Z)
   [28]: /posts/5407916/timeline (Show activity on this post.)
   [29]: /questions/tagged/shell (show questions tagged 'shell')
   [30]: /questions/tagged/zsh (show questions tagged 'zsh')
   [31]: /questions/tagged/zsh-zle (show questions tagged 'zsh-zle')
   [32]: /q/5407916 (Short permalink to this question)
   [33]: /posts/5407916/edit ()
   [34]: /posts/5407916/revisions (show all edits to this post)
   [35]: /users/893113/paulmelnikow
   [36]: /users/323547/log0
   [37]: http://superuser.com
   [38]: /users/400056/darkdust (87,641 reputation)
   [39]: /users/323547/log0 (10,190 reputation)
   [40]: /users/273566/zyx (50,859 reputation)
   [41]: /questions/5407916/zsh-zle-shift-selection?answertab=scoredesc#tab-top
   [42]: /posts/30899296/timeline (Show activity on this post.)
   [43]: http://mintty.googlecode.com/svn-history/r1127/trunk/docs/mintty.1.html (here.)
   [44]: /a/30899296 (Short permalink to this answer)
   [45]: /posts/30899296/edit ()
   [46]: /posts/30899296/revisions (show all edits to this post)
   [47]: /users/339505/andsens
   [48]: /users/480527/jamie-treworgy
   [49]: /users/78202/myer (3,592 reputation)
   [50]: /users/21501/vladimir-panteleev (24,338 reputation)
   [51]: /users/480527/jamie-treworgy (23,468 reputation)
   [52]: /users/3154217/havnar (2,441 reputation)
   [53]: /posts/68987551/timeline (Show activity on this post.)
   [54]: https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Zsh-Line-Editor
   [55]: https://zsh.sourceforge.io/Guide/zshguide04.html#l75
   [56]: https://github.com/zsh-users/zsh-autosuggestions
   [57]: https://stackoverflow.com/users/2475128/e-nikolov
   [58]: /a/68987551 (Short permalink to this answer)
   [59]: /posts/68987551/edit ()
   [60]: /posts/68987551/revisions (show all edits to this post)
   [61]: /users/13992057/8c6b5df0d16ade6c
   [62]: /users/2475128/e-nikolov (95 reputation)
   [63]: /users/13992057/8c6b5df0d16ade6c (862 reputation)
   [64]: /posts/12193631/timeline (Show activity on this post.)
   [65]: /a/12193631 (Short permalink to this answer)
   [66]: /posts/12193631/edit ()
   [67]: /posts/12193631/revisions (show all edits to this post)
   [68]: /users/1627296/stephane-chazelas
   [69]: /posts/71453634/timeline (Show activity on this post.)
   [70]: /a/71453634 (Short permalink to this answer)
   [71]: /posts/71453634/edit ()
   [72]: /users/2217862/jakub-jirutka
   [73]: /posts/69248703/timeline (Show activity on this post.)
   [74]: /a/69248703 (Short permalink to this answer)
   [75]: /posts/69248703/edit ()
   [76]: /users/13641468/jos%c3%a9-augusto
   [77]: /help/how-to-answer
   [78]: /users/login?ssrc=question_page&returnurl=https%3a%2f%2fstackoverflow.com%2fquestions%2f5407916%2fzsh-zle-shift-selection%23new-answer
   [79]: https://stackoverflow.com/legal/terms-of-service/public
   [80]: https://stackoverflow.com/legal/privacy-policy
   [81]: https://stackoverflow.com/legal/cookie-policy
   [82]: https://stackoverflow.blog/2022/04/25/empathy-for-the-dev-avoiding-common-pitfalls-when-communicating-with-developers/
   [83]: https://stackoverflow.blog/2022/04/26/episode-436-meet-the-design-system-that-lets-us-customize-and-theme-stack-overflow/ (Episode 436: Meet the design system that lets us customize and theme Stack Overflow)
   [84]: https://meta.stackexchange.com/questions/377768/how-might-the-staging-ground-the-new-ask-wizard-work-on-the-stack-exchange-net (How might the Staging Ground & the new Ask Wizard work on the Stack Exchange network?)
   [85]: https://meta.stackoverflow.com/questions/417475/question-close-reasons-project-introduction-and-feedback
   [86]: https://meta.stackoverflow.com/questions/416486/an-a-b-test-has-gone-live-for-a-trending-sort-option-for-answers
   [87]: https://meta.stackoverflow.com/questions/417008/overhauling-our-communitys-closure-reasons-and-guidance
   [88]: https://chat.stackoverflow.com/
   [89]: /q/56517662 (Question score (upvotes - downvotes))
   [90]: /questions/56517662/how-do-i-highlight-text-for-copying-and-pasting-in-the-vs-code-terminal?noredirect=1
   [91]: /q/24911898 (Question score (upvotes - downvotes))
   [92]: /questions/24911898/zsh-shiftcontrolarrows?noredirect=1
   [93]: /q/450799 (Question score (upvotes - downvotes))
   [94]: /questions/450799/shell-command-to-sum-integers-one-per-line
   [95]: /q/742466 (Question score (upvotes - downvotes))
   [96]: /questions/742466/how-can-i-reverse-the-order-of-lines-in-a-file
   [97]: /q/793858 (Question score (upvotes - downvotes))
   [98]: /questions/793858/how-to-mkdir-only-if-a-directory-does-not-already-exist
   [99]: /q/818255 (Question score (upvotes - downvotes))
   [100]: /questions/818255/in-the-shell-what-does-21-mean
   [101]: /q/918886 (Question score (upvotes - downvotes))
   [102]: /questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash
   [103]: /q/4565700 (Question score (upvotes - downvotes))
   [104]: /questions/4565700/how-to-specify-the-private-ssh-key-to-use-when-executing-shell-command-on-git
   [105]: /q/4651437 (Question score (upvotes - downvotes))
   [106]: /questions/4651437/how-do-i-set-a-variable-to-the-output-of-a-command-in-bash
   [107]: /q/5410757 (Question score (upvotes - downvotes))
   [108]: /questions/5410757/how-to-delete-from-a-text-file-all-lines-that-contain-a-specific-string
   [109]: /q/11304895 (Question score (upvotes - downvotes))
   [110]: /questions/11304895/how-do-i-copy-a-folder-from-remote-to-local-using-scp
   [111]: /q/13762280 (Question score (upvotes - downvotes))
   [112]: /questions/13762280/zsh-compinit-insecure-directories
   [113]: https://stackexchange.com/questions?tab=hot
   [114]: https://politics.stackexchange.com/questions/72814/why-would-far-left-groups-oppose-macron-s-re-election
   [115]: https://mathoverflow.net/questions/421068/%c4%8cech-cohomology-is-isomorphic-to-singular-cohomology
   [116]: https://french.stackexchange.com/questions/50220/what-is-the-french-for-310
   [117]: https://scifi.stackexchange.com/questions/262517/alien-diplomat-unable-to-lie-settles-bet-about-the-most-wonderful-planet-in-the
   [118]: https://opensource.stackexchange.com/questions/12818/is-dmca-takedown-applicable-for-mit-license
   [119]: https://bicycles.stackexchange.com/questions/83640/pinging-sound-on-new-radial-front-wheel
   [120]: https://english.stackexchange.com/questions/588089/origin-of-the-angry-excited-meaning-of-go-nonlinear
   [121]: https://rpg.stackexchange.com/questions/197939/when-do-you-receive-the-benefit-to-not-leaving-traces-with-pass-without-trace
   [122]: https://law.stackexchange.com/questions/79644/do-the-laws-of-war-cover-misinformation-and-psychological-warfare
   [123]: https://puzzling.stackexchange.com/questions/115879/the-silhouette-of-a-hand-holding-a-cylindrical-glass-jar-in-the-background-is-t
   [124]: https://diy.stackexchange.com/questions/248244/what-might-i-do-about-the-1-4-to-3-4-gaps-at-the-edges-of-my-blacktop-driveway
   [125]: https://diy.stackexchange.com/questions/248305/is-a-fused-disconnect-essential-for-mini-split-outdoor-unit
   [126]: https://codegolf.stackexchange.com/questions/246526/is-this-polynomial-a-square
   [127]: https://math.stackexchange.com/questions/4436412/why-does-a-function-has-to-be-differentiable-so-many-times-to-be-considered-smoo
   [128]: https://mechanics.stackexchange.com/questions/88537/best-way-to-repair-damage-to-exterior-door-shell
   [129]: https://worldbuilding.stackexchange.com/questions/228979/what-is-the-most-probable-way-the-usa-can-become-a-dictatorship
   [130]: https://mathematica.stackexchange.com/questions/267337/what-is-an-easy-way-to-transform-an-equality-into-a-replacement-rule
   [131]: https://dba.stackexchange.com/questions/311321/can-i-write-a-full-outer-join-without-or-is-null
   [132]: https://stackoverflow.com/questions/71997744/how-can-i-propagate-const-when-returning-a-stdvectorint-from-a-const-method
   [133]: https://hermeneutics.stackexchange.com/questions/75915/why-does-job-say-shall-i-return-there-in-job-121
   [134]: https://workplace.stackexchange.com/questions/184414/how-do-you-deal-with-disrepectful-angry-coworker
   [135]: https://3dprinting.stackexchange.com/questions/19291/pros-cons-of-3d-printed-part-cooling-mods
   [136]: https://skeptics.stackexchange.com/questions/53234/sailing-from-north-east-russia-to-pakistan-in-a-straight-line
   [137]: https://money.stackexchange.com/questions/150582/dental-insurance-isnt-really-a-type-of-insurance
   [138]: /feeds/question/5407916 (Feed of this question and its answers)
   [139]: /help
   [140]: https://stackoverflow.com/?products
   [141]: https://stackoverflow.co/collectives
   [142]: https://stackoverflow.co/company/press
   [143]: https://stackoverflow.co/company/work-here
   [144]: https://stackoverflow.com/legal
   [145]: https://stackoverflow.com/legal/terms-of-service
   [146]: https://stackoverflow.co/company/contact
   [147]: https://stackexchange.com
   [148]: https://stackexchange.com/sites#technology
   [149]: https://stackexchange.com/sites#culturerecreation
   [150]: https://stackexchange.com/sites#lifearts
   [151]: https://stackexchange.com/sites#science
   [152]: https://stackexchange.com/sites#professional
   [153]: https://stackexchange.com/sites#business
   [154]: https://api.stackexchange.com/
   [155]: https://data.stackexchange.com/
   [156]: https://stackoverflow.blog?blb=1
   [157]: https://www.facebook.com/officialstackoverflow/
   [158]: https://twitter.com/stackoverflow
   [159]: https://linkedin.com/company/stack-overflow
   [160]: https://www.instagram.com/thestackoverflow
   [161]: https://stackoverflow.com/help/licensing

