To open fzf from MacVim in a new iTerm2 window, create an executable script with the following content and add `let g:fzf_launcher = "PATH_TO_THE_SCRIPT_FILE %s"` to your Vim configuration.

# For iTerm2 version 3.0 and higher

(Added by @amacdougall)

The Applescript API for iTerm2 has changed with version 3.0. This updated script works for me:

```bash
#!/bin/bash

# update for iterm2 3.0+
osascript -e \
$'on run argv
    tell application "System Events"
        set old_frontmost to item 1 of (get name of processes whose frontmost is true)
    end tell
    tell application "iTerm2"
        set myterm to (create window with default profile)
        tell myterm
          select
        end
        tell current session of myterm
            write text "cd " & quoted form of (item 2 of argv)
            write text "bash -c \'" & (item 1 of argv) & " && exit\'"
        end tell
        repeat while (exists myterm)
            delay 0.1
        end repeat
    end tell
    tell application old_frontmost
        activate
    end tell
end run' "$1" "$PWD"
```

The `tell myterm select` may be helpful when the new window opens on a monitor which does not have the main iTerm2 window. My system, running macOS Sierra, does not automatically focus the newly opened window.

Here is JavaScript (JXA) mutation (by @chew-z):

```javascript
#!/usr/bin/env osascript -l JavaScript
// osacompile -l JavaScript -o fzf_MacVim.scpt fzf_MacVim.js

ObjC.import('stdlib')
function run(argv) {
    'use strict';
    const iTerm = Application('iTerm');
    const SystemEvents = Application('System Events');
    const frontmost = Application.currentApplication();                         // MacVim

    iTerm.includeStandardAdditions = true;
    const verbose = false;

    var args = $.NSProcessInfo.processInfo.arguments                            
    var argv = []
    var argc = args.count
    for (var i = 4; i < argc; i++) {
        // skip 3-word run command at top and this file's name
        // console.log($(args.objectAtIndex(i)).js)                             
        argv.push(ObjC.unwrap(args.objectAtIndex(i)))                           
    }
    if (verbose) { console.log(argv);     }                                     // print arguments

    iTerm.activate();
    let win = iTerm.createWindowWithProfile('fzf');
    delay(0.2);
    let fzf_session = win.currentSession();
    SystemEvents.keystroke('l', {using: 'control down'});                       // Clear screen from artefacts
    delay(0.2);
    let cmd1 = "cd " + argv[1];                                                 // cd $PWD
    iTerm.write(fzf_session,{text: cmd1});
    delay(0.2);
    let cmd2 = argv[0] + " && exit";                                            // fzf command && exit
    iTerm.write(fzf_session,{text: cmd2});
    delay(0.2);
    while (fzf_session.isProcessing()) {                                        // wait until fzf finished
        delay(0.2);
    }
    frontmost.activate();                                                       // bring back MacVim
    // $.exit(0);
}

```

You could compile script above using command ``` osacompile -l JavaScript -o fzf_MacVim.scpt fzf_MacVim.js ```

and then put inside fzf_MacVim.sh (your g:fzf_launcher). 

```
osascript -l JavaScript /path/to/fzf_MacVim.scpt "$1" $PWD
```

I recommend creating separate iTerm profile for fzf interaction. 

# For iTerm2 version 2.x

(Originally posted by @gleachkr)

To open fzf from MacVim in a new iTerm2 window, create an executable script with the following content and add `let g:fzf_launcher = "PATH_TO_THE_SCRIPT_FILE %s"` to your Vim configuration.

```bash
#!/bin/bash

osascript -e \
'on run argv
    tell application "System Events"
        set old_frontmost to item 1 of (get name of processes whose frontmost is true)
    end tell
    tell application "iTerm"
        activate
        set myterm to (make new terminal)
        tell myterm
            set mysession to (make new session at the end of sessions)
            tell mysession
                exec command "bash"
                write text "cd " & quoted form of (item 2 of argv)
                write text (item 1 of argv) & " && exit"
            end tell
            repeat while (exists myterm)
                delay 0.1
            end repeat
        end tell
    end tell
    tell application old_frontmost
        activate
    end tell
end run' "$1" "$PWD"
```

to control the size of the generated iTerm window you just need to insert the lines

```applescript
      set number of columns of myterm to C
      set number of rows of myterm to R
```
for some numbers C,R after `set myterm to (make new terminal)`

**And for zsh**:

```sh
#!/usr/local/bin/zsh

osascript -e \
'on run argv
    tell application "System Events"
        set old_frontmost to item 1 of (get name of processes whose frontmost is true)
    end tell
    tell application "iTerm"
        activate
        set myterm to (make new terminal)
        # set number of columns of myterm to 250
        # set number of rows of myterm to 30
        tell myterm
            set mysession to (make new session at the end of sessions)
            tell mysession
                exec command "env PATH=/usr/local/bin/:$PATH /usr/local/bin/zsh -f"
                write text "cd " & quoted form of (item 2 of argv)
                write text (item 1 of argv) & " && exit"
            end tell
            repeat while (exists myterm)
                delay 0.1
            end repeat
        end tell
    end tell
    tell application old_frontmost
        activate
    end tell
end run' $1 $PWD
```

And put it in PATH (I've put it in `/usr/local/bin`)

Note: it doesn't work very well if you've got an instance of iTerm2 running in full screen

