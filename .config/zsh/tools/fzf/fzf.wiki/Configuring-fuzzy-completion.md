## Changing the layout

See https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings#changing-the-layout

## zsh

### Dedicated completion key

Instead of using `TAB` key with a trigger sequence (`**<TAB>`), you can assign a dedicated key for fuzzy completion while retaining the default behavior of `TAB` key.

Add the following lines *after* `source ~/.fzf.zsh`

```sh
export FZF_COMPLETION_TRIGGER=''
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion
```

Then `CTRL-T` will trigger context-aware fuzzy completion.

For bash, see https://github.com/junegunn/fzf/issues/1804.

### Caveats

#### `setopt vi`

`setopt vi` resets `TAB` key binding, so unless you've assigned a dedicated key, fuzzy completion will become unavailable.

```sh
> bindkey '^I'
"^I" fzf-completion

> setopt vi
> bindkey '^I'
"^I" expand-or-complete
```

So make sure that `.fzf.zsh` (or `completion.zsh`) is sourced after `setopt vi`.