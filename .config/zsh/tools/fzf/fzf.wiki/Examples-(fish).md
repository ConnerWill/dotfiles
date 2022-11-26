Examples for fish shell
-----------------------

### Navigation

```fish
function fzf-bcd-widget -d 'cd backwards'
	pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | eval (__fzfcmd) +m --select-1 --exit-0 $FZF_BCD_OPTS | read -l result
	[ "$result" ]; and cd $result
	commandline -f repaint
end
```

On macOS `tac` isn't available by default but you can use `tail -r` instead of `tac` for the same functionality.

```fish
function fzf-cdhist-widget -d 'cd to one of the previously visited locations'
	# Clear non-existent folders from cdhist.
	set -l buf
	for i in (seq 1 (count $dirprev))
		set -l dir $dirprev[$i]
		if test -d $dir
			set buf $buf $dir
		end
	end
	set dirprev $buf
	string join \n $dirprev | tac | sed 1d | eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
	[ "$result" ]; and cd $result
	commandline -f repaint
end
```

### Commandline

The following is useful to manipulate the commandline from the result of jobs. For instance, calling `fzf-select` over `pacman -Qlq fzf` will allow you to select files in the `fzf` package and print them bck to commandline for further manipulation.
```fish
function fzf-select -d 'fzf commandline job and print unescaped selection back to commandline'
	set -l cmd (commandline -j)
	[ "$cmd" ]; or return
	eval $cmd | eval (__fzfcmd) -m --tiebreak=index --select-1 --exit-0 | string join ' ' | read -l result
	[ "$result" ]; and commandline -j -- $result
	commandline -f repaint
end
```

### Completion

The following can replace fish completion menu with fzf. Because of a [fish bug](https://github.com/fish-shell/fish-shell/issues/3469) this will fail on variables and other elements that need escaping (or not).

```fish
function fzf-complete -d 'fzf completion and print selection back to commandline'
	# As of 2.6, fish's "complete" function does not understand
	# subcommands. Instead, we use the same hack as __fish_complete_subcommand and
	# extract the subcommand manually.
	set -l cmd (commandline -co) (commandline -ct)
	switch $cmd[1]
		case env sudo
			for i in (seq 2 (count $cmd))
				switch $cmd[$i]
					case '-*'
					case '*=*'
					case '*'
						set cmd $cmd[$i..-1]
						break
				end
			end
	end
	set cmd (string join -- ' ' $cmd)

	set -l complist (complete -C$cmd)
	set -l result
	string join -- \n $complist | sort | eval (__fzfcmd) -m --select-1 --exit-0 --header '(commandline)' | cut -f1 | while read -l r; set result $result $r; end

	set prefix (string sub -s 1 -l 1 -- (commandline -t))
	for i in (seq (count $result))
		set -l r $result[$i]
		switch $prefix
			case "'"
				commandline -t -- (string escape -- $r)
			case '"'
				if string match '*"*' -- $r >/dev/null
					commandline -t --  (string escape -- $r)
				else
					commandline -t -- '"'$r'"'
				end
			case '~'
				commandline -t -- (string sub -s 2 (string escape -n -- $r))
			case '*'
				commandline -t -- (string escape -n -- $r)
		end
		[ $i -lt (count $result) ]; and commandline -i ' '
	end

	commandline -f repaint
end
```

### Git

```fish
function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end

function fco -d "Use `fzf` to choose which branch to check out" --argument-names branch
  set -q branch[1]; or set branch ''
  git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 10% --layout=reverse --border --query=$branch --select-1 | xargs git checkout
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end

function snag -d "Pick desired files from a chosen branch"
  # use fzf to choose source branch to snag files FROM
  set branch (git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 20% --layout=reverse --border)
  # avoid doing work if branch isn't set
  if test -n "$branch"
    # use fzf to choose files that differ from current branch
    set files (git diff --name-only $branch | fzf --height 20% --layout=reverse --border --multi)
  end
  # avoid checking out branch if files aren't specified
  if test -n "$files"
    git checkout $branch $files
  end
end

function fzum -d "View all unmerged commits across all local branches"
  set viewUnmergedCommits "echo {} | head -1 | xargs -I BRANCH sh -c 'git log master..BRANCH --no-merges --color --format=\"%C(auto)%h - %C(green)%ad%Creset - %s\" --date=format:\'%b %d %Y\''"

  git branch --no-merged master --format "%(refname:short)" | fzf --no-sort --reverse --tiebreak=index --no-multi \
    --ansi --preview="$viewUnmergedCommits"
end
```

### SSH
```fish
function fssh -d "Fuzzy-find ssh host via ag and ssh into it"
  ag --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | read -l result; and ssh "$result"
end
```

### Tmux
```fish
function fs -d "Switch tmux session"
  tmux list-sessions -F "#{session_name}" | fzf | read -l result; and tmux switch-client -t "$result"
end
```

### LastPass CLI
```fish
function fpass -d "Fuzzy-find a Lastpass entry and copy the password"
  if not lpass status -q
    lpass login $EMAIL
  end

  if not lpass status -q
    exit
  end

  lpass ls | fzf | string replace -r -a '.+\[id: (\d+)\]' '$1' | read -l result; and lpass show -c --password "$result"
end
```

### Vscode
```fish
function vsr -d "List recently opened files with vscode"
    set -l vscode_path "$HOME/.config/VSCodium"
    set -l grep

    if type -q rg
        set grep rg -o --no-line-number
    else
        set grep grep -o
    end

    set -l selected (\
    $grep '"path": "/.*[^/]"' "$vscode_path/storage.json" \
    | string replace -a '"path": ' '' \
    | string trim -c '"'\
    | fzf --exit-0 )

    [ -n "$selected" ]; and codium "$selected"
end
```

### Clean $PATH
```fish
function pathclean --description "Clean up PATH variable"
    set PATH (printf "%s" "$PATH" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
end
```
