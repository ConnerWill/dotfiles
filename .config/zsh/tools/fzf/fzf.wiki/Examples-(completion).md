_**Custom completion API is experimental and subject to change**_


Writing custom fuzzy completion
-------------------------------

See https://github.com/junegunn/fzf#custom-fuzzy-completion

### [ZSH] Complete hg update/hg merge

If you need to add branch name completion for a subset of hg commands, e.g. hg up, hg merge, you can use technique as follows (zsh completion):

```sh
_fzf_complete_hg() {
  ARGS="$@"
  if [[ $ARGS == 'hg merge'* ]] || [[ $ARGS == 'hg up'* ]]; then
    _fzf_complete --no-sort -- "$@" < <(
      { hg branches & hg tags }
    )
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}

_fzf_complete_hg_post() {
  cut -f1 -d' '
}
```

### [ZSH] Complete `git co` (for example)

You can use the same approach as above to complete any git command. In the example below, completion is triggered on `git co` (usual alias for `git checkout`):

```sh
_fzf_complete_git() {
    ARGS="$@"
    local branches
    branches=$(git branch -vv --all)
    if [[ $ARGS == 'git co'* ]]; then
        _fzf_complete --reverse --multi -- "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}
```

### [ZSH] [pass](http://www.passwordstore.org/)
```zsh
_fzf_complete_pass() {
  _fzf_complete +m -- "$@" < <(
    local prefix
    prefix="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
    command find -L "$prefix" \
      -name "*.gpg" -type f | \
      sed -e "s#${prefix}/\{0,1\}##" -e 's#\.gpg##' -e 's#\\#\\\\#' | sort
  )
}
```

### [BASH] Custom trigger-less completion

If you want to remove the `**` trigger just for certain completions, you can achieve this like so:

```bash
_fzf_complete_ssh_notrigger() {
    FZF_COMPLETION_TRIGGER='' _fzf_host_completion
}

complete -o bashdefault -o default -F _fzf_complete_ssh_notrigger ssh
complete -o bashdefault -o default -F _fzf_complete_ssh_notrigger mosh
complete -o bashdefault -o default -F _fzf_complete_ssh_notrigger ss
```
