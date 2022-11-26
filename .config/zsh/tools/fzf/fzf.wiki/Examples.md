*Disclaimer: The examples are maintained by the community and are not thoroughly tested.*

To add a script:
- check it runs on bash and zsh
- add it under an appropriate category in the ToC

Table of Contents
=================

* [General](#general)
* [Command history](#command-history)
* System
  * [i3](#i3)
  * [Copy current item to clipboard](#clipboard)
  * [Processes](#processes)
  * [dotfiles management](#dotfiles-management)
  * [Systemctl units](#systemctl-units)
  * [man pages](#man-pages)
* Package management
  * [Pacman/Yay](#pacman)
  * [NPM](#npm)
  * [Homebrew](#homebrew)
  * [Homebrew Cask](#homebrew-cask)
  * [DNF](#dnf)
  * [Flatpak](#flatpak)
* Filesystem navigation
  * [Opening files](#opening-files)
  * [Changing directory](#changing-directory)
  * [Searching file contents](#searching-file-contents)
  * [cd](#cd)
     * [Integration with <a href="https://github.com/changyuheng/zsh-interactive-cd">zsh-interactive-cd</a>.](#integration-with-zsh-interactive-cd)
     * [Interactive cd](#interactive-cd)
  * [autojump](#autojump)
     * [Integration with <a href="https://github.com/wting/autojump">autojump</a>](#integration-with-autojump)
  * [z](#z)
     * [Integration with <a href="https://github.com/rupa/z">z</a>.](#integration-with-z)
     * [With <a href="https://github.com/changyuheng/fz">fz</a>.](#with-fz)
     * [With <a href="https://github.com/clvv/fasd">fasd</a>.](#with-fasd-1)
  * [Locate](#locate)
  * [Browsing](#browsing)
* CLI Tools
  * [Git](#git)
  * [jrnl](#jrnl)
  * [tmux](#tmux)
  * [dictcc translation](#dictcc-translation)
  * [kubectl](#kubectl)
  * [pass and pass-tomb](#pass-and-pass-tomb)
* Moving from other tools
  * [fzf as selector menu (pipe entries like dmenu/rofi)](#fzf-as-selector-menu)
  * [fzf as rofi replacement](#fzf-as-rofi-replacement)
  * [fzf as dmenu replacement](#fzf-as-dmenu-replacement)
* [ctags](#ctags)
* [ASDF](#asdf)
* [Images](#images)
* [v](#v)
   * [Inspired by v. Opens files in ~/.viminfo](#inspired-by-v-opens-files-in-viminfo)
   * [With <a href="https://github.com/clvv/fasd">fasd</a>.](#with-fasd)
* [Shell bookmarks](#shell-bookmarks)
* [Google Chrome](#google-chrome)
   * [Browsing history](#browsing-history)
   * [Bookmarks](#bookmarks)
* [mpd](#mpd)
* [Readline](#readline)
* [RVM](#rvm)
* [Vagrant](#vagrant)
* [Wrapper](#wrapper)
* [LastPass CLI](#lastpass-cli)
* [fzf-marker](#fzf-marker)
* [Search for academic pdfs by author, title, keywords, abstract](#search-for-academic-pdfs-by-author-title-journal-institution)
* [BibTeX](#bibtex)
* [Docker](#docker)
* [buku](#buku)
* [Python Behave BDD](#python-behave-bdd)
* [Transmission](#transmission)
* [Todoist CLI](#Todoist-CLI)
* [Emoji](#Emoji)

Nice collection at https://github.com/DanielFGray/fzf-scripts

### General
```sh
# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extension mp3
# fm rm # To rm files in current directory
f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# Like f, but not recursive.
fm() f "$@" --max-depth 1

# Deps
alias fz="fzf-noempty --bind 'tab:toggle,shift-tab:toggle+beginning-of-line+kill-line,ctrl-j:toggle+beginning-of-line+kill-line,ctrl-t:top' --color=light -1 -m"
fzf-noempty () {
	local in="$(</dev/stdin)"
	test -z "$in" && (
		exit 130
	) || {
		ec "$in" | fzf "$@"
	}
}
ec () {
	if [[ -n $ZSH_VERSION ]]
	then
		print -r -- "$@"
	else
		echo -E -- "$@"
	fi
}
```

Inspired by the above, suggested by [Matt-A-Bennett](https://github.com/Matt-A-Bennett) (not tested in zsh):
```sh                                                                              
# Run command/application and choose paths/files with fzf.                      
# Always return control of the terminal to user (e.g. when opening GUIs).       
# The full command that was used will appear in your history just like any      
# other (N.B. to achieve this I write the shell's active history to             
# ~/.bash_history)                                                                
#                                                                               
# Usage:
# f cd [OPTION]... (hit enter, choose path)
# f cat [OPTION]... (hit enter, choose files)
# f vim [OPTION]... (hit enter, choose files)
# f vlc [OPTION]... (hit enter, choose files)

f() {
    # Store the program
    program="$1"

    # Remove first argument off the list
    shift

    # Store option flags with separating spaces, or just set as single space
    options="$@"
    if [ -z "${options}" ]; then
        options=" "
    else
        options=" $options "
    fi

    # Store the arguments from fzf
    arguments="$(fzf --multi)"

    # If no arguments passed (e.g. if Esc pressed), return to terminal
    if [ -z "${arguments}" ]; then
        return 1
    fi

    # We want the command to show up in our bash history, so write the shell's
    # active history to ~/.bash_history. Then we'll also add the command from
    # fzf, then we'll load it all back into the shell's active history
    history -w

    # ADD A REPEATABLE COMMAND TO THE BASH HISTORY ############################
    # Store the arguments in a temporary file for sanitising before being
    # entered into bash history
    : > /tmp/fzf_tmp
    for file in "${arguments[@]}"; do
        echo "$file" >> /tmp/fzf_tmp
    done

    # Put all input arguments on one line and sanitise the command by putting
    # single quotes around each argument, also first put an extra single quote
    # next to any pre-existing single quotes in the raw argument
    sed -i "s/'/''/g; s/.*/'&'/g; s/\n//g" /tmp/fzf_tmp

    # If the program is on the GUI list, add a '&' to the command history
    if [[ "$program" =~ ^(nautilus|zathura|evince|vlc|eog|kolourpaint)$ ]]; then
        sed -i '${s/$/ \&/}' /tmp/fzf_tmp
    fi

    # Grab the sanitised arguments
    arguments="$(cat /tmp/fzf_tmp)"

    # Add the command with the sanitised arguments to our .bash_history
    echo $program$options$arguments >> ~/.bash_history

    # Reload the ~/.bash_history into the shell's active history
    history -r

    # EXECUTE THE LAST COMMAND IN ~/.bash_history #############################
    fc -s -1

    # Clean up temporary variables
    rm /tmp/fzf_tmp
}
```
### Opening files

```sh
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}
```

```sh
# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
vf() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}
```

```sh
# fuzzy grep open via ag
vg() {
  local file

  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}

# fuzzy grep open via ag with line number
vg() {
  local file
  local line

  read -r file line <<<"$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}
```

### Changing directory

```sh
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
```

```sh
# Another fd - cd into the selected directory
# This one differs from the above, by only showing the sub directories and not
#  showing the directories within those.
fd() {
  DIR=`find * -maxdepth 0 -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}
```

```sh
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
```

```sh
# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}
```

```sh
# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
cf() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}
```

Suggested by [@harelba](https://github.com/harelba) and [@dimonomid](https://github.com/dimonomid):

```sh
# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
```

```sh
# Another CTRL-T script to select a directory and paste it into line
__fzf_select_dir ()
{
        builtin typeset READLINE_LINE_NEW="$(
                command find -L . \( -path '*/\.*' -o -fstype dev -o -fstype proc \) \
                        -prune \
                        -o -type f -print \
                        -o -type d -print \
                        -o -type l -print 2>/dev/null \
                | command sed 1d \
                | command cut -b3- \
                | env fzf -m
        )"

        if
                [[ -n $READLINE_LINE_NEW ]]
        then
                builtin bind '"\er": redraw-current-line'
                builtin bind '"\e^": magic-space'
                READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
        else
                builtin bind '"\er":'
                builtin bind '"\e^":'
        fi
}

builtin bind -x '"\C-x1": __fzf_select_dir'
builtin bind '"\C-t": "\C-x1\e^\er"'
```

Fuzzy cd for fish shell: https://gist.github.com/rumpelsepp/b1b416f52d6790de1aee

autojump(macOS) + fzf for fish shell: https://gist.github.com/l4u/06502cf680b9a3817efddfb0a9a6ede8

### Searching file contents

```sh
grep --line-buffered --color=never -r "" * | fzf

# with ag - respects .agignore and .gitignore
ag --nobreak --nonumbers --noheading . | fzf

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
```

```sh
# alternative using ripgrep-all (rga) combined with fzf-tmux preview
# This requires ripgrep-all (rga) installed: https://github.com/phiresky/ripgrep-all
# This implementation below makes use of "open" on macOS, which can be replaced by other commands if needed.
# allows to search in PDFs, E-Books, Office documents, zip, tar.gz, etc. (see https://github.com/phiresky/ripgrep-all)
# find-in-file - usage: fif <searchTerm> or fif "string with spaces" or fif "regex"
fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    local file
    file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$*" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$*"' {}")" && echo "opening $file" && open "$file" || return 1;
}
```

Suggested by [@gbstan](https://github.com/gbstan)

```sh
#!/bin/bash

##
# Interactive search.
# Usage: `ff` or `ff <folder>`.
#
[[ -n $1 ]] && cd $1 # go to provided folder or noop
RG_DEFAULT_COMMAND="rg -i -l --hidden --no-ignore-vcs"

selected=$(
FZF_DEFAULT_COMMAND="rg --files" fzf \
  -m \
  -e \
  --ansi \
  --disabled \
  --reverse \
  --bind "ctrl-a:select-all" \
  --bind "f12:execute-silent:(subl -b {})" \
  --bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
  --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
)

[[ -n $selected ]] && subl $selected # open multiple files in editor
```

Suggested by [@knoxknox](https://github.com/knoxknox)

```sh
#!/bin/bash
# Interactive search using ag (silver searcher)

[[ -n $1 ]] && cd $1 # go to provided folder or noop
typeset AG_DEFAULT_COMMAND="ag -i -l --hidden"
typeset IFS=$'\n'
typeset selected=($(
      fzf \
      -m \
      -e \
      --ansi \
      --disabled \
      --reverse \
      --print-query \
      --bind "change:reload:$AG_DEFAULT_COMMAND {q} || true" \
      --preview "ag -i --color --context=2 {q} {}"))
[ -n "$selected" ] && ${EDITOR} -c "/\\c${selected[0]}" ${selected[1]}
```

### Command history

```sh
# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
```

```sh
# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
```

Replacing `eval` with `print -z` will push the arguments onto the editing buffer stack, allowing you to edit the command before running it. It also means the command you run will appear in your history rather than just `fh`. Unfortunately this only works for zsh. See below for solutions working with Bash.

#### With write to terminal capabilities

These have been tested in bash.

```sh
# fh - repeat history
runcmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, <>' ; }

fh() {
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | runcmd
}

# fhe - repeat history edit
writecmd (){ perl -e 'ioctl STDOUT, 0x5412, $_ for split //, do{ chomp($_ = <>); $_ }' ; }

fhe() {Suggested by
  ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -re 's/^\s*[0-9]+\s*//' | writecmd
}
```

```sh
# Another CTRL-R script to insert the selected command from history into the command line/region
__fzf_history ()
{
    builtin history -a;
    builtin history -c;
    builtin history -r;
    builtin typeset \
        READLINE_LINE_NEW="$(
            HISTTIMEFORMAT= builtin history |
            command fzf +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
            command sed '
                /^ *[0-9]/ {
                    s/ *\([0-9]*\) .*/!\1/;
                    b end;
                };
                d;
                : end
            '
        )";

        if
                [[ -n $READLINE_LINE_NEW ]]
        then
                builtin bind '"\er": redraw-current-line'
                builtin bind '"\e^": magic-space'
                READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
        else
                builtin bind '"\er":'
                builtin bind '"\e^":'
        fi
}

builtin set -o histexpand;
builtin bind -x '"\C-x1": __fzf_history';
builtin bind '"\C-r": "\C-x1\e^\er"'
```

```sh
# re-wrote the script above
bind '"\C-r": "\C-x1\e^\er"'
bind -x '"\C-x1": __fzf_history';

__fzf_history ()
{
__ehc $(history | fzf --tac --tiebreak=index | perl -ne 'm/^\s*([0-9]+)/ and print "!$1"')
}

__ehc()
{
if
        [[ -n $1 ]]
then
        bind '"\er": redraw-current-line'
        bind '"\e^": magic-space'
        READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${1}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
        READLINE_POINT=$(( READLINE_POINT + ${#1} ))
else
        bind '"\er":'
        bind '"\e^":'
fi
}
```

### Processes

```sh
# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
```
```sh
# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}
```

### Systemctl units

The https://github.com/NullSense/fuzzy-sys project implements frequently used systemctl unit file manipulating commands.

### Git

List all available git commands and help with [`git-commands`](https://github.com/hankchanocd/git-commands) 

```sh
# fbr - checkout git branch
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi) || return
  git checkout $(awk '{print $2}' <<<"$target" )
}


# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

```

```sh
# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}
```

```sh
# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
```
```sh
alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

# fcoc_preview - checkout git commit with previews
fcoc_preview() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow_preview - git commit browser with previews
fshow_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}
```
Compare against `master` branch with [`git-stack`](https://github.com/hankchanocd/git-stack) 

```sh
# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}
```

```sh
# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}
```

Create a gitignore file from [gitignore.io](http://gitignore.io):

https://gist.github.com/phha/cb4f4bb07519dc494609792fb918e167

```sh
# fgst - pick files from `git status -s` 
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fgst() {
  # "Nothing to see here, move along"
  is_in_git_repo || return

  local cmd="${FZF_CTRL_T_COMMAND:-"command git status -s"}"

  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while read -r item; do
    echo "$item" | awk '{print $2}'
  done
  echo
}
```

Interactive fixup of a commit

```
function git-fixup () {
  git ll -n 20 | fzf | cut -f 1 | xargs git commit --no-verify --fixup
}
```

Usage: 

```
git fixup
git rebase -i master --autosquash
```

[Article on fixup and autosquash](https://fle.github.io/git-tip-keep-your-branch-clean-with-fixup-and-autosquash.html).


[The shell plugin `forgit`](https://github.com/wfxr/forgit) implemented the frequently used commands with some improves(support `bash`, `zsh` and `fish`):

![forgit-ga](https://raw.githubusercontent.com/wfxr/i/master/forgit-ga.png)

![forgit-glo](https://raw.githubusercontent.com/wfxr/i/master/forgit-glo.png)

![forgit-gi](https://raw.githubusercontent.com/wfxr/i/master/forgit-gi.png)



### [jrnl](https://github.com/jrnl-org/jrnl)

Suggested by [@windisch](https://github.com/windisch).

```sh
# fjrnl - Search JRNL headlines
fjrnl() {                                                                                                                                                                                               
  title=$(jrnl --short | fzf --tac --no-sort) &&                                                                                                                                                         
  jrnl -on "$(echo $title | cut -c 1-16)" $1                                                                                                                                                             
  } 
```

### ctags

```sh
# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2
  ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}
```

```sh
# ftags - search ctags with preview
# only works if tags-file was generated with --excmd=number
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    fzf \
      --nth=1,2 \
      --with-nth=2 \
      --preview-window="50%" \
      --preview="bat {3} --color=always | tail -n +\$(echo {4} | tr -d \";\\\"\")"
  ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}
```

### tmux

```zsh
# zsh; needs setopt re_match_pcre. You can, of course, adapt it to your own shell easily.
tmuxkillf () {
    local sessions
    sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
    local i
    for i in "${(f@)sessions}"
    do
        [[ $i =~ '([^:]*):.*' ]] && {
            echo "Killing $match[1]"
            tmux kill-session -t "$match[1]"
        }
    done
}
```

```sh
# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}
```

```sh
# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}
```

```sh
# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

# In tmux.conf
# bind-key 0 run "tmux split-window -l 12 'bash -ci ftpane'"
```

To search for windows and show which is currently active, add [ftwind](https://github.com/pokey/dotfiles/blob/dade6c88af31458c323e8f0247af510bca7af0f5/bin/ftwind) somewhere in your path.  Then add eg `bind-key f run -b ftwind` to your `tmux.conf`.

### Select pane

Allows you to select pane with `bind-key + 0`.
Requires [`ftpane()` function](https://github.com/junegunn/fzf/wiki/Examples#tmux).

```sh
# Index starts from 1
set-option -g base-index 1

# select-pane (@george-b)
bind-key 0 run "tmux split-window -p 40 'bash -ci ftpane'"
```

### Search entire file system (ALT-`)

ALT-` key will split the current window and start fzf for the entire list of files. The selected files will be pasted on to the original window.

```sh
# fzf-locate
bind-key -n 'M-`' run "tmux split-window -p 40 'tmux send-keys -t #{pane_id} \"$(locate / | fzf -m | paste -sd\\  -)\"'"
```

### kubectl
Add support for kubectl completion with fzf
```bash
# BASH
# Tested kubectl version `v1.23.6`
# Make all kubectl completion fzf
command -v fzf >/dev/null 2>&1 && { 
	source <(kubectl completion bash | sed 's#"${requestComp}" 2>/dev/null#"${requestComp}" 2>/dev/null | head -n -1 | fzf  --multi=0 #g')
}

# ZSH
# Make all kubectl completion fzf
command -v fzf >/dev/null 2>&1 && { 
	source <(kubectl completion zsh | sed 's#${requestComp} 2>/dev/null#${requestComp} 2>/dev/null | head -n -1 | fzf  --multi=0 #g')
}
```
Put this in your `.bashrc` or `.zshrc` instead of:
```bash
source <(kubectl completion bash)
```
It will source kubectl completion with fzf support 
Examples:
```bash
# Will open fzf windows with k8s objects starting with `p`
kubectl get p<tab><tab>

# Will open fzf list of pods.
kubectl get pods <tab><tab>
```

Notes:

This will make all kubectl commands use fzf for completion.<br>
This was tested with (should work with all commands):

- [x] version `v1.23.6`
- [x] bash
- [x] zsh
- commands: 
   - [x] get
   - [x] get pods
   - [x] describe 
   - [x] describe pods
   - [x] logs

Suggested by: [@shmuel-raichman](https://github.com/shmuel-raichman/dotfiles)

### [pass](https://www.passwordstore.org/) and [pass-tomb](https://github.com/roddhjav/pass-tomb)
The below [passfzf](https://git.sr.ht/~mlaparie/passfzf) script is a wrapper for `pass` (the UNIX password store) and `pass-tomb`. Check the source repository for any updates.

![](https://git.sr.ht/~mlaparie/passfzf/blob/master/demo/passfzf_screenshot1.png)

```sh
#!/usr/bin/env bash
# This script unlocks the pass tomb, if any, and then usess fzf to find
# passwords and copy, show, delete, rename and duplicate them, as well as
# to add or generate new passwords, and synchronize them (with git).
# Dependencies: fd, fzf, pass
# Optional dependencies: git, pass-tomb
# 
# MIT License, Copyright © [2022] Mathieu Laparie <mlaparie [at] disr [dot] it>

store="$HOME/.password-store/"
swapfile="/swap/swapfile" # Set path to any swapfile not listed in /etc/fstab

# Open pass tomb, if any
if [[ -e "$HOME/.password.tomb" ]]; then
    sudo swapoff -a && sudo swapoff "${swapfile}" 2> /dev/null
    pass open 2> /dev/null
fi

# Select pass entry
main() {
    while :; do
        clear
        selection=$(fd .gpg ~/.password-store/ -d 8 \
                      | fzf --query "${tmp}" \
                            --prompt="# " \
                            --ansi \
                            --extended \
                            --no-border \
                            --with-nth 5.. \
                            --delimiter "/" \
                            --layout=reverse-list \
                            --no-multi \
                            --cycle \
                            --header='
Ret: copy, C-s: show, C-e: edit, C-r: rename, C-d: duplicate,
C-a: add, C-g: generate and copy new password, C-t: trash
C-p: git pull, M-p: git push, C-c/C-q/Esc: clear query or exit' \
                            --margin='1,2,1,2' \
                            --color='16,gutter:-1' \
                            --bind="tab:down" \
                            --bind="btab:up" \
                            --bind="ctrl-s:execute(echo 'show' > /tmp/passfzfarg)+accept" \
                            --bind="ctrl-e:execute(echo 'edit' > /tmp/passfzfarg)+accept" \
                            --bind="ctrl-r:execute(echo 'mv' > /tmp/passfzfarg)+accept" \
                            --bind="ctrl-d:execute(echo 'cp' > /tmp/passfzfarg)+accept" \
                            --bind="ctrl-a:execute(echo 'add' > /tmp/passfzfarg)+print-query" \
                            --bind="ctrl-g:execute(echo 'generate --clip' > /tmp/passfzfarg)+print-query" \
                            --bind="ctrl-t:execute(echo 'rm' > /tmp/passfzfarg)+accept" \
                            --bind="ctrl-p:abort+execute(echo 'git pull' > /tmp/passfzfarg)" \
                            --bind="alt-p:abort+execute(echo 'git push -u --all' > /tmp/passfzfarg)" \
                            --bind="ctrl-c:execute(echo 'quit' > /tmp/passfzfarg)+cancel" \
                            --bind="ctrl-q:execute(echo 'quit' > /tmp/passfzfarg)+cancel" \
                            --bind="esc:execute(echo 'quit' > /tmp/passfzfarg)+cancel")

        if [[ -f "/tmp/passfzfarg" ]]; then
            arg=$(cat /tmp/passfzfarg)
            rm /tmp/passfzfarg
        else
            arg="show --clip"
        fi

        if ! [[ -v "$selection" ]]; then
            clear
            case "$arg" in
                add)
                    printf "\033[0;32mNew password Directory/Name:\033[0m ${selection}"
                    if [[ -n "$selection" ]]; then
                        printf "\033[0;32m\nPress Return to confirm or type new Directory/Name:\033[0m "
                    fi
                    read -r
                    tmp="${REPLY:=$selection}"
                    pass ${arg} "${tmp}"
                    tmp="${selection:=$tmp}"
                    continue
                    ;;
                mv | cp)
                    tmp=${selection::-4} && tmp=${tmp#"$store"}
                    printf "\033[0;32m\nNew Directory/Name to ${arg} '${tmp}' to:\033[0m "
                    read -r
                    if [[ -n "$REPLY" ]]; then
                        pass ${arg} "${tmp}" "${REPLY}"
                    fi
                    tmp="${REPLY:=$tmp}"
                    continue
                    ;;
                "generate --clip")
                    printf "\033[0;32mNew password Directory/Name:\033[0m ${selection}"
                    if [[ -n "$selection" ]]; then
                        printf "\033[0;32m\nPress Return to confirm or type new Directory/Name:\033[0m "
                    fi
                    read -r
                    tmp="${REPLY:=$selection}"
                    printf "\033[0;32mNumber of characters:\033[0m "
                    read -r
                    pass ${arg} --in-place "${tmp}" "${REPLY}" \
                        2> /dev/null || pass ${arg} "${tmp}" "${REPLY}"
                    tmp="${selection:=$tmp}"
                    printf "\nPress any key to continue. "
                    read -rsn1
                    continue
                    ;;
                quit)
                    pkill -P $$
                    return
                    ;;
                *)
                    if [[ -n "$selection" ]]; then
                        tmp=${selection::-4} && tmp=${tmp#"$store"}
                        pass ${arg} "${tmp}"
                    else
                        pass ${arg}
                    fi
                    printf "\nPress any key to continue. "
                    read -rsn1
                    continue
                    ;;
            esac
        fi
    done
}

main

# Close pass tomb, if any
if [[ -e "$HOME/.password.tomb" ]]; then
    printf "\n"
    pass close
    sudo swapon -a && sudo swapon "${swapfile}" 2> /dev/null
fi

printf "\nPress any key to quit. " && read -rsn1
```

### ASDF

```sh
# Install one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to install
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [I]nstall
vmi() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list-all $lang | fzf --tac --no-sort --multi)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf install $lang $version; done;
    fi
  fi
}
```

```sh
# Remove one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to remove
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [C]lean
vmc() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list $lang | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf uninstall $lang $version; done;
    fi
  fi
}
```

### Images

[fzfimg](https://github.com/seebye/ueberzug/blob/master/examples/fzfimg.sh) allows to display images.  
It's a wrapper script, so it supports the same options as fzf does.  
Examples:  

* draw the selected image `fzfimg.sh`
* draw always the same image
```bash
fzfimg.sh --preview 'draw_preview /some/path/some-image.png'
```
* change the preview window
```bash
fzfimg.sh --preview-window top:80% --cycle
fzfimg.sh --preview-window bottom:80% --reverse
fzfimg.sh --preview-window left:50
fzfimg.sh --preview-window right:80%
```

### Homebrew

```sh
# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]ackage
bip() {
  local inst=$(brew search "$@" | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}
```


```sh
# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]ackage
bup() {
  local upd=$(brew leaves | fzf -m)

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}
```

```sh
# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]ackage (e.g. uninstall)
bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}
```

```sh
# filename: bi
#!/usr/bin/env zsh
# Fully manage brew installation and suppression, and then some.
# needs zsh, jq, bat
# Inspired by:
# - https://github.com/raycast/extensions/tree/main/extensions/brew
# - https://github.com/junegunn/fzf/wiki/examples#dnf

readonly wait_click="echo $'\n\e[34mPress any key to continue...' && read -rsk 1"
readonly jq_all='
	(. | map(.cask_tokens) | flatten | map(split("/")[-1] + " (cask)"))[]
	, (. | map(.formula_names) | flatten)[]
'

readonly jq_installed='(.formulae[] | .name), (.casks[] | .token + " (cask)")'

readonly tmp_file="$(mktemp)"
trap "rm -f $tmp_file" EXIT

readonly reload="reload%case \$(cat $tmp_file) in
	install) { echo Install mode; brew tap-info --json --installed | jq --raw-output '$jq_all' | sort } ;;
	*) { echo Remove mode; brew info --json=v2 --installed | jq --raw-output '$jq_installed' | sort } ;;
esac%"


readonly state="cat $tmp_file"

readonly nextstate="execute-silent%case \$(cat $tmp_file) in install) echo rm > $tmp_file ;; *) echo install > $tmp_file ;; esac%"

readonly bold="\e[1m"
readonly reset="\e[0m"
readonly italic="\e[3m"
readonly gray="\e[30m"
readonly c="\e[1;36m"
readonly d="\e[1;37m"

readonly help="\
\
${bold}${c}[${d}B${c}]${d}rew ${c}[${d}I${c}]${d}nteractive${reset}

${italic}Tab${reset}     Switch between install mode and remove mode
${italic}Enter${reset}   Select formula or cask for installation or deletion (depends on mode)

${italic}ctrl-s${reset}  Show formula or cask installation [s]ource code
${italic}ctrl-j${reset}  Show formula or cask [J]SON information
${italic}crtl-e${reset}  [E]dit formula or cask source code

${italic}?${reset}       Help (this page)
${italic}ESC${reset}     Quit


It is also advised you use auto-updates, this can be done with:

    brew autoupdate start --upgrade --cleanup --enable-notification

"

echo install > $tmp_file

{ echo "Install mode (? for help)"; brew tap-info --json --installed | jq --raw-output "$jq_all" | sort } |
	fzf --reverse --header-lines=1  --header-first --prompt="$ " \
		--bind="enter:execute(
			if [[ '{2}' == '(cask)' ]]; then
				brew \$($state) --cask {1}
			else
				brew \$($state) {1}
			fi
			$wait_click)+$reload" \
		--bind='ctrl-s:preview(
			bat --color=always $(brew edit --print-path {1}) --style=header
		)' \
		--bind="ctrl-j:preview:brew info --json=v2 {1} | jq '
			(.formulae + .casks)[0] | with_entries(select(try (.value | length > 0)))
		' | bat --plain --language=json --color=always" \
		--bind="ctrl-e:execute:
			EDITOR='code --wait' brew edit {1}
			bat --color=always --language=markdown --plain <<-MD
				To install the formulae (or cask) you edited with your changes, use:

				    brew reinstall --build-from-source {1}
			MD
			$wait_click" \
		--bind="tab:$nextstate+$reload" \
		--bind="?:preview:printf '$help'" \
		--preview='brew info {1} | bat --color=always --language=Markdown --style=plain' \
		--preview-window='bottom,wrap,<13(right)'

```



### Homebrew Cask

```sh
# Install or open the webpage for the selected application 
# using brew cask search as input source
# and display a info quickview window for the currently marked application 
install() {
    local token
    token=$(brew search --casks "$1" | fzf-tmux --query="$1" +m --preview 'brew info {}')
                    
    if [ "x$token" != "x" ]                                                                
    then             
        echo "(I)nstall or open the (h)omepage of $token"
        read input                             
        if [ $input = "i" ] || [ $input = "I" ]; then    
            brew install --cask $token                   
        fi                                                                                    
        if [ $input = "h" ] || [ $input = "H" ]; then                                         
            brew home $token                     
        fi                                           
    fi                             
}                                              
```


```sh
# Uninstall or open the webpage for the selected application 
# using brew list as input source (all brew cask installed applications) 
# and display a info quickview window for the currently marked application
uninstall() {                                                                     
    local token                                                                   
    token=$(brew list --casks | fzf-tmux --query="$1" +m --preview 'brew info {}')
                                                                                  
    if [ "x$token" != "x" ]                                                       
    then                                                                          
        echo "(U)ninstall or open the (h)omepae of $token"                        
        read input                                                                
        if [ $input = "u" ] || [ $input = "U" ]; then                             
            brew uninstall --cask $token                                          
        fi                                                                        
        if [ $input = "h" ] || [ $token = "h" ]; then                             
            brew home $token                                                      
        fi                                                                        
    fi                                                                            
}                                                                                 
```
### DNF

Interactively Install, Remove, Upgrade and Fuzzy search DNF packages using fzf

```sh

#!/usr/bin/bash
readonly basename="$(basename "$0")"

if ! hash fzf &> /dev/null; then
    printf 'Error: Missing dep: fzf is required to use %s.\n' "${basename}" >&2
    exit 64
fi

#Colors
declare -r esc=$'\033'
declare -r BLUE="${esc}[1m${esc}[34m"
declare -r RED="${esc}[31m"
declare -r GREEN="${esc}[32m"
declare -r YELLOW="${esc}[33m"
declare -r CYAN="${esc}[36m"
# Base commands
readonly QRY="dnf --cacheonly --quiet repoquery "
readonly PRVW="dnf --cacheonly --quiet --color=always info"
readonly QRY_PRFX='  '
readonly QRY_SFFX=' > '
# Install mode
readonly INS_QRYS="${QRY} --qf '${CYAN}%{name}'"
readonly INS_PRVW="${PRVW}"
readonly INS_PRMPT="${CYAN}${QRY_PRFX}Install packages${QRY_SFFX}"
# Remove mode
readonly RMV_QRYS="${QRY} --installed --qf '${RED}%{name}'"
readonly RMV_PRVW="${PRVW} --installed"
readonly RMV_PRMPT="${RED}${QRY_PRFX}Remove packages${QRY_SFFX}"
# Remove-userinstalled mode
readonly RUI_QRYS="${QRY} --userinstalled --qf '${YELLOW}%{name}'"
readonly RUI_PRVW="${PRVW} --installed"
readonly RUI_PRMPT="${YELLOW}${QRY_PRFX}Remove User-Installed${QRY_SFFX}"
# Updates mode
readonly UPD_QRY="${QRY} --upgrades --qf '${GREEN}%{name}'"
readonly UPD_QRYS="if [[ $(${UPD_QRY} | wc -c) -ne 0 ]]; then ${UPD_QRY}; else echo ${GREEN}No updates available.; echo Try refreshing metadata cache...; fi"
readonly UPD_PRVW="${PRVW}"
readonly UPD_PRMPT="${GREEN}${QRY_PRFX}Upgrade packages${QRY_SFFX}"

mapfile -d '' fhelp <<-EOF

        "${basename}"
        Interactive package manager for Fedora

        Alt-i       Install mode (default)
        Alt-r       Remove mode
        Alt-e       Remove User-Installed mode
        Alt-u       Updates mode
        Alt-m       Update package metadata cache

        Enter       Confirm selection
        Tab         Mark package ()
        Shift-Tab   Unmark package
        Ctrl-a      Select all

        ?           Help (this page)
        ESC         Quit
EOF

declare tmp_file
if tmp_file="$(mktemp --tmpdir "${basename}".XXXXXX)"; then
    printf 'in' > "${tmp_file}" &&
    SHELL='/bin/bash' \
    FZF_DEFAULT_COMMAND="${INS_QRYS}" \
	fzf \
    --ansi \
	--multi \
	--query=$* \
	--header=" ${basename} | Press Alt+? for help or ESC to quit" \
	--header-first \
	--prompt="${INS_PRMPT}" \
	--marker=' ' \
	--preview-window='right,67%,wrap' \
	--preview="${INS_PRVW} {1}" \
	--bind="enter:execute(if grep -q 'in' \"${tmp_file}\"; then sudo dnf install {+}; 
        elif grep -q 'rm' \"${tmp_file}\"; then sudo dnf remove {+}; \
        elif grep -q 'up' \"${tmp_file}\"; then sudo dnf upgrade {+}; fi; \
        read -s -r -n1 -p $'\n${BLUE}Press any key to continue...' && printf '\n')" \
	--bind="alt-i:unbind(alt-i)+reload(${INS_QRYS})+change-preview(${INS_PRVW} {1})+change-prompt(${INS_PRMPT})+execute-silent(printf 'in' > \"${tmp_file}\")+first+rebind(alt-r,alt-e,alt-u)" \
	--bind="alt-r:unbind(alt-r)+reload(${RMV_QRYS})+change-preview(${RMV_PRVW} {1})+change-prompt(${RMV_PRMPT})+execute-silent(printf 'rm' > \"${tmp_file}\")+first+rebind(alt-i,alt-e,alt-u)" \
	--bind="alt-e:unbind(alt-e)+reload(${RUI_QRYS})+change-preview(${RUI_PRVW} {1})+change-prompt(${RUI_PRMPT})+execute-silent(printf 'rm' > \"${tmp_file}\")+first+rebind(alt-i,alt-r,alt-u)" \
	--bind="alt-u:unbind(alt-u)+reload(${UPD_QRYS})+change-preview(${UPD_PRVW} {1})+change-prompt(${UPD_PRMPT})+execute-silent(printf 'up' > \"${tmp_file}\")+first+rebind(alt-i,alt-r,alt-e)" \
	--bind="alt-m:execute(sudo dnf makecache;read -s -r -n1 -p $'\n${BLUE}Press any key to continue...' && printf '\n')" \
	--bind="alt-?:preview(printf \"${fhelp[0]}\")" \
	--bind="ctrl-a:select-all"
    
    rm -f "${tmp_file}" &> /dev/null
else
    printf 'Error: Failed to create tmp file. $TMPDIR (or /tmp if $TMPDIR is unset) may not be writable.\n' >&2
    exit 65
fi
```

### Flatpak
#### flatpak-widget (for zsh)
![](https://user-images.githubusercontent.com/114978689/201288486-af070edc-b1c4-4535-bb48-1d51453f501d.png)
```sh
# CLR=$(for i in {0..7}; do echo "tput setaf $i"; done)
BLK=\$(tput setaf 0); RED=\$(tput setaf 1); GRN=\$(tput setaf 2); YLW=\$(tput setaf 3); BLU=\$(tput setaf 4); 
MGN=\$(tput setaf 5); CYN=\$(tput setaf 6); WHT=\$(tput setaf 7); BLD=\$(tput bold); RST=\$(tput sgr0);    

AWK_VAR="awk -v BLK=${BLK} -v RED=${RED} -v GRN=${GRN} -v YLW=${YLW} -v BLU=${BLU} -v MGN=${MGN} -v CYN=${CYN} -v WHT=${WHT} -v BLD=${BLD} -v RST=${RST}"

# Searches only from flathub repository
fzf-flatpak-install-widget() {
  flatpak remote-ls flathub --cached --columns=app,name,description \
  | awk -v cyn=$(tput setaf 6) -v blu=$(tput setaf 4) -v bld=$(tput bold) -v res=$(tput sgr0) \
  '{
    app_info=""; 
    for(i=2;i<=NF;i++){
      app_info=cyn app_info" "$i 
    };
    print blu bld $2" -" res app_info "|" $1
    }' \
  | column -t -s "|" -R 3 \
  | fzf \
    --ansi \
    --with-nth=1.. \
    --prompt="Install > " \
    --preview-window "nohidden,40%,<50(down,50%,border-rounded)" \
    --preview "flatpak --system remote-info flathub {-1} | $AWK_VAR -F\":\" '{print YLW BLD \$1 RST WHT \$2}'" \
    --bind "enter:execute(flatpak install flathub {-1})" # when pressed enter it doesn't showing the key pressed but it is reading the input
  zle reset-prompt
}
bindkey '^[f^[i' fzf-flatpak-install-widget #alt-f + alt-i
zle -N fzf-flatpak-install-widget

fzf-flatpak-uninstall-widget() {
  touch /tmp/uns
  flatpak list --columns=application,name \
  | awk -v cyn=$(tput setaf 6) -v blu=$(tput setaf 4) -v bld=$(tput bold) -v res=$(tput sgr0)  \
  '{
    app_id="";
    for(i=2;i<=NF;i++){
      app_id" "$i
    };
    print bld cyn $2 " - " res blu $1
   }' \
  | column -t \
  | fzf \
    --ansi \
    --with-nth=1.. \
    --prompt="  Uninstall > " \
    --header="M-u: Uninstall | M-r: Run" \
    --header-first \
    --preview-window "nohidden,50%,<50(up,50%,border-rounded)" \
    --preview  "flatpak info {3} | $AWK_VAR -F\":\" '{print RED BLD  \$1 RST \$2}'" \
    --bind "alt-r:change-prompt(Run > )+execute-silent(touch /tmp/run && rm -r /tmp/uns)" \
    --bind "alt-u:change-prompt(Uninstall > )+execute-silent(touch /tmp/uns && rm -r /tmp/run)" \
    --bind "enter:execute(
    if [ -f /tmp/uns ]; then 
      flatpak uninstall {3}; 
    elif [ -f /tmp/run ]; then
      flatpak run {3}; 
    fi
    )" # same as the install one but when pressed  entered the message is something like this 
# "Proceed with these changes to the system installation? [Y/n]:" but it will uninstall the selected app weird but idk y
  rm -f /tmp/{uns,run} &> /dev/null
  zle reset-prompt
}
bindkey '^[f^[u' fzf-flatpak-uninstall-widget #alt-f + alt-u
zle -N fzf-flatpak-uninstall-widget
```

### v

#### Inspired by [v](https://github.com/rupa/v). Opens files in ~/.viminfo

```sh
# v - open files in ~/.viminfo
v() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
          while read line; do
            [ -f "${line/\~/$HOME}" ] && echo "$line"
          done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}
```

#### With [fasd](https://github.com/clvv/fasd).

Suggested by [@epiloque](https://github.com/epiloque)

```sh
v() {
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
}
```

Suggested by [@mazinbokhari](https://github.com/mazinbokhari/dotfiles)
```
# fasd & fzf change directory - open best matched file using `fasd` if given argument, filter output of `fasd` using `fzf` else
v() {
    [ $# -gt 0 ] && fasd -f -e ${EDITOR} "$*" && return
    local file
    file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vi "${file}" || return 1
}
```

### cd

#### Integration with [zsh-interactive-cd](https://github.com/changyuheng/zsh-interactive-cd).

Fish like interactive tab completion for cd in zsh.

![zsh-interactive-cd-demo](https://raw.githubusercontent.com/changyuheng/zsh-interactive-cd/master/demo.gif)

#### Interactive cd
Suggested by [@mgild](https://github.com/mgild)
Like normal cd but opens an interactive navigation window when called with no arguments.  For ls, use -FG instead of --color=always on osx.
```sh
function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}
```

### autojump

#### Integration with [autojump](https://github.com/wting/autojump)

like normal autojump when used with arguments but displays an fzf prompt when used without
```sh
j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)" 
}
```

### z

#### Integration with [z](https://github.com/rupa/z).

like normal z when used with arguments but displays an fzf prompt when used without.

```sh
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
```

Here is another version that also supports relaunching z with the arguments
for the previous command as the default input by using zz

```sh
unalias z
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

zz() {
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}
```

Since z is not very optimal located on a qwerty keyboard I have these aliased as j and jj

```sh
alias j=z
alias jj=zz
```

#### With [fz](https://github.com/changyuheng/fz).

It's yet another z integration. In this version, fuzzy search is enabled with tab completion.

![fz-demo](https://raw.githubusercontent.com/changyuheng/fz/master/fz-demo.gif)

#### With [fasd](https://github.com/clvv/fasd).

Suggested by [@l4u](https://github.com/l4u) and [@epiloque](https://github.com/epiloque)

```sh
z() {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
```

Suggested by [@mazinbokhari](https://github.com/mazinbokhari/dotfiles)
```
# fasd & fzf change directory - jump using `fasd` if given argument, filter output of `fasd` using `fzf` else
z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}
```


### Shell bookmarks

Yet another useful application for `fzf`: shell bookmarks. It looks as follows:
![cdg_demo](http://dmitryfrank.com/_media/articles/cdg_recorded.gif)

See complete article for details: [Fuzzy bookmarks for your shell](http://dmitryfrank.com/articles/shell_shortcuts)

### Google Chrome

#### Browsing history

OSX/Linux Version:
```sh
# c - browse chrome history
c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}
```

Windows Version:
```ps1
Function c() {
  $Columns = [int]((get-host).ui.rawui.WindowSize.Width / 3)
  $Separator ='{::}'
  $History = "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\Default\History"
  $TempFile = New-TemporaryFile
  $Query = "select substr(title, 1, $Columns), url from urls order by last_visit_time desc"
  Copy-Item $History -Destination $TempFile
  @(sqlite3 -separator "$Separator" "$TempFile" "$Query") |
  ForEach-Object {
    $Title, $Url = ($_ -split $Separator)[0, 1]
    "$($Title.PadRight($Columns))  `e[36m$Url`e[0m"
  } | fzf --ansi --multi | ForEach-Object{start-process "chrome.exe" ($_ -replace '.*(https*://)', '$1'),'--profile-directory="Default"'}
}
```

#### Bookmarks

Chrome Bookmarks browser with [jq](https://stedolan.github.io/jq/) for OS X
```
# b - browse chrome bookmarks
b() {
     bookmarks_path=~/Library/Application\ Support/Google/Chrome/Default/Bookmarks

     jq_script='
        def ancestors: while(. | length >= 2; del(.[-1,-2]));
        . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

    jq -r "$jq_script" < "$bookmarks_path" \
        | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
        | fzf --ansi \
        | cut -d$'\t' -f2 \
        | xargs open
}
```

Chrome Bookmarks browser with [jq](https://stedolan.github.io/jq/) for Windows
```
# b - browse chrome bookmarks
Function b() {
  $Bookmarks = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Bookmarks"

  $JqScript=@"
     def ancestors: while(. | length >= 2; del(.[-1,-2]));
     . as `$in | paths(.url?) as `$key | `$in | getpath(`$key) | {name,url, path: [`$key[0:-2] | ancestors as `$a | `$in | getpath(`$a) | .name?] | reverse | join(\`"/\`") } | .path + \`"/\`" + .name + \`"|\`" + .url
"@
  
     Get-Content "$Bookmarks" | jq -r "$JqScript" `
     | ForEach-Object { 
       $_ -replace "(.*)\|(.*)", "`$1`t`e[36m`$2`e[0m"
      } `
     | fzf --ansi `
     | ForEach-Object {
       start-process "chrome.exe" ($_ -split "`t")[1],'--profile-directory="Default"'
      }
}
```

Chrome Bookmarks browser with ruby

https://gist.github.com/junegunn/15859538658e449b886f (for OS X)

### Browsing

```sh
# Simple replacement for urlview in X
# https://github.com/d630/bin/blob/master/furlview
% furlview ( - | FILE ... )
```

### NPM
[npm-fzf](https://github.com/hankchanocd/npm-fzf) - Fuzzy search npm modules with `fzf`.

```
# run npm script (requires jq)
fns() {
  local script
  script=$(cat package.json | jq -r '.scripts | keys[] ' | sort | fzf) && npm run $(echo "$script")
}
```

### Locate

`Alt-i` to paste item from `locate /` output (zsh only):

```sh
# ALT-I - Paste the selected entry from locate output into the command line
fzf-locate-widget() {
  local selected
  if selected=$(locate / | fzf -q "$LBUFFER"); then
    LBUFFER=$selected
  fi
  zle redisplay
}
zle     -N    fzf-locate-widget
bindkey '\ei' fzf-locate-widget
```

### mpd

You must have [`mpc`](http://www.musicpd.org/clients/mpc/) installed on your computer in order to use this function.

```sh
fmpc() {
  local song_position
  song_position=$(mpc -f "%position%) %artist% - %title%" playlist | \
    fzf-tmux --query="$1" --reverse --select-1 --exit-0 | \
    sed -n 's/^\([0-9]\+\)).*/\1/p') || return 1
  [ -n "$song_position" ] && mpc -q play $song_position
}
```

#### clerk

[clerk](https://github.com/carnager/clerk) is a simple MPD client using rofi or fzf.

![](https://camo.githubusercontent.com/58bc51b41274d612f8e6fd4bc9609a5864102e3a/68747470733a2f2f7069632e35333238302e64652f636c65726b2e706e67)

### Readline

```sh
# CTRL-X-1 - Invoke Readline functions by name
__fzf_readline ()
{
    builtin eval "
        builtin bind ' \
            \"\C-x3\": $(
                builtin bind -l | command fzf +s +m --toggle-sort=ctrl-r
            ) \
        '
    "
}

builtin bind -x '"\C-x2": __fzf_readline';
builtin bind '"\C-x1": "\C-x2\C-x3"'
```

### RVM

```sh
# RVM integration
frb() {
  local rb
  rb=$((echo system; rvm list | grep ruby | cut -c 4-) |
       awk '{print $1}' |
       fzf-tmux -l 30 +m --reverse) && rvm use $rb
}
```

### Vagrant

You must have [`jq`](https://github.com/stedolan/jq) installed on your computer in order to use this function.

```sh
vs(){
  #List all vagrant boxes available in the system including its status, and try to access the selected one via ssh
  cd $(cat ~/.vagrant.d/data/machine-index/index | jq '.machines[] | {name, vagrantfile_path, state}' | jq '.name + "," + .state  + "," + .vagrantfile_path'| sed 's/^"\(.*\)"$/\1/'| column -s, -t | sort -rk 2 | fzf | awk '{print $3}'); vagrant ssh
}
```

### Wrapper
When you have defined an alias or wrapper for some command, you might want to inherit the completion from a parent function. Find out the completion used for your command and do:

```sh
_fzf_complete_myssh() {
  _fzf_complete_ssh "$@"
}
```

See also `_fzf_setup_completion` in the completion source code.

### LastPass CLI
Search through your LastPass vault with [LastPass CLI](https://github.com/lastpass/lastpass-cli) and copy password to clipboard.

```sh
$ lpass show -c --password $(lpass ls  | fzf | awk '{print $(NF)}' | sed 's/\]//g')
```

### [fzf-marker](https://github.com/liangguohuan/fzf-marker)
The terminal command Tweak https://github.com/pindexis/marker.git

[![asciicast](https://asciinema.org/a/122370.png)](https://asciinema.org/a/122370?autoplay=1)

```sh
# marker templete select
_fzf_marker_main_widget() {
  if echo "$BUFFER" | grep -q -P "{{"; then
    _fzf_marker_placeholder
  else
    local selected
    if selected=$(cat ${FZF_MARKER_CONF_DIR:-~/.config/marker}/*.txt |
      sed -e "s/\(^[a-zA-Z0-9_-]\+\)\s/${FZF_MARKER_COMMAND_COLOR:-\x1b[38;5;255m}\1\x1b[0m /" \
          -e "s/\s*\(#\+\)\(.*\)/${FZF_MARKER_COMMENT_COLOR:-\x1b[38;5;8m}  \1\2\x1b[0m/" |
      fzf --bind 'tab:down,btab:up' --height=80% --ansi -q "$LBUFFER"); then
      LBUFFER=$(echo $selected | sed 's/\s*#.*//')
    fi
    zle redisplay
  fi
}

_fzf_marker_placeholder() {
  local strp pos placeholder
  strp=$(echo $BUFFER | grep -Z -P -b -o "\{\{[\w]+\}\}")
  strp=$(echo "$strp" | head -1)
  pos=$(echo $strp | cut -d ":" -f1)
  placeholder=$(echo $strp | cut -d ":" -f2)
  if [[ -n "$1" ]]; then
    BUFFER=$(echo $BUFFER | sed -e "s/{{//" -e "s/}}//")
    CURSOR=$(($pos + ${#placeholder} - 4))
  else
    BUFFER=$(echo $BUFFER | sed "s/$placeholder//")
    CURSOR=pos
  fi
}

_fzf_marker_placeholder_widget() { _fzf_marker_placeholder "defval" }

zle -N _fzf_marker_main_widget
zle -N _fzf_marker_placeholder_widget
bindkey "${FZF_MARKER_MAIN_KEY:-\C-@}" _fzf_marker_main_widget
bindkey "${FZF_MARKER_PLACEHOLDER_KEY:-\C-v}" _fzf_marker_placeholder_widget
```


### Search for academic PDFs by author, title, journal, institution

Search for all pdf files. FZF will match the query against any text found on the first page of the PDF. For instance, one can query for author names, article title, journal, institutions, keywords. It works by extracting the text on the first page of the PDF using ``pdftotext``.   
The selected file is then opened by the default pdf viewer. 

Requires the [pdftotext](https://en.wikipedia.org/wiki/Pdftotext) command line tool. Tested on Ubuntu 17.10 on bash and zsh.

![](https://user-images.githubusercontent.com/1019692/34446795-12229072-ecac-11e7-856a-ec0df0de60ae.gif)

The script is now given at https://github.com/bellecp/fast-p

### BibTeX

Search records in BibTeX files using FZF, select records to cite, or pretty print in markdown. With vim integration.

![](https://d.pr/i/8uXzLx+ "screenshot")

This plugin is at https://github.com/msprev/fzf-bibtex

### Docker

```sh
# Select a docker container to start and attach to
function da() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}
```

```sh
# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}
```

```sh
# Select a docker container to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}
```

```sh
# Same as above, but allows multi selection:
function drm() {
  docker ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r docker rm
}
```


```sh
# Select a docker image or images to remove
function drmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}
```

### buku
Search and open website bookmarks stored in a [buku](https://github.com/jarun/Buku) database.

```sh
# BUKU bookmark manager
# get bookmark ids
get_buku_ids() {
    buku -p -f 5 | fzf --tac --layout=reverse-list -m | \
      cut -d $'\t' -f 1
    # awk -F= '{print $1}'
    # cut -d $'\t' -f 1
}

# buku open
fb() {
    # save newline separated string into an array
    ids=( $(get_buku_ids) )

    echo buku --open ${ids[@]}

    [[ -z $ids ]] && return 1 # return error if has no bookmark selected

    buku --open ${ids[@]}
}

# buku update
fbu() {
    # save newline separated string into an array
    ids=( $(get_buku_ids) )

    echo buku --update ${ids[@]} $@

    [[ -z $ids ]] && return 0 # return if has no bookmark selected

    buku --update ${ids[@]} $@
}

# buku write
fbw() {
    # save newline separated string into an array
    ids=( $(get_buku_ids) )
    # print -l $ids

    # update websites
    for i in ${ids[@]}; do
        echo buku --write $i
        buku --write $i
    done
}

```

...And a nicer looking alternative, using [fzfmenu](#fzf-as-dmenu-replacement).

```sh
#!/usr/bin/env bash
# fb - buku bookmarks fzfmenu opener
buku -p -f 4 |
    awk -F $'\t' '{
        if ($4 == "")
            printf "%s \t\x1b[38;5;208m%s\033[0m\n", $2, $3
        else
            printf "%s \t\x1b[38;5;124m%s \t\x1b[38;5;208m%s\033[0m\n", $2, $4, $3
    }' |
    fzfmenu --tabstop 1 --ansi -d $'\t' --with-nth=2,3 \
        --preview-window='bottom:10%' --preview 'printf "\x1b[38;5;117m%s\033[0m\n" {1}' |
        awk '{print $1}' | xargs -d '\n' -I{} -n1 -r xdg-open '{}'
```

If you have `sqlite` installed - you can use it to query DB directly (which takes about ~2ms compared to buku's ~100ms).

To do that, replace the `buku -p -f 4` with

```sh
sqlite3 -separator $'\t' "$HOME/.local/share/buku/bookmarks.db" "SELECT id,URL,metadata,tags FROM bookmarks" | awk -F $'\t' '{gsub(/(^,|,$)/,"",$4); printf "%s\t%s\t%s\t%s\n", $1, $2, $3, $4}'
```

Now you can bind it on some key, e.g. with [sxhkd](https://github.com/baskerville/sxhkd) in sxhkdrc:

```
super + shift + u
	fb
```

![demo](https://i.imgur.com/Vc3GKhW.png)


### i3
Fuzzy search desktop entries and launch the appropriate application.
```
i3-dmenu-desktop --dmenu=fzf
```
Display in a floating window. Add this to your i3 config file (this example uses termite, but any terminal emulator that allows setting the window title can be used):
```
bindsym $mod+d exec --no-startup-id termite -t 'fzf-menu' -e 'i3-dmenu-desktop --dmenu=fzf'
for_window [title="fzf-menu"] floating enable
```

### Man pages
Quickly display a man page using fzf and fd.
`MANPATH` has to be set to a single directory (usually `/usr/share/man`).
Accepts an optional argument for the manual section (defaults to 1).

```sh
man-find() {
    f=$(fd . $MANPATH/man${1:-1} -t f -x echo {/.} | fzf) && man $f
}
```

```sh
fman() {
    man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
}
```

```sh
# Same as above, but with previews and works correctly with man pages in different sections.
function fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}
```

Same as above, but the preview is colored with [bat](https://github.com/sharkdp/bat)
```sh
fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man | col -bx | bat -l man -p --color always' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}
# Get the colors in the opened man page itself
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"
```
#### fzf-man-pages widget (for zsh)
Same functionality as above 
- with colored and syntax higlighting 
- doesn't exit or close fzf when pressed enter

![](https://user-images.githubusercontent.com/114978689/201280168-550fe07f-a26a-4f8f-8ec9-3c1be05b3316.png)

```sh

fzf-man-widget() {
  batman="man {1} | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
   man -k . | sort \
   | awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue;} 1' \
   | fzf  \
      -q "$1" \
      --ansi \
      --tiebreak=begin \
      --prompt=' Man > '  \
      --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
      --preview "${batman}" \
      --bind "enter:execute(man {1})" \
      --bind "alt-c:+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
      --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
      --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
  zle reset-prompt
}
# `Ctrl-H` keybinding to launch the widget (this widget works only on zsh, don't know how to do it on bash and fish (additionaly pressing`ctrl-backspace` will trigger the widget to be executed too because both share the same keycode)
bindkey '^h' fzf-man-widget
zle -N fzf-man-widget
# Icon used is nerdfont
```

### Python Behave BDD

<kbd>Tab</kbd> copy the step name.

<kbd>Enter</kbd> copy the step location
```sh
fbehave() {
    behave "$@" -d -f steps 2> /dev/null | \
    awk -F " *# " '/\s*(Given|When|Then|\*)/ {print $1"\t"$2}' | \
    fzf -d "\t" --with-nth=1 \
        --bind 'enter:execute(echo {} | cut -f2 | pbcopy )' \
        --bind 'tab:execute(echo {} | cut -f1 | awk "{\$1=\$1};1" | pbcopy )'
}
```
### fzf as selector menu
Make a script like this (`~/.local/bin/fzfmenu`):
```bash
#!/usr/bin/env bash

export FZF_DEFAULT_OPTS="--height=100% --layout=reverse --border --no-sort --prompt=\"~ \" --color=dark,hl:red:regular,fg+:white:regular,hl+:red:regular:reverse,query:white:regular,info:gray:regular,prompt:red:bold,pointer:red:bold"

exec alacritty --class="fzf-menu" -e bash -c "fzf-tmux -m $* < /proc/$$/fd/0 | awk 'BEGIN {ORS=\" \"} {print}' > /proc/$$/fd/1"
# For st instead
# st -c fzf-menu -n fzf-menu -e bash -c "fzf-tmux -m $* < /proc/$$/fd/0 | awk 'BEGIN {ORS=\" \"} {print}' > /proc/$$/fd/1"
```
1. Then to run as app launcher, use [sxhkd](https://github.com/baskerville/sxhkd) and put in `~/.config/sxhkdrc`
    ```
    # run apps launcher
    control + alt + s ; r
      dmenu_path | ~/.local/bin/fzfmenu | bash
    ```
    ( You can use anything other than `dmenu_path` that gets a list of entries in `$PATH` too.)
2. To use for `Ctrl-t` for a floating menu from terminal  
**For bash**
```bash
__fzfmenu__() {
  local cmd="fd -tf --max-depth=1"
  eval "$cmd" | ~/.local/bin/fzfmenu
}

__fzf-menu__() {
  local selected="$(__fzfmenu__)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}
bind -x '"\C-t":"__fzf-menu__"'
```
**For zsh**
```zsh
__fzfmenu__(){
  local cmd="fd -tf --max-depth=1"
  eval $cmd | ~/.local/bin/fzfmenu
}
__fzf-menu__() {
  LBUFFER="${LBUFFER}$(__fzfmenu__)"
  local ret=$?
  zle reset-prompt
  return $ret
}

zle     -N    __fzf-menu__
bindkey -M emacs '^T^G' __fzf-menu__
bindkey -M vicmd '^T^G' __fzf-menu__
bindkey -M viins '^T^G' __fzf-menu__
```


## fzf as rofi replacement
https://github.com/gotbletu/shownotes/blob/master/fzf_nova/fzf-nova

download fzf-nova folder as a whole and follow the instructions in fzf-nova script

[Reference video](https://www.youtube.com/watch?v=8SqakfCSzQk)

credits @gotbletu 

### fzf as dmenu replacement

Why? ...Because it's faster.

So you'll need:

1. terminal that launches fast and supports custom class or window name. [St](https://st.suckless.org/) fits the bill perfectly.

2. window manager with an option to automatically put windows in center based on class or name. Most seem to have it.


```sh
#!/usr/bin/env bash
# fzfmenu - fzf as dmenu replacement

# fifos are here to not wait for end of input
# (useful for e.g. find $HOME | fzfmenu ...)
input=$(mktemp -u --suffix .fzfmenu.input)
output=$(mktemp -u --suffix .fzfmenu.output)
mkfifo $input
mkfifo $output
chmod 600 $input $output

# it's better to use st here (starts a lot faster than pretty much everything else)
# the ugly printf | sed thing is here to make args with quotes work.
# (e.g. --preview='echo {1}').
# sadly we can't use "$@" here directly because we are inside sh -c "..." call
# already.
# you can also set window dimensions via -g '=COLSxROWS', see man st.
st -c fzfmenu -n fzfmenu -e sh -c "cat $input | fzf $(printf -- " '%s'" "$@" | sed "s/^ ''$//") | tee $output" & disown

# handle ctrl+c outside child terminal window
trap "kill $! 2>/dev/null; rm -f $input $output" EXIT

cat > $input
cat $output
```

All arguments are passed to fzf.

Don't forget to add a float/center rule for `fzfmenu` class/name to your wm's config.

[Example usage](#buku).

### dotfiles management

[dotbare](https://github.com/kazhala/dotbare) is a command-line utility to manage your dotfiles.
It heavily utilises fzf for interactive user experience.
It is inspired by [forgit](https://github.com/wfxr/forgit), but focuses on dotfiles rather than generic git.
By default, it wraps around git bare repository but it could also be easily integrated with a symlink/GNU stow setup.

![dotbare screenshot](https://user-images.githubusercontent.com/43941510/82644470-b4a32c80-9c54-11ea-9601-d237eb98912e.gif)

### Transmission

zsh keybinding to select a torrent with transmission-remote.

```zsh
pick_torrent() LBUFFER="transmission-remote -t ${$({
    for torrent in ${(f)"$(transmission-remote -l)"}; do
        torrent_name=$torrent[73,-1]
        [[ $torrent_name != (Name|) ]] && echo ${${${(s. .)torrent}[1]}%\*} $torrent_name
    done
} | fzf)%% *} -"
zle -N pick_torrent
bindkey '^o' pick_torrent
```

### Pacman

```sh
# Install packages using yay (change to pacman/AUR helper of your choice)
function in() {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S
}
# Remove installed packages (change to pacman/AUR helper of your choice)
function re() {
    yay -Qq | fzf -q "$1" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
}
```

Shows version & repository, elaborate preview, bindings to show package in web, caches AUR packages list:
```sh
# Helper function to integrate yay and fzf
yzf() {
  pos=$1
  shift
  sed "s/ /\t/g" |
    fzf --nth=$pos --multi --history="${FZF_HISTDIR:-$XDG_STATE_HOME/fzf}/history-yzf$pos" \
      --preview-window=60%,border-left \
      --bind="double-click:execute(xdg-open 'https://archlinux.org/packages/{$pos}'),alt-enter:execute(xdg-open 'https://aur.archlinux.org/packages?K={$pos}&SB=p&SO=d&PP=100')" \
       "$@" | cut -f$pos | xargs
}

# Dev note: print -s adds a shell history entry

# List installable packages into fzf and install selection
yas() {
  cache_dir="/tmp/yas-$USER"
  test "$1" = "-y" && rm -rf "$cache_dir" && shift
  mkdir -p "$cache_dir"
  preview_cache="$cache_dir/preview_{2}"
  list_cache="$cache_dir/list"
  { test "$(cat "$list_cache$@" | wc -l)" -lt 50000 && rm "$list_cache$@"; } 2>/dev/null
  pkg=$( (cat "$list_cache$@" 2>/dev/null || { pacman --color=always -Sl "$@"; yay --color=always -Sl aur "$@" } | sed 's/ [^ ]*unknown-version[^ ]*//' | tee "$list_cache$@") |
    yzf 2 --tiebreak=index --preview="cat $preview_cache 2>/dev/null | grep -v 'Querying' | grep . || yay --color always -Si {2} | tee $preview_cache")
  if test -n "$pkg"
    then echo "Installing $pkg..."
      cmd="yay -S $pkg"
      print -s "$cmd"
      eval "$cmd"
      rehash
  fi
}
# List installed packages into fzf and remove selection
# Tip: use -e to list only explicitly installed packages
yar() {
  pkg=$(yay --color=always -Q "$@" | yzf 1 --tiebreak=length --preview="yay --color always -Qli {1}")
  if test -n "$pkg"
    then echo "Removing $pkg..."
      cmd="yay -R --cascade --recursive $pkg"
      print -s "$cmd"
      eval "$cmd"
  fi
}

```

### Clipboard
Uses [wl-copy](https://github.com/bugaevc/wl-clipboard) to copy the current entry to the clipboard on Wayland:

```sh
export FZF_DEFAULT_OPTS='--bind "ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)"'
```

This works with `execute-silent` but not with `execute`, presumably because `execute` waits for `wl-copy` to end. Appending a `&` did not change that.


### Todoist CLI
- Todoist CLI task filitring and preview 
    ```ps
    ❯ todoist --namespace --project-namespace list | fzf --preview 'todoist show {1}' | cut -d ' ' -f 1 | tr '\n' ' '
    ```
    - The command used for preview is `todoist show {1}` 
        - The `show` option is used to show the task details
        - The `{1}` represents the first feild in the line -> Task ID 

### Dictcc Translation

Request database file from https://www1.dict.cc/translation_file_request.php

```sh
cat /path/to/dict.txt | tail -n +16 | fzf --tiebreak=length
```

### Emoji

[emoji.txt](https://gist.github.com/keidarcy/128141ff30a8c3f9ddc0d6c3ecb5b334)

```sh
emojis=$(curl -sSL 'https://git.io/JXXO7')

selected_emoji=$(echo $emojis | fzf)

echo $selected_emoji
```



