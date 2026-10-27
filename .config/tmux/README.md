# tmux

<div align="justify">
 <div align="center">

```ocaml
 ▄▄▄▄▄▄▄▄▄▄▄  ▄▄       ▄▄  ▄         ▄  ▄       ▄
▐░░░░░░░░░░░▌▐░░▌     ▐░░▌▐░▌       ▐░▌▐░▌     ▐░▌
 ▀▀▀▀█░█▀▀▀▀ ▐░▌░▌   ▐░▐░▌▐░▌       ▐░▌ ▐░▌   ▐░▌
     ▐░▌     ▐░▌▐░▌ ▐░▌▐░▌▐░▌       ▐░▌  ▐░▌ ▐░▌
     ▐░▌     ▐░▌ ▐░▐░▌ ▐░▌▐░▌       ▐░▌   ▐░▐░▌
     ▐░▌     ▐░▌  ▐░▌  ▐░▌▐░▌       ▐░▌    ▐░▌
     ▐░▌     ▐░▌   ▀   ▐░▌▐░▌       ▐░▌   ▐░▌░▌
     ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌  ▐░▌ ▐░▌
     ▐░▌     ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌ ▐░▌   ▐░▌
     ▐░▌     ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌     ▐░▌
      ▀       ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀       ▀
```

> **A modular tmux configuration**

 </div>
</div>

---

## Table of Contents

<!--toc:start-->
- [🖥️ tmux](#️-tmux)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Structure](#structure)
  - [Load Order](#load-order)
  - [Options](#options)
  - [Keybindings](#keybindings)
    - [Prefix](#prefix)
    - [Custom Bindings](#custom-bindings)
    - [Copy Mode](#copy-mode)
    - [Mouse](#mouse)
    - [Plugin Keybindings](#plugin-keybindings)
  - [Theme](#theme)
  - [Plugins](#plugins)
    - [Installing TPM](#installing-tpm)
    - [Managing Plugins](#managing-plugins)
    - [Enabled Plugins](#enabled-plugins)
  - [Usage](#usage)
    - [Start / Attach](#start--attach)
    - [Reload the Config](#reload-the-config)
    - [Inspect Settings](#inspect-settings)
    - [Test Safely](#test-safely)
<!--toc:end-->

---

## Features

- **Autoloaded modular init** — `tmux.conf` is a tiny entry point that
  autoloads **every** numbered `init/[0-9]*.conf` stage in order with a single
  glob. Drop in a new numbered file and it loads automatically — no edit to
  `tmux.conf`. Each stage owns one concern (base, variables, options,
  keybindings, theme, plugins, overrides).
- **Portable paths** — a `TMUXDOTDIR` user option is set at the top and every
  `source-file` / plugin path is resolved with `source-file -F '#{TMUXDOTDIR}/...'`,
  so nothing is hard-coded to `$HOME`.
- **Split theme** — colors live in their own [TokyoNight](https://github.com/folke/tokyonight.nvim)
  theme file under `init/themes/`, loaded via `init/40_themes-colors.conf`.
- **TPM plugin management** — plugins are declared in `init/50_plugins-init.conf`
  and installed/updated with [TPM](https://github.com/tmux-plugins/tpm).
- **Safe plugin bootstrap** — TPM is only run if it is actually installed
  (guarded with `if-shell` + `run-shell -b`), so a fresh machine without TPM
  loads cleanly instead of erroring.
- **Secondary prefix** — `C-a` is configured alongside the default `C-b`.
- **vi everywhere** — vi-style keys in copy mode and the status line.
- **Mouse support** — click to select panes/windows, drag borders, scroll.

---

## Structure

```
tmux/
├── tmux.conf                        # Entry point: sets TMUXDOTDIR, autoloads init/[0-9]*.conf
├── init/
│   ├── 00_tmux_init.conf            # Base / server options (terminal, history, indexes)
│   ├── 10_variables.conf            # User @-options & TPM plugin path
│   ├── 20_options.conf              # Session & window options (mouse, vi, titles, activity)
│   ├── 30_keybindings.conf          # prefix2 + splits, pane nav/resize, reload, copy-mode
│   ├── 40_themes-colors.conf        # Sources the active theme
│   ├── 50_plugins-init.conf         # Plugin list + TPM bootstrap
│   ├── 90_overrides.conf            # Local last-wins overrides (machine-specific tweaks)
│   ├── 99_tmux_end_init.conf        # End-of-init notes (no execution)
│   ├── example_tmux.conf            # Reference / example snippets (NOT loaded)
│   └── themes/
│       └── tokyonight_night.tmux    # TokyoNight (night) status/pane colors
└── plugins/
    └── tpm/                         # TPM (installed via git clone)
```

> `tmux.conf` autoloads **every** numbered stage with a single glob:
> `source-file -q -F '#{TMUXDOTDIR}/init/[0-9]*.conf'`. The `[0-9]*` pattern
> loads `00_` … `99_` in sorted order and deliberately skips
> `example_tmux.conf`. To add a new stage, drop in a numbered `*.conf` file —
> no edit to `tmux.conf` required.

---

## Load Order

`tmux.conf` sets `TMUXDOTDIR`, then autoloads the init stages in numeric order
via a single glob. Each stage owns one concern:

| Stage                        | Purpose                                              |
| ---------------------------- | ---------------------------------------------------- |
| `tmux.conf`                  | Set `TMUXDOTDIR`, then `source-file` the glob        |
| `init/00_tmux_init.conf`     | Base/server options: terminal, truecolor, history, indexes |
| `init/10_variables.conf`     | User `@`-options and the TPM plugin path             |
| `init/20_options.conf`       | Session/window options: mouse, vi keys, titles, activity |
| `init/30_keybindings.conf`   | `prefix2` + splits, pane nav/resize, reload, copy-mode |
| `init/40_themes-colors.conf` | Sources the active theme under `init/themes/`        |
| `init/50_plugins-init.conf`  | Declares `@plugin`s, then bootstraps TPM             |
| `init/90_overrides.conf`     | Local last-wins overrides                            |
| `init/99_tmux_end_init.conf` | End-of-init notes (no execution)                     |

TPM runs last (async, via `run-shell -b`), which lets each plugin apply its own
settings/bindings on top of the base config. `90_overrides.conf` is the place
for anything that must win over a plugin or theme default.

---

## Options

Options are grouped by stage file.

**`00_tmux_init.conf`** — base / server:

| Option                | Value                | Effect                                      |
| --------------------- | -------------------- | ------------------------------------------- |
| `default-terminal`    | `tmux-256color`      | 256-color terminal type                     |
| `terminal-overrides`  | `…:Tc`               | Truecolor (24-bit) passthrough              |
| `escape-time`         | `10`                 | No lag after Escape (vi mode / Neovim)      |
| `history-limit`       | `50000`              | Scrollback buffer size                      |
| `set-clipboard`       | `on`                 | Apps can set the clipboard via OSC 52       |
| `focus-events`        | `on`                 | Report pane focus to editors                |
| `base-index`          | `1`                  | Windows start at 1                          |
| `pane-base-index`     | `1`                  | Panes start at 1                            |

**`10_variables.conf`** — variables / plugin path:

| Option                        | Value                        | Effect                        |
| ----------------------------- | ---------------------------- | ----------------------------- |
| `TMUXDOTDIR`                  | `$HOME/.config/tmux`         | Base dir (set in `tmux.conf`) |
| `TMUX_PLUGIN_MANAGER_PATH`    | `$HOME/.config/tmux/plugins/` | Where TPM installs plugins    |

**`20_options.conf`** — session / window behavior:

| Option                        | Value       | Effect                                       |
| ----------------------------- | ----------- | -------------------------------------------- |
| `mouse`                       | `on`        | Mouse selection, resizing, scrolling          |
| `renumber-windows`            | `on`        | Re-number windows when one closes             |
| `set-titles`                  | `on`        | Set the terminal/window title                 |
| `silence-action`              | `none`      | No action on silence in monitored windows     |
| `status-keys` / `mode-keys`   | `vi`        | vi keys on the command line and in copy mode  |
| `monitor-activity`            | `on`        | Flag activity in other windows                |
| `visual-activity`             | `off`       | …but don't interrupt with a message           |
| `aggressive-resize`           | `on`        | Size windows to the smallest viewing client   |
| `display-panes-colour`        | `#0599ff`   | Pane number color (`prefix + q`)              |
| `display-panes-active-colour` | `#3aff00`   | Active pane number color                       |

> Visual status/message/pane *styling* is owned entirely by the theme
> (`40_themes-colors.conf`), not by the option stages. See [Theme](#theme).

---

## Keybindings

The default prefix <kbd>Ctrl</kbd>+<kbd>b</kbd> is kept, with
<kbd>Ctrl</kbd>+<kbd>a</kbd> added as a second prefix. Custom bindings live in
`init/30_keybindings.conf` and are additive — they don't clobber common
defaults.

### Prefix

| Key                         | Action                         |
| --------------------------- | ------------------------------ |
| <kbd>Ctrl</kbd>+<kbd>b</kbd> | Default prefix                 |
| <kbd>Ctrl</kbd>+<kbd>a</kbd> | Secondary prefix (`prefix2`)   |

Either prefix works for everything below.

### Custom Bindings

Defined in `init/30_keybindings.conf`:

| Key                          | Action                                          |
| ---------------------------- | ----------------------------------------------- |
| `prefix` + <kbd>r</kbd>      | Reload `tmux.conf` (shows a confirmation message) |
| `prefix` + <kbd>\|</kbd>     | Split pane vertically, keep current path         |
| `prefix` + <kbd>-</kbd>      | Split pane horizontally, keep current path       |
| `prefix` + <kbd>c</kbd>      | New window in the current path                   |
| `prefix` + <kbd>h</kbd>/<kbd>j</kbd>/<kbd>k</kbd>/<kbd>l</kbd> | Select pane left/down/up/right |
| `prefix` + <kbd>H</kbd>/<kbd>J</kbd>/<kbd>K</kbd>/<kbd>L</kbd> | Resize pane (repeatable, hold key) |
| <kbd>Alt</kbd>+<kbd>1</kbd>…<kbd>5</kbd> | Jump to window 1–5 (no prefix needed)  |

> `H/J/K/L` are repeatable: after the prefix you can keep tapping them to resize
> without re-pressing the prefix.

### Copy Mode

`mode-keys vi` enables vi-style copy mode:

| Key                         | Action                         |
| --------------------------- | ------------------------------ |
| `prefix` + <kbd>[</kbd>     | Enter copy mode                |
| <kbd>v</kbd>                | Begin selection                |
| <kbd>y</kbd>                | Yank selection and exit        |
| <kbd>h</kbd>/<kbd>j</kbd>/<kbd>k</kbd>/<kbd>l</kbd> | Move cursor     |
| <kbd>/</kbd>                | Search                         |

`status-keys vi` likewise gives vi editing on the command prompt.

### Mouse

With `mouse on`:

| Action                    | Result                                |
| ------------------------- | ------------------------------------- |
| Click pane                | Select pane                           |
| Click window name         | Select window                         |
| Drag pane border          | Resize pane                           |
| Scroll wheel              | Enter copy mode / scroll back         |
| Drag selection            | Begin copy-mode selection             |

### Plugin Keybindings

Provided by enabled plugins (all under the prefix). See each plugin's upstream
for the full set:

| Key                         | Plugin           | Action                                   |
| --------------------------- | ---------------- | ---------------------------------------- |
| `prefix` + <kbd>I</kbd>     | `tpm`            | Install declared plugins                 |
| `prefix` + <kbd>U</kbd>     | `tpm`            | Update plugins                           |
| `prefix` + <kbd>Alt</kbd>+<kbd>u</kbd> | `tpm` | Remove plugins not in the list           |
| `prefix` + <kbd>Tab</kbd>   | `tmux-sidebar`   | Toggle the directory-tree sidebar        |
| `prefix` + <kbd>Backspace</kbd> | `tmux-sidebar` | Toggle sidebar and move focus into it  |
| `prefix` + <kbd>Shift</kbd>+<kbd>P</kbd> | `tmux-logging` | Toggle logging of the pane to a file |
| `prefix` + <kbd>Alt</kbd>+<kbd>p</kbd> | `tmux-logging` | Save the visible pane history       |
| `prefix` + <kbd>Alt</kbd>+<kbd>Shift</kbd>+<kbd>p</kbd> | `tmux-logging` | Save the full scrollback       |

> `tmux-autoreload` has no keybinding — it watches `tmux.conf` and reloads
> automatically on save. `tmux-sensible` only applies sane default options.
> `retmux` provides session save/restore commands.

> Note: `prefix + r` and `tmux-autoreload` both reload the config; the plugin
> does it automatically on save, the binding does it on demand.

---

## Theme

Active theme is **TokyoNight** (`night` style), in
[`init/themes/tokyonight_night.tmux`](init/themes/tokyonight_night.tmux) and
loaded by `init/40_themes-colors.conf`.

It styles the status bar, window list, pane borders, and messages with the
TokyoNight palette (blue `#7aa2f7` accents on a dark `#1f2335` bar). The status
line shows the session name on the left and `prefix_highlight`, date/time, and
hostname on the right.

To switch themes, drop another `*.tmux` file into `init/themes/` and point the
`source-file` line in `init/40_themes-colors.conf` at it.

---

## Plugins

Plugins are declared in
[`init/50_plugins-init.conf`](init/50_plugins-init.conf) and managed by
[TPM](https://github.com/tmux-plugins/tpm).

### Installing TPM

TPM is not vendored — clone it into `$TMUXDOTDIR/plugins/tpm`:

```bash
git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
```

The config only runs TPM if that path is executable, so it is safe to load the
config before TPM is installed.

### Managing Plugins

From inside tmux (either prefix works):

```
prefix + I      # install plugins declared with set -g @plugin '...'
prefix + U      # update installed plugins
prefix + Alt+u  # uninstall plugins no longer in the list
```

To add a plugin, add a line to `init/50_plugins-init.conf` and press
`prefix + I`:

```tmux
set -g @plugin 'owner/plugin-name'
```

### Enabled Plugins

| Plugin            | Description                                                      |
| ----------------- | ---------------------------------------------------------------- |
| `tpm`             | The Tmux Plugin Manager itself.                                  |
| `tmux-sensible`   | A small set of sane, widely-agreed default options.              |
| `tmux-sidebar`    | Toggleable directory-tree sidebar for the current pane's path.   |
| `tmux-autoreload` | Watches `tmux.conf` and reloads it automatically on save.        |
| `tmux-logging`    | Toggle pane logging, save visible output, or capture scrollback. |
| `retmux`          | Save and restore tmux sessions/layouts.                          |

- `tpm` — <https://github.com/tmux-plugins/tpm>
- `tmux-sensible` — <https://github.com/tmux-plugins/tmux-sensible>
- `tmux-sidebar` — <https://github.com/tmux-plugins/tmux-sidebar>
- `tmux-autoreload` — <https://github.com/b0o/tmux-autoreload>
- `tmux-logging` — <https://github.com/tmux-plugins/tmux-logging>
- `retmux` — <https://github.com/sk1418/retmux>

---

## Usage

### Start / Attach

```bash
tmux                      # start a new session (loads ~/.config/tmux/tmux.conf)
tmux new -s work          # start a named session
tmux attach -t work       # attach to an existing session
tmux ls                   # list sessions
```

> tmux finds this config automatically because it lives at
> `$XDG_CONFIG_HOME/tmux/tmux.conf` (`~/.config/tmux/tmux.conf`).

### Reload the Config

From inside tmux, the quickest way is the binding:

```
prefix + r        # reload tmux.conf (shows a "tmux.conf reloaded" message)
```

Or manually via the command prompt:

```
prefix + :  →  source-file ~/.config/tmux/tmux.conf
```

With `tmux-autoreload` installed, saving `tmux.conf` reloads it for you too.

### Inspect Settings

```
prefix + :  →  display-message -p 'TMUXDOTDIR=#{TMUXDOTDIR}'
prefix + :  →  display-message -p 'status=#{status-style}'
```

### Test Safely

Load the config on a throwaway socket so it never touches your real sessions:

```bash
# Parse only — report syntax errors without executing
tmux -L test source-file -n ~/.config/tmux/tmux.conf

# Full load on an isolated server, then tear it down
tmux -L test new-session -d
tmux -L test source-file ~/.config/tmux/tmux.conf
tmux -L test kill-server
```
