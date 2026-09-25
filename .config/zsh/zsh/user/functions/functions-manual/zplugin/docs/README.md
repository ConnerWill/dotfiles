# NAME

**zplugin**


# DESCRIPTION

Install, enable, disable, and remove *vendored* zsh plugins using the
enabled/available symlink pattern (like nginx `sites-enabled`).

`zplugin` clones a plugin into `plugins-available/`, strips its nested `.git`
so the dotfiles repo tracks it as plain files (vendoring), symlinks the loader
script into `plugins-enabled/`, and — if [`dotf`](https://github.com/connerwill/dotf)
is available — tracks the new files automatically. It is styled after `dotf`
with the same colored output, split help menus, and tab-completion.


# USAGE

```bash
zplugin [-hV] [--help|help] [--usage|usage] [--examples|examples]
        [install|i|add <repo>] [enable|e <name>] [disable|d <name>]
        [remove|rm <name>] [list|ls]
```

```bash
zplugin install <repo>   # repo = full URL, or user/repo (assumes GitHub)
zplugin enable  <name>
zplugin disable <name>
zplugin remove  <name>
zplugin list
```


# OPTIONS

```
install, i, add <repo>
```

Clone a plugin into `plugins-available/`, strip its `.git`, enable it (symlink
the loader into `plugins-enabled/`), and track the files with `dotf` (if
available). The `<repo>` may be a full git URL, or the `user/repo` shorthand
(GitHub is assumed).

```
enable, e <name>
```

Symlink an already-installed plugin's loader script into `plugins-enabled/`.

```
disable, d <name>
```

Remove a plugin's symlink from `plugins-enabled/` (the files stay in
`plugins-available/`).

```
remove, rm <name>
```

Disable and delete a plugin from `plugins-available/`.

```
list, ls
```

List available plugins and their enabled state. Enabled plugins show a filled
`●` marker; disabled ones show a hollow `○`.


# META OPTIONS

```
-h, h
```

Show the help menu

```
--help, help
```

Show the full **zplugin** help menu

```
--usage, usage
```

Show **zplugin** usage

```
--examples, examples
```

Show **zplugin** examples

```
-V, --version
```

Show **zplugin** version


# EXAMPLES

Install a plugin using the `user/repo` shorthand. GitHub is assumed, so this
clones `https://github.com/hlissner/zsh-autopair`:

```bash
$  zplugin install hlissner/zsh-autopair
```

Install a plugin from a full git URL (any host, not just GitHub). The plugin is
vendored (its nested `.git` is stripped) and enabled automatically:

```bash
$  zplugin install https://github.com/skywind3000/z.lua.git
```

List every installed plugin along with whether it is currently enabled:

```bash
$  zplugin list
```

Temporarily turn a plugin off without deleting it. This just removes the symlink
from `plugins-enabled/`; the files stay in `plugins-available/`:

```bash
$  zplugin disable zsh-autopair
```

Turn a previously-disabled plugin back on by re-creating its symlink:

```bash
$  zplugin enable zsh-autopair
```

Completely remove a plugin: this disables it first, then deletes it from
`plugins-available/`. Since plugins are vendored, re-install to update:

```bash
$  zplugin remove zsh-autopair
```

After any install/enable/disable/remove, reload zsh so the change takes effect:

```bash
$  exec zsh
```


# HOW IT WORKS

Plugins are **vendored**: rather than tracking each plugin as a git submodule,
its files are committed directly into the dotfiles repo. `zplugin install`
does this by:

1. Normalizing the argument into a clone URL (`user/repo` → `https://github.com/user/repo`).
2. Cloning shallowly (`git clone --depth=1`) into `plugins-available/<name>`.
3. Removing the nested `.git` directory — git will not track files inside a
   directory that contains its own `.git`, so removing it turns the plugin into
   plain, tracked files.
4. Enabling it by symlinking the loader into `plugins-enabled/` (see below).
5. Tracking the new files with `dotf add` if `dotf` is on the shell.

The loader script is auto-detected in this order:

1. `<name>.plugin.zsh`
2. any `*.plugin.zsh`
3. `<name>.zsh`
4. a lone `*.zsh` file

The enabled symlink is created relative (`ln -rs`) so it stays valid regardless
of where the dotfiles live.


# COMPLETION

Tab-completion is defined inside the function file itself (`bin/zplugin`) — no
separate completion file is needed. It completes:

- **Subcommands and options** (with descriptions): `install`, `enable`,
  `disable`, `remove`, `list`, their aliases, and the meta options.
- **Installed plugin names** for `enable`, `disable`, and `remove` (read from
  the directories in `plugins-available/`).

Because `compinit` (which provides `compdef`) initializes at a later startup
stage than the function is sourced, the completion registers immediately if
`compdef` already exists, otherwise it defers registration via a one-shot
`precmd` hook that fires (and removes itself) once completions are ready.


# INSTALLATION

`zplugin` ships as a *manual* function. It is not enabled via the
`functions-available` → `functions-enabled` symlink like most functions;
instead it is sourced directly from `zsh.d/60_functions.zsh`:

```bash
if [[ -f "${ZSH_FUNCTIONS_MANUAL}/zplugin/bin/zplugin" ]]; then
  source "${ZSH_FUNCTIONS_MANUAL}/zplugin/bin/zplugin"
fi
```

It relies on the plugin-directory variables exported in
`zsh.d/40_plugins.zsh` (`ZSH_PLUGINS_AVAILABLE`, `ZSH_PLUGINS_ENABLED`), and
falls back to deriving them from `ZSH_USER_DIR`/`ZDOTDIR` if they are unset.


# SEE ALSO

- The dotfiles [README](../../../../../../docs/README.md) — *Plugins* section
- [`dotf`](https://github.com/connerwill/dotf) — the dotfiles manager this
  function is modeled after
