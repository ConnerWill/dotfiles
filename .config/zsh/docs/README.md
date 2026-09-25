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
  - [Structure](#structure)
  - [Load Order](#load-order)
  - [Plugins](#plugins)
    - [Installing a Plugin](#installing-a-plugin)
    - [Enabling a Plugin](#enabling-a-plugin)
    - [Enabled Plugins](#enabled-plugins)
      - [z.lua](#zlua)
      - [zsh-fzf-history-search](#zsh-fzf-history-search)
      - [colored-man-pages](#colored-man-pages)
      - [autopair](#autopair)
      - [k](#k)
      - [copier](#copier)
      - [change-case](#change-case)
      - [zsh-system-clipboard](#zsh-system-clipboard)
      - [zsh-autoswitch-virtualenv](#zsh-autoswitch-virtualenv)
      - [undollar](#undollar)
      - [history-search-multi-word](#history-search-multi-word)
      - [expand-ealias](#expand-ealias)
      - [zprofile](#zprofile)
      - [symmetric-ctrl-z](#symmetric-ctrl-z)
      - [cheatsheet](#cheatsheet)
      - [sudo](#sudo)
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
  - [Keybindings](#keybindings)
    - [Line Editing](#line-editing)
    - [History](#history)
    - [Navigation](#navigation)
    - [Selection (Shift-Select)](#selection-shift-select)
    - [Completion Menu (menuselect)](#completion-menu-menuselect)
    - [Vi Command Mode](#vi-command-mode)
    - [Plugins](#plugins-1)
  - [Configuration Toggles](#configuration-toggles)
  - [Tools](#tools)
  - [Libraries](#libraries)
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

## Plugins

Plugins live in `zsh/user/plugins/`.

### Installing a Plugin

Plugins are *vendored*: their files are committed directly into the dotfiles
repo rather than tracked as git submodules. To achieve this, clone the plugin
into `plugins-available/` and then remove its nested `.git` directory — git
will not track files inside a directory that contains its own `.git`, so
removing it turns the plugin into plain, tracked files.

```bash
cd "${ZSH_PLUGINS_AVAILABLE}"

# 1. Clone the plugin (shallow — history is discarded anyway)
git clone --depth=1 https://github.com/<owner>/<plugin>.git

# 2. Remove its git metadata so it becomes plain files in the dotfiles repo
rm -rf <plugin>/.git

# 3. Enable it (see "Enabling a Plugin" below)
ln -rs "${ZSH_PLUGINS_AVAILABLE}/<plugin>/<plugin>.plugin.zsh" "${ZSH_PLUGINS_ENABLED}/<plugin>.plugin.zsh"

# 4. Track the new files in the dotfiles bare repo
dotf add "${ZSH_PLUGINS_AVAILABLE}/<plugin>"
dotf add "${ZSH_PLUGINS_ENABLED}/<plugin>.plugin.zsh"

# 5. Reload
exec zsh
```

> **Note:** the loader script is usually `*.plugin.zsh` or `*.zsh` — check the
> plugin's repository for the correct filename.

To **update** a vendored plugin later, re-clone it, `rm -rf .git`, and copy the
files over the existing directory (the `Upstream:` link under each plugin in
[Enabled Plugins](#enabled-plugins) records where each one came from).

### Enabling a Plugin

Each plugin is a directory under `plugins-available/`; enable it by symlinking
its loader script (usually `*.plugin.zsh` or `*.zsh`) into `plugins-enabled/`:

```bash
ln -rs "${ZSH_PLUGINS_AVAILABLE}/zsh-autopair/autopair.zsh" "${ZSH_PLUGINS_ENABLED}/autopair.zsh"

# Reload
exec zsh
```

To disable, remove the symlink from `plugins-enabled/`:

```bash
rm "${ZSH_PLUGINS_ENABLED}/autopair.zsh"
```

### Enabled Plugins

The following plugins are currently enabled (symlinked into `plugins-enabled/`).

#### z.lua

Fast directory jumping based on "frecency" (frequency + recency). It tracks the
directories you visit and lets you jump straight to them, e.g. `z foo` jumps to
the most frecent directory matching `foo`, and `z foo bar` matches a path
containing both. Also supports interactive selection (`z -i`), fzf-backed
selection (`z -I`), and quick parent-directory jumps (`z -b foo`). A faster,
more portable alternative to `z.sh`/autojump.

- Upstream: <https://github.com/skywind3000/z.lua>

#### zsh-fzf-history-search

Replaces the default `Ctrl-R` reverse history search with an
[fzf](https://github.com/junegunn/fzf)-driven, fuzzy, searchable list of your
command history. Requires `fzf` to be installed.

- Upstream: <https://github.com/joshskidmore/zsh-fzf-history-search>

#### colored-man-pages

Provides a `man` wrapper that colorizes man pages by setting the
`LESS_TERMCAP_*` environment variables (bold, underline, reverse, etc.) that
`less` uses for rendering. ANSI sequences are pulled from the terminfo database
via `tput`.

- Upstream: <https://github.com/ael-code/zsh-colored-man-pages>

#### autopair

Intelligently auto-closes, skips over, and deletes matching delimiters
(brackets, quotes, spaces). It inserts matching pairs, skips over an existing
closing character instead of inserting a duplicate, auto-deletes both halves of
a pair on backspace, and expands/contracts spaces between brackets — only when
doing so makes sense (balanced pairs, cursor not next to a boundary character).

- Upstream: <https://github.com/hlissner/zsh-autopair>

#### k

Directory listings for zsh with git features. Like `ls`, but adds color and
inline git status for files and directories, grades file sizes by color (green
for small, red for large), and fades dates with age. Human-readable sizes are
available via `-h` (requires `numfmt`/`gnumfmt` from GNU coreutils).

- Upstream: <https://github.com/supercrabtree/k>

#### copier

Oh-My-Zsh clipboard utilities packaged as a standalone plugin. Provides
`clipcopy`/`clippaste` for copying to and pasting from the command line,
`copydir` to copy the current directory path, `copyfile` to copy a file's
contents, and `copybuffer` (bound to <kbd>Ctrl</kbd>+<kbd>o</kbd>) to copy the
current command buffer to the clipboard.

- Upstream: <https://github.com/zshzoo/copier>

#### change-case

Adds ZLE widgets to convert the case/word style of text on the command line
(e.g. upper, lower). Inspired by VSCode/Sublime, the author suggests bindings
like <kbd>Ctrl</kbd>+<kbd>K</kbd> <kbd>Ctrl</kbd>+<kbd>U</kbd> to uppercase and
<kbd>Ctrl</kbd>+<kbd>K</kbd> <kbd>Ctrl</kbd>+<kbd>L</kbd> to lowercase.

- Upstream: <https://github.com/mtxr/zsh-change-case>

#### zsh-system-clipboard

Synchronizes ZLE (Zsh Line Editor) yank/paste operations with the system
clipboard for vi-emulation keymaps. Normally ZLE keeps its own clipboard buffer,
so yanking with <kbd>y</kbd> in vi normal mode won't reach the system clipboard;
this plugin bridges the two without overriding ZLE's own registers. Works on
Linux, macOS, and Android (Termux), and can also sync tmux buffers when
`ZSH_SYSTEM_CLIPBOARD_TMUX_SUPPORT` is set to `'true'`.

- Upstream: <https://github.com/kutsan/zsh-system-clipboard>

#### zsh-autoswitch-virtualenv

Automatically activates and deactivates Python virtualenvs as you `cd` between
projects. It looks for a `.venv` file in the directory (the marker filename is
configurable via `AUTOSWITCH_FILE`) and activates the matching environment,
storing environments under `$AUTOSWITCH_VIRTUAL_ENV_DIR` (default
`~/.virtualenvs`). It refuses to source paths containing `..` as a safety check.

- Upstream: <https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv>

#### undollar

Strips a leading `$` from a pasted command. When you copy a command from the web
that includes the shell-prompt `$` (e.g. `$ tar xvfJ file.tar.xz`), undollar
registers `$` as an alias that simply runs whatever follows it, so the stray
prompt character no longer causes a "command not found" error.

- Upstream: <https://github.com/zpm-zsh/undollar>

#### history-search-multi-word

Binds `Ctrl-R` to a multi-word history search: enter several keywords and it
finds history entries matching *all* of them (AND matching), with syntax
highlighting. Also offers "context viewing" to see matched commands alongside
their surrounding history.

- Upstream: <https://github.com/zdharma-continuum/history-search-multi-word>

#### expand-ealias

Expands "explicit" aliases inline as you type. Aliases registered with the
`ealias` helper are expanded in place the moment you press <kbd>Space</kbd>, so
you see the full command before running it (similar to vim abbreviations), while
ordinary aliases are left untouched. Press <kbd>Ctrl</kbd>+<kbd>Space</kbd> for a
magic space that bypasses expansion.

#### zprofile

Startup profiling helper. Wrap the section of your `.zshrc` you want to measure
between `zprofile::before` and `zprofile::after` (gated on `$ZPROFILE`), then use
the `zprofile`, `zprofile benchmark`, or `zprofile <FUNCTION_CALL>` commands to
inspect timing.

- Upstream: <https://github.com/qoomon/zprofile>

#### symmetric-ctrl-z

Makes <kbd>Ctrl</kbd>+<kbd>Z</kbd> symmetric: as well as suspending a foreground
job, pressing it on an empty command line brings the most recent background job
back to the foreground. Based on Oh-My-Zsh's `fancy-ctrl-z`.

- Upstream: <https://github.com/zshzoo/symmetric-ctrl-z>

#### cheatsheet

A `cs` command to view, create, edit, list, and remove personal cheatsheets.
Sheets are stored under `~/.config/cs-zsh/sheets` and edited with `$EDITOR`
(falling back to `vim`). Examples: `cs add my-cheatsheet`, `cs list`,
`cs my-cheatsheet`.

#### sudo

Press the bound hotkey (default <kbd>Esc</kbd> <kbd>s</kbd>) to toggle `sudo` (or
`sudoedit`) at the front of the current command line. If the line is empty, it
pulls the last command from history first, so you can re-run the previous command
with `sudo`. Based on the Oh-My-Zsh `sudo` plugin.

---

## Functions

Functions live in `zsh/user/functions/`.

### Enabling a Function

Enable a function by symlinking it from `functions-available/` into
`functions-enabled/`. The symlink lives inside `functions-enabled/` and points
back into `functions-available/`:

```bash
ln -rs "${ZSH_FUNCTIONS_AVAILABLE}/mkcd.zsh" "${ZSH_FUNCTIONS_ENABLED}/mkcd.zsh"

# Reload
exec zsh
```

To disable, remove the symlink from `functions-enabled/`:

```bash
rm "${ZSH_FUNCTIONS_ENABLED}/mkcd.zsh"
```

### Enabled Functions

The following functions are currently enabled (symlinked into
`functions-enabled/`). See `functions-available/` for the full set of
functions that can be enabled.

#### Navigation / cd

| Function        | Description                                              |
| --------------- | -------------------------------------------------------- |
| `mkcd`          | Create a directory and `cd` into it                      |
| `cdX` / `cdz`   | `cd` to config directories based on a letter shortcut    |
| `cdlink`        | When `cd`-ing to a symlink, follow to the real target    |
| `cd`            | `cd` correction: if you `cd` to a file, `cd` into its directory instead |
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
| `rm_git`                 | Remove `.git*` files/dirs below the cwd         |
| `wdotf`                  | Manage a Windows-side dotfiles bare repo        |

#### fzf / search

| Function              | Description                                     |
| --------------------- | ----------------------------------------------- |
| `fzfrg`               | Fuzzy-find with ripgrep                         |
| `fzfcolor`            | Fuzzy finder that previews file contents        |
| `manfzf`              | Fuzzy-find man pages                            |
| `man_global_apropos`  | Global `apropos` search across man pages        |
| `cht`                 | Query `cht.sh` cheat sheets                     |

#### Color / ANSI

| Function                     | Description                              |
| ---------------------------- | ---------------------------------------- |
| `ansi-colors`                | Print an ANSI color table                |
| `colortest`                  | Print an ANSI color table                |
| `listcolorANSI`              | Print the 256-color ANSI palette         |
| `check-if-truecolor`         | Test terminal truecolor support          |
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
| `split-path` (`pathnewlines` / `fpathnewlines`) | Split `$PATH` / `$fpath` onto separate lines |
| `find-and-replace-in-all-files-below` | Recursive `sed` find-and-replace       |
| `replace-backslashes-with-forward`    | Replace backslashes with forward slashes |
| `create_pdf`                          | Generate a minimal PDF from text       |
| `realpath2clip` (`cd2clip` / `pwd2clip`) | Copy a path's `realpath` (or cwd) to clipboard |
| `xdg-open-clip`                       | Open the clipboard contents' URL/file  |

#### Network / remote

| Function             | Description                                   |
| -------------------- | --------------------------------------------- |
| `copysshkeypublic` / `copysshkeyprivate` | Copy SSH public/private key to clipboard |
| `ssh-secure-keygen`  | Create SSH keys                               |
| `rclone-tree`        | Show an rclone remote as a tree               |
| `rsync-timemachine`  | Time Machine-style backups with rsync         |
| `wgetmirrorwebsite`  | Mirror a website with `wget`                  |
| `wetty-download`     | Download files through WeTTY                  |
| `yt-dlp_download`    | Download a video (with subs) via `yt-dlp`     |
| `espeak-url`         | Fetch a page, convert to text, speak via espeak |

#### Security / system

| Function                     | Description                              |
| ---------------------------- | ---------------------------------------- |
| `gpg-encrypt-file` / `gpg-decrypt-file` | Encrypt / decrypt a file with GPG      |
| `gpgID`                      | Return the ID of a GPG key               |
| `fail2ban-client-status-all` | Show the status of all Fail2Ban jails    |
| `verify-fstab`              | Verify `/etc/fstab` with `findmnt`        |
| `rm-.ansible`                | Safely remove nested `.ansible` dirs     |
| `jenkins-validate`           | Validate a Jenkinsfile via the linter    |

#### Terminal / display

| Function                  | Description                                  |
| ------------------------- | -------------------------------------------- |
| `hyperlink`               | Format text + URL into a clickable hyperlink |
| `asciinemarec`            | Record the terminal with asciinema           |
| `script-terminal-rec`     | Record the terminal with `script`            |
| `zsh-rainbow-loading-bar` / `zsh-rainbow-loading-bar-oneline` | Show a (rainbow) loading bar |
| `toggle-monitor-power`    | Toggle monitor power via `xset`              |
| `nitrogen-set-wallpaper`  | Set the wallpaper with nitrogen              |
| `pacmangraph`             | Generate a dependency graph with pacgraph    |

#### Misc

| Function       | Description                                    |
| -------------- | ---------------------------------------------- |
| `ez`           | Reload zsh (`exec zsh`)                         |
| `zshreload`    | Reload zsh (`exec zsh`)                         |
| `zsh_diagnostic_dump` | Generate a zsh diagnostics dump          |
| `zsh_listbindings` | List all zsh keybindings across every keymap |
| `DEMOPROMPT`   | Switch to a preset "demo" prompt                |
| `thisisntvim`  | Remind you that you are not in vim              |
| `read-Yn`      | Yes/No prompt helper                            |
| `llll`         | Directory listing helper                        |

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

> Run `zsh_listbindings` to print every keybinding across all keymaps, grouped
> and colorized by keymap.

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

## Tools

Standalone helper scripts and reference material live in `zsh/tools/`. These are
not sourced on startup — they're run manually when needed.

| Tool                              | Description                                                                 |
| --------------------------------- | --------------------------------------------------------------------------- |
| `pkgsearch`                       | fzf-driven browser/installer for your distro's packages (with AUR support on Arch) |
| `compile-zshconfig/`              | Recipe for flattening the whole startup into a single `combined.zsh` (see its `README.md`) |
| `debugging/`                      | A collection of zsh debuggers/tracers — `zshdb`, `ztrace`, `zbrowse`, `zhooks`, `zsnapshot`, `zui`, and `reporter` — plus `zsh-trace.zsh` and a `README.md` with a debug-log recipe |
| `git-check-gitattributes.sh`      | `git-check-missing-gitattributes`: flag tracked files with no `.gitattributes` rule |
| `zsh-zle-list-all.zsh`            | Print every ZLE widget alongside its `which` definition                     |
| `ansi-escape-sequences/`          | Reference + scripts for ANSI escapes: color tables, `ansi2html`, `termlink`, `printimage.zsh`, an `ansiescapes.md` cheatsheet, and a `colors/` subdir of palette demos |
| `loading-ascii-art/`              | ASCII-art loading banners and a full-width loading-bar script               |
| `prompts/`                        | Extra prompt themes (`prompts/default/prompt_*_setup`) and `more-prompt-ideas.zsh` |
| `templates/`                      | Starter templates: example scripts and a `zsh.gitignore`                    |
| `symbols`                         | A reference collection of Unicode/glyph symbols                             |

## Libraries

Reusable helper libraries live in `zsh/lib/`. They are meant to be `source`d
(directly or by functions/startup files) rather than run standalone.

| Library                | Provides                                                                    |
| ---------------------- | --------------------------------------------------------------------------- |
| `slog.sh`              | POSIX-compatible logging (bash/dash/zsh) to stdout and/or a file            |
| `parseopts`            | Option-parsing helper/`getopts`-style demo for building CLIs                |
| `is_script_sourced`    | Detect whether a script was sourced vs executed directly                    |
| `ostype`               | OS predicates: `islinux`, `isdarwin`, `isfreebsd`, `isopenbsd`, `issolaris`, `isandroid` |
| `zshversion`           | zsh-version predicates (`is4`, `is41`, `is42`, …) for compatibility guards  |
| `zrcautoload`          | `autoload` wrapper used early in startup                                    |
| `zshcompletion`        | Completion-system setup helpers (dedupes `path`/`fpath`, loads modules)     |
| `reload`               | `reload` helper — `exec "${SHELL}"`                                         |
| `motd`                 | `zshlib_motd`: render a `figlet` message-of-the-day banner                  |
| `printcentered` / `print-centered` / `bash-print-centered.sh` | Center text in the terminal width           |
| `printleft` / `printline` / `print-centered` | Text/line layout helpers                                     |
| `listbindings`         | Library backing the keybinding listing                                      |
| `progressbars_lib/`    | Assorted progress-bar / loading-bar implementations                         |
| `pipes/`               | `pipes.sh`/`pipesX.sh`/`rain.sh`/`weave.sh` terminal screensavers           |
| `zshlib_template`      | Template for writing a new sourced library                                  |
| `DEMOPROMPT.zsh`       | Library backing the `DEMOPROMPT` function                                   |

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
