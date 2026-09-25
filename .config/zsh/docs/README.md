# ZSH

```ocaml
 ╔══════════════════════════════════════════════════════════════════════════╗
 ║            ┌────────────────────────────────────────────────┐            ║
 ║            │         ███▀▀▀███▄█▀▀▀█▄█████▀  ▀████▀▀        │            ║
 ║            │          █▀   ███▄██    ▀█ ██      ██          │            ║
 ║            │          ▀   ███ ▀███▄     ██      ██          │            ║
 ║            │             ███    ▀█████▄ ██████████          │            ║
 ║            │            ███   ▄     ▀██ ██      ██          │            ║
 ║            │           ███   ▄██     ██ ██      ██          │            ║
 ║            │         █████████▀█████▀▄████▄  ▄████▄▄        │            ║
 ║            ├────────────────────────────────────────────────┤            ║
 ║            │            ＺＳＨ ＣＯＮＦＩＧ                  │            ║
 ║            │ Ｍｙ Ｚ－Ｓｈｅｌｌ Ｃｏｎｆｉｇｕｒａｔｉｏｎ    │            ║
 ║            └────────────────────────────────────────────────┘            ║
 ╚══════════════════════════════════════════════════════════════════════════╝
```

> **A fully modular ZSH setup: startup files are split into numbered load stages,
and functions/plugins are toggled with an nginx-style `enabled`/`available`
symlink pattern.**

---

## Table of Contents

<!--toc:start-->
- [ZSH](#zsh)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Load Order](#load-order)
  - [Functions](#functions)
    - [Enabling a Function](#enabling-a-function)
    - [Enabled Functions](#enabled-functions)
      - [Navigation / cd](#navigation-cd)
      - [Git](#git)
      - [fzf / search](#fzf-search)
      - [Color / ANSI](#color-ansi)
      - [Files / text](#files-text)
      - [Network / remote](#network-remote)
      - [Security / system](#security-system)
      - [Terminal / display](#terminal-display)
      - [Misc](#misc)
  - [Plugins](#plugins)
    - [Enabling a Plugin](#enabling-a-plugin)
    - [Enabled Plugins](#enabled-plugins)
  - [Keybindings](#keybindings)
    - [Line Editing](#line-editing)
    - [History](#history)
    - [Navigation](#navigation)
    - [Selection (Shift-Select)](#selection-shift-select)
    - [Completion Menu (menuselect)](#completion-menu-menuselect)
    - [Vi Command Mode](#vi-command-mode)
    - [Plugins](#plugins-1)
  - [Configuration Toggles](#configuration-toggles)
  - [Structure](#structure)
- [Docker](#docker)
<!--toc:end-->

---

## Features

- **Modular startup** — `.zshrc` sources every `*.zsh` file in `zsh.d/` in
  numeric order, so behavior is split into small, ordered stages instead of one
  monolithic file.
- **Enabled/available toggles** — functions and plugins live in
  `*-available/` directories and are activated by symlinking them into the
  matching `*-enabled/` directory (like nginx `sites-enabled`).
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

## Functions

Functions live in `zsh/user/functions/`.

### Enabling a Function

Enable a function by symlinking it from `functions-available/` into
`functions-enabled/`. The symlink lives inside `functions-enabled/` and points
back into `functions-available/`:

```bash
cd "${ZDOTDIR}/zsh/user/functions/functions-enabled"
ln -s ../functions-available/mkcd.zsh mkcd.zsh

# Reload
exec zsh
```

To disable, remove the symlink from `functions-enabled/`:

```bash
rm "${ZDOTDIR}/zsh/user/functions/functions-enabled/mkcd.zsh"
```

### Enabled Functions

The following functions are currently enabled (symlinked into
`functions-enabled/`). See `functions-available/` for the full set of
functions that can be enabled.

#### Navigation / cd

| Function        | Description                                              |
| --------------- | -------------------------------------------------------- |
| `mkcd`          | Create a directory and `cd` into it                      |
| `cdx`           | `cd` to config directories based on a letter shortcut    |
| `cdlink`        | When `cd`-ing to a symlink, follow to the real target    |
| `cd-correction` | If you `cd` to a file, `cd` into its directory instead   |
| `cd-repo`       | `cd` to the current git repository root                  |
| `repo-root`     | Print the current git repository root                    |
| `gitcd`         | Clone a repo, then `cd` into it                          |
| `dirselect`     | Interactive directory selector                           |
| `rmcwd`         | Remove the current working directory                     |

#### Git

| Function                 | Description                                     |
| ------------------------ | ----------------------------------------------- |
| `g`                      | Render Markdown in the terminal                 |
| `gi`                     | `git` wrapper; runs `git status` with no args   |
| `git-blame-percentages`  | Show per-author blame percentages for a repo    |
| `git-open-url`           | Open the repo's `origin` remote URL in browser  |
| `gh-gist-clone`          | Clone a GitHub gist                             |
| `rm-git`                 | Remove `.git*` files/dirs below the cwd         |
| `wdotf`                  | Manage a Windows-side dotfiles bare repo        |

#### fzf / search

| Function              | Description                                     |
| --------------------- | ----------------------------------------------- |
| `fzfrg`               | Fuzzy-find with ripgrep                         |
| `fzfcolor`            | Fuzzy finder that previews file contents        |
| `manfzf`              | Fuzzy-find man pages                            |
| `man-global-apropos`  | Global `apropos` search across man pages        |
| `cht`                 | Query `cht.sh` cheat sheets                     |

#### Color / ANSI

| Function                     | Description                              |
| ---------------------------- | ---------------------------------------- |
| `ansi-colors`                | Print an ANSI color table                |
| `colortest`                  | Print an ANSI color table                |
| `listcolorANSI`              | Print the 256-color ANSI palette         |
| `terminal-truecolor-tests`   | Test terminal truecolor support          |
| `highlight`                  | Highlight regex matches in text (perl)   |
| `hl`                         | Syntax-highlight files via `highlight`   |
| `draw_entire_line`           | Draw a full-width line in a given style   |
| `line`                       | Fill the terminal width with a character |

#### Files / text

| Function                              | Description                            |
| ------------------------------------- | -------------------------------------- |
| `rmls`                                | List files before removing, on approval |
| `chmodchown`                          | Match a target's perms/owner to a reference file |
| `count-characters`                    | Count characters in the given args     |
| `split-path`                          | Split `$PATH` onto separate lines      |
| `find-and-replace-in-all-files-below` | Recursive `sed` find-and-replace       |
| `replace-backslashes-with-forward`    | Replace backslashes with forward slashes |
| `create-pdf`                          | Generate a minimal PDF from text       |
| `zsh-realpath2clip`                   | Copy a path's `realpath` to clipboard  |
| `xdg-open-clip`                       | Open the clipboard contents' URL/file  |

#### Network / remote

| Function             | Description                                   |
| -------------------- | --------------------------------------------- |
| `ssh-copy-key`       | Copy SSH public/private key to clipboard      |
| `ssh-secure-keygen`  | Create SSH keys                               |
| `rclone-tree`        | Show an rclone remote as a tree               |
| `rsync-timemachine`  | Time Machine-style backups with rsync         |
| `wget-website`       | Mirror a website with `wget`                  |
| `wetty-download`     | Download files through WeTTY                  |
| `yt-dlp_download`    | Download a video (with subs) via `yt-dlp`     |
| `espeak-url`         | Fetch a page, convert to text, speak via espeak |

#### Security / system

| Function                     | Description                              |
| ---------------------------- | ---------------------------------------- |
| `gpg-encrypt`                | Encrypt a file with GPG                  |
| `gpgID`                      | Return the ID of a GPG key               |
| `fail2ban-client-status-all` | Show the status of all Fail2Ban jails    |
| `verify-fstab`              | Verify `/etc/fstab` with `findmnt`        |
| `rm-.ansible`                | Safely remove nested `.ansible` dirs     |
| `jenkins-validate`           | Validate a Jenkinsfile via the linter    |

#### Terminal / display

| Function                  | Description                                  |
| ------------------------- | -------------------------------------------- |
| `hyperlink`               | Format text + URL into a clickable hyperlink |
| `asciinema-rec`           | Record the terminal with asciinema           |
| `terminal-record-script`  | Record the terminal with `script`            |
| `zsh-loading-bar`         | Show a loading bar                           |
| `turn-off-monitors`       | Toggle monitor power via `xset`              |
| `nitrogen-set-wallpaper`  | Set the wallpaper with nitrogen              |
| `pacmangraph`             | Generate a dependency graph with pacgraph    |
| `printimage`              | Print an image in the terminal               |

#### Misc

| Function       | Description                                    |
| -------------- | ---------------------------------------------- |
| `ez`           | Reload zsh (`exec zsh`)                         |
| `zsh-reload`   | Reload zsh (`exec zsh`)                         |
| `diagnostics`  | Generate a zsh diagnostics dump                 |
| `DEMOPROMPT`   | Switch to a preset "demo" prompt                |
| `thisisntvim`  | Remind you that you are not in vim              |
| `read-Yn`      | Yes/No prompt helper                            |
| `llll`         | Directory listing helper                        |

---

## Plugins

Plugins live in `zsh/user/plugins/`.

### Enabling a Plugin

Each plugin is a directory under `plugins-available/`; enable it by symlinking
its loader script (usually `*.plugin.zsh` or `*.zsh`) into `plugins-enabled/`:

```bash
cd "${ZDOTDIR}/zsh/user/plugins/plugins-enabled"
ln -s ../plugins-available/zsh-autopair/autopair.zsh autopair.zsh

# Reload
exec zsh
```

To disable, remove the symlink from `plugins-enabled/`:

```bash
rm "${ZDOTDIR}/zsh/user/plugins/plugins-enabled/autopair.zsh"
```

### Enabled Plugins

The following plugins are currently enabled (symlinked into `plugins-enabled/`):

| Plugin                        | Description                                        |
| ----------------------------- | -------------------------------------------------- |
| `z.lua`                       | Fast directory jumping based on frecency           |
| `zsh-fzf-history-search`      | Fuzzy history search via fzf                       |
| `colored-man-pages`           | Adds color to man pages                            |
| `autopair`                    | Auto-closes brackets, quotes, and parentheses      |
| `k`                           | Directory listings with git status and file sizes  |
| `copier`                      | Copy command output / buffer helpers               |
| `change-case`                 | Convert word/case styles on the command line       |
| `zsh-system-clipboard`        | Integrates yank/paste with the system clipboard    |
| `zsh-autoswitch-virtualenv`   | Auto-activates Python virtualenvs per directory    |
| `undollar`                    | Strips leading `$` from pasted commands            |
| `history-search-multi-word`   | Multi-word incremental history search              |
| `expand-ealias`               | Expands "explicit" aliases inline                  |
| `zprofile`                    | Startup profiling helper                           |
| `symmetric-ctrl-z`            | Toggle foreground/background jobs with `Ctrl-Z`    |
| `cheatsheet`                  | Quick-reference cheatsheet command                 |
| `sudo`                        | Prefix the current/previous command with `sudo`    |

---

## Keybindings

Custom keybindings configured in `zsh.d/50_keybindings.zsh` and
`zsh.d/99_keybindings.zsh`. Where the same key is bound in both files, the
`99_` binding wins because it loads last.

### Line Editing

| Key            | Action                                       |
| -------------- | -------------------------------------------- |
| <kbd>Home</kbd> | Go to beginning of line                     |
| <kbd>End</kbd>  | Go to end of line                           |
| <kbd>Backspace</kbd> | Delete one char backward               |
| <kbd>Delete</kbd> | Delete one char forward                   |
| <kbd>Ctrl</kbd>+<kbd>←</kbd> | Move backward one word          |
| <kbd>Ctrl</kbd>+<kbd>→</kbd> | Move forward one word           |
| <kbd>Ctrl</kbd>+<kbd>Backspace</kbd> | Delete previous word    |
| <kbd>Ctrl</kbd>+<kbd>Delete</kbd> | Delete next word           |
| <kbd>Ctrl</kbd>+<kbd>j</kbd> | Delete everything before cursor |
| <kbd>Esc</kbd>+<kbd>w</kbd> | Kill from cursor to mark          |
| <kbd>Ctrl</kbd>+<kbd>x</kbd> <kbd>Ctrl</kbd>+<kbd>e</kbd> | Edit current command line in `$EDITOR` |
| <kbd>Alt</kbd>+<kbd>m</kbd> | Copy previous shell word (file rename magic) |
| <kbd>.</kbd>   | Expand `..` to `../..` (rationalise-dot)     |
| <kbd>Space</kbd> | Magic space (no history expansion)         |

### History

| Key            | Action                                       |
| -------------- | -------------------------------------------- |
| <kbd>↑</kbd>   | Fuzzy find history / prev command            |
| <kbd>↓</kbd>   | Fuzzy find history / next command            |
| <kbd>PageUp</kbd> | Up a line of history                      |
| <kbd>PageDown</kbd> | Down a line of history                  |
| <kbd>Ctrl</kbd>+<kbd>h</kbd> | Multi-word history search       |
| <kbd>Ctrl</kbd>+<kbd>Backspace</kbd> | fzf history search (`zsh-fzf-history-search`) |

### Navigation

| Key            | Action                                       |
| -------------- | -------------------------------------------- |
| <kbd>Alt</kbd>+<kbd>↑</kbd> | `cd` to parent directory + list contents |
| <kbd>Alt</kbd>+<kbd>←</kbd> | `cd` to previous directory + list contents |
| <kbd>Esc</kbd>+<kbd>l</kbd> | Run `ls`                          |
| <kbd>Alt</kbd>+<kbd>g</kbd> | Run `dotf status`                 |

### Selection (Shift-Select)

| Key                 | Action                          |
| ------------------- | ------------------------------- |
| <kbd>Shift</kbd>+<kbd>←</kbd> / <kbd>→</kbd> | Extend selection by char |
| <kbd>Shift</kbd>+<kbd>↑</kbd> / <kbd>↓</kbd> | Extend selection by line |
| <kbd>Shift</kbd>+<kbd>Home</kbd> / <kbd>End</kbd> | Extend selection to line edge |
| <kbd>Shift</kbd>+<kbd>Alt</kbd>+<kbd>←</kbd> / <kbd>→</kbd> | Extend selection by word |
| <kbd>Shift</kbd>+<kbd>Alt</kbd>+<kbd>Home</kbd> / <kbd>End</kbd> | Extend selection to buffer edge |
| <kbd>Delete</kbd> / <kbd>Backspace</kbd> | Kill selected region |

### Completion Menu (menuselect)

| Key            | Action                                       |
| -------------- | -------------------------------------------- |
| <kbd>Shift</kbd>+<kbd>Tab</kbd> | Move backward through completion menu |
| <kbd>h</kbd> / <kbd>j</kbd> / <kbd>k</kbd> / <kbd>l</kbd> | Vi-style navigation in menu |
| <kbd>Ctrl</kbd>+<kbd>n</kbd> | Accept selection, continue menu completion |
| <kbd>PageUp</kbd> / <kbd>PageDown</kbd> | Jump by word in menu     |
| <kbd>gg</kbd> / <kbd>G</kbd> | Jump to top / bottom of menu    |

### Vi Command Mode

| Key            | Action                                       |
| -------------- | -------------------------------------------- |
| <kbd>gg</kbd> / <kbd>G</kbd> | Beginning / end of buffer       |
| <kbd>gc</kbd>  | Toggle comment on current line               |
| <kbd>gl</kbd>  | Transpose lines                              |
| <kbd>tw</kbd> / <kbd>tm</kbd> | Transpose words                 |
| <kbd>cs</kbd> / <kbd>ds</kbd> / <kbd>ys</kbd> | Change / delete / add surround |
| <kbd>S</kbd> (visual) | Add surround                          |
| <kbd>ZZ</kbd>  | Kill region                                  |
| <kbd>ZQ</kbd>  | Exit shell                                   |
| <kbd>Ctrl</kbd>+<kbd>h</kbd> | Up one directory (`_up-dir`)    |
| <kbd>Alt</kbd>+<kbd>j</kbd> | Show `which-command` for current buffer |
| <kbd>Esc</kbd>+<kbd>w</kbd> | Wrap current buffer in `$(which ...)` |

### Plugins

Keybindings provided by enabled plugins:

| Key            | Plugin                     | Action                                  |
| -------------- | -------------------------- | --------------------------------------- |
| <kbd>Ctrl</kbd>+<kbd>Backspace</kbd> | `zsh-fzf-history-search` | Fuzzy reverse-search of history via fzf |
| <kbd>Ctrl</kbd>+<kbd>z</kbd> | `symmetric-ctrl-z`   | Toggle foreground/background of last job |
| <kbd>Ctrl</kbd>+<kbd>o</kbd> | `copier`             | Copy current command line to clipboard   |
| <kbd>Ctrl</kbd>+<kbd>n</kbd> / <kbd>Ctrl</kbd>+<kbd>p</kbd> | `history-search-multi-word` | Next / previous match while searching |
| <kbd>Space</kbd> | `expand-ealias`          | Expand an explicit alias inline          |
| <kbd>Ctrl</kbd>+<kbd>Space</kbd> | `expand-ealias`  | Magic space (bypass alias expansion)     |

> Note: `autopair` also binds bracket/quote characters (and <kbd>Backspace</kbd> in
> its keymap) to auto-close and auto-delete matching pairs.

> Press <kbd>Ctrl</kbd>+<kbd>x</kbd> <kbd>Ctrl</kbd>+<kbd>z</kbd> to display the current keybindings.

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
│       │   ├── plugins-available     # All plugins
│       │   └── plugins-enabled       # Symlinks to enable
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
