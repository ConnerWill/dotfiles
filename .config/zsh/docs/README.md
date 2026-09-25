# ZSH

> My modular Z-Shell configuration

A fully modular ZSH setup: startup files are split into numbered load stages,
and functions/plugins are toggled with an Apache-style `enabled`/`available`
symlink pattern.

---

## Features

- **Modular startup** — `.zshrc` sources every `*.zsh` file in `zsh.d/` in
  numeric order, so behavior is split into small, ordered stages instead of one
  monolithic file.
- **Enabled/available toggles** — functions and plugins live in
  `*-available/` directories and are activated by symlinking them into the
  matching `*-enabled/` directory (like Apache `sites-enabled`).
- **80+ custom functions** — fzf integrations, git helpers, ANSI/color tooling,
  and rclone/ssh/gpg utilities in `functions/functions-available/`.
- **Curated plugins** — syntax highlighting, autosuggestions, autopair,
  history search, `z.lua` jumping, system clipboard, vi-mode, and more.
- **Per-machine profiles** — switch config profiles with `ZSH_USER_DIR_NAME`
  without touching the tracked files.
- **Secrets stay private** — machine-specific credentials go in
  `.private/*.private.zsh`, which is sourced last and kept out of the repo.
- **Debugging & profiling** — built-in toggles for verbose startup, debug
  logging, and `zprof` startup profiling.

---

## Load Order

On startup `.zshrc` sources every `*.zsh` file in `zsh.d/` in numeric order:

| Prefix | Purpose                       |
| ------ | ----------------------------- |
| `00_`  | Pre-load setup                |
| `09_`  | `PATH`                        |
| `10_`  | Variables, fpath              |
| `20_`  | Options, history              |
| `30_`  | Modules                       |
| `40_`  | Plugins                       |
| `50_`  | Keybindings                   |
| `60_`  | Functions                     |
| `70_`  | Aliases (own + vendor)        |
| `75_`  | OS-specific overrides         |
| `80_`  | Hooks, colors, VCS prompts    |
| `85_`  | Highlighting                  |
| `90_`  | Completions                   |
| `98_`  | Post-load                     |
| `99_`  | Final keybindings / overrides |

After `zsh.d/`, files in `.private/` are sourced last.

---

## Enabling a Function or Plugin

Activate a function or plugin by symlinking it from `*-available/` into
`*-enabled/`:

```bash
# Enable a function
cd "${ZDOTDIR}/zsh/user/functions"
ln -s ../functions-available/mkcd.zsh functions-enabled/mkcd.zsh

# Enable a plugin
cd "${ZDOTDIR}/zsh/user/plugins"
ln -s ../plugins-available/zsh-autosuggestions plugins-enabled/zsh-autosuggestions

# Reload
exec zsh
```

To disable, remove the symlink from the `*-enabled/` directory.

---

## Configuration Toggles

Set these before `exec zsh` to change startup behavior:

| Variable                 | Default | Description                                   |
| ------------------------ | ------- | --------------------------------------------- |
| `ZSH_USER_DIR_NAME`      | `user`  | Selects which profile under `zsh/` to load    |
| `_INHERIT_ENV`           | _unset_ | Skip loading configs (minimal inherited shell) |
| `_ZSH_LOAD_VERBOSE`      | _unset_ | Enable `xtrace` for extremely verbose startup |
| `_ZSH_DEBUGGING_ENABLED` | `TRUE`  | Write a debug log to `$ZSH_DEBUG_LOG_DIR`     |
| `ZSH_PROFILE_RC`         | _unset_ | Run `zsh/zprof` to profile startup time       |

Example — load an alternate profile:

```bash
ZSH_USER_DIR_NAME=work exec zsh
```

---

## Structure

These are the files/directories that are sourced on ZSH startup:

```
.
├── zsh/
│   └── user/
│       ├── completion/               # Custom _completions
│       ├── fpath/
│       ├── functions/
│       │   ├── functions-available   # All functions
│       │   └── functions-enabled     # Symlinks to enable
│       ├── plugins/
│       │   ├── plugins-available      # All plugins
│       │   └── plugins-enabled        # Symlinks to enable
│       ├── .private/                 # Untracked secrets (*.private.zsh)
│       └── zsh.d/
│           ├── 00_pre.zsh
│           ├── 09_path.zsh
│           ├── 10_variables.zsh
│           ├── 20_options.zsh
│           ├── 21_history.zsh
│           ├── 30_modules.zsh
│           ├── 40_plugins.zsh
│           ├── 50_keybindings.zsh
│           ├── 60_functions.zsh
│           ├── 70_aliases.zsh
│           ├── 71_vendor_aliases.zsh
│           ├── 75_OS_specific.zsh
│           ├── 80_hooks.zsh
│           ├── 82_colors.zsh
│           ├── 83_vcs_prompts.zsh
│           ├── 85_highlighting.zsh
│           ├── 90_completions.zsh
│           ├── 98_post.zsh
│           └── 99_keybindings.zsh
├── .zshenv
├── .zshrc
├── .zlogin
└── .zprofile
```

---

# Docker

You can test out my ZSH configuration in Docker

> Build the Docker container

```bash
docker build --tag connerwill-dotfiles-zsh:latest .
```

> Run the Docker container

```bash
docker run        \
    --rm          \
    --interactive \
    --tty         \
    connerwill-dotfiles-zsh:latest
```
