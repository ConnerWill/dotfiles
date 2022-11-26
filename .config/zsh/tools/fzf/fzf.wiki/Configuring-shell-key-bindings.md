## Changing the layout

The key bindings use `--height 40%` option to display fzf finder below your cursor, but it's configurable.

If you prefer to run fzf in full screen mode, add `--no-height` to your `$FZF_DEFAULT_OPTS` like follows:

```sh
export FZF_DEFAULT_OPTS='--no-height --no-reverse'
```

Or if you prefer to start in a tmux split pane, set `$FZF_TMUX` to `1`.

```sh
export FZF_TMUX=1
```

## `CTRL-T`

### Preview

You can preview the content of the file under the cursor by setting `--preview` option.

```sh
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
```

### Using `--select-1` and/or `--exit-0`

```sh
export FZF_CTRL_T_OPTS="--select-1 --exit-0"
```

`--select-1` automatically selects the item if there's only one so that you don't have to press enter key. Likewise, `--exit-0` automatically exits when the list is empty. These options are also useful in `FZF_ALT_C_OPTS`.

## `CTRL-R`

### Sorting and exact matching

Sorting by relevance is enabled by default. You can dynamically switch to chronological order by pressing `CTRL-R` again, but if you like it to be enabled by default, add `--no-sort` to `FZF_CTRL_R_OPTS`. Likewise, if you prefer to use exact (non-fuzzy) matching, add `--exact`.

```sh
export FZF_CTRL_R_OPTS='--no-sort --exact'
```

### Full command on preview window

Commands that are too long are not fully visible on screen. We can use `--preview` option to display the full command on the preview window. In the following example, we bind `?` key for toggling the preview window.

```sh
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
```

### Directly executing the command (CTRL-X CTRL-R)

#### zsh

```sh
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept
```

#### bash

```sh
bind "$(bind -s | grep '^"\\C-r"' | sed 's/"/"\\C-x/' | sed 's/"$/\\C-m"/')"
```

### Dynamically choose to execute or edit

There is an open issue for this; [#477](https://github.com/junegunn/fzf/issues/477). We have a solution for zsh, but not for bash.

## `ALT-C`

### Preview

The following example uses `tree` command to show the entries of the directory.

```sh
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
```