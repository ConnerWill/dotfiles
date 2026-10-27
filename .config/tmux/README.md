# tmux

<div align="justify">
 <div align="center">

```ocaml
┍────────────────────────────────────────────────┐
│░░░░░░░░░░░░░░░░░▀█▀░█▄█░█░█░█░█░░░░░░░░░░░░░░░░│
│░░░░░░░░░░░░░░░░░░█░░█░█░█░█░▄▀▄░░░░░░░░░░░░░░░░│
│░░░░░░░░░░░░░░░░░░▀░░▀░▀░▀▀▀░▀░▀░░░░░░░░░░░░░░░░│
├────────────────────────────────────────────────┤
 ░░░░▒▒▒▓▓▓███ ＴＭＵＸ ＣＯＮＦＩＧ ███▓▓▓▒▒▒░░░│
└────────────────────────────────────────────────┘
```

> **A modular tmux configuration**

 </div>
</div>

---

## Table of Contents

<!--toc:start-->
- [tmux](#tmux)
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
    - [Start / Attach](#start-attach)
    - [Reload the Config](#reload-the-config)
    - [Inspect Settings](#inspect-settings)
    - [Test Safely](#test-safely)
<!--toc:end-->

---

## Features

- **Single-file config** — everything lives in one `tmux.conf`, organized into
  clearly numbered sections (base, variables, options, keybindings, theme,
  plugin settings, plugin list, overrides, TPM bootstrap) that load top to
  bottom. No `source-file`, no glob, no load-stage indirection.
- **Plugins declared in order** — the `@plugin` list sits near the bottom so
  plugin-ecosystem tools (TPM, tmux-menus) find it where they expect, and the
  TPM bootstrap runs last.
- **Correct plugin-config ordering** — plugin `@options` have a dedicated
  section *above* the `run tpm` line (where they take effect), and a
  post-plugin overrides section is provided for settings that must beat a
  plugin default. See [Plugins](#plugins).
- **TokyoNight theme** — the [TokyoNight](https://github.com/folke/tokyonight.nvim)
  (night) status/pane colors are inlined in the theme section.
- **TPM plugin management** — installed/updated with
  [TPM](https://github.com/tmux-plugins/tpm).
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
├── tmux.conf     # The entire configuration (see section order below)
├── README.md     # This file
└── plugins/      # TPM-managed plugins (installed via `prefix + I`)
    └── tpm/      # TPM itself (installed via git clone)
```

> The whole config is a single `tmux.conf`. There is no `init/` directory —
> everything that used to be split across numbered stage files is now inlined
> as numbered *sections* within `tmux.conf`, loaded top to bottom.

---

## Load Order

`tmux.conf` is read top to bottom. Sections are ordered so that later settings
can build on (or override) earlier ones, and so plugins initialize last:

| #  | Section                 | Purpose                                             |
| -- | ----------------------- | --------------------------------------------------- |
| 1  | Base / server options   | terminal, truecolor, escape-time, history, indexes  |
| 2  | Variables & plugin path | `@`-options, `TMUX_PLUGIN_MANAGER_PATH`             |
| 3  | Session & window options| mouse, vi keys, titles, activity, resize            |
| 4  | Keybindings             | `prefix2` + splits, pane nav/resize, reload, copy-mode |
| 5  | Theme / colors          | TokyoNight (night) status/pane styling              |
| 6  | Plugin settings         | plugin `@options` — **must be above `run tpm`**     |
| 7  | Plugin list             | `set -g @plugin '...'` declarations                 |
| 8  | Local overrides         | machine-specific / post-plugin tweaks               |
| 9  | TPM bootstrap           | `run tpm` (guarded `run-shell -b`) — runs last      |

TPM runs last (async, via `run-shell -b`), which lets each plugin apply its own
settings/bindings on top of the base config.

---

## Options

Options are grouped by the `tmux.conf` section they live in.

**Section 1 — base / server:**

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

**Section 2 — variables / plugin path:**

| Option                        | Value                        | Effect                        |
| ----------------------------- | ---------------------------- | ----------------------------- |
| `TMUXDOTDIR`                  | `$HOME/.config/tmux`         | Base dir (used by reload bind) |
| `TMUX_PLUGIN_MANAGER_PATH`    | `$HOME/.config/tmux/plugins/` | Where TPM installs plugins    |

**Section 3 — session / window behavior:**

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
the keybindings section of `tmux.conf` and are additive — they don't clobber
common defaults.

### Prefix

| Key                         | Action                         |
| --------------------------- | ------------------------------ |
| <kbd>Ctrl</kbd>+<kbd>b</kbd> | Default prefix                 |
| <kbd>Ctrl</kbd>+<kbd>a</kbd> | Secondary prefix (`prefix2`)   |

Either prefix works for everything below.

### Custom Bindings

Defined in the keybindings section of `tmux.conf`:

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
| `prefix` + <kbd>\\</kbd>    | `tmux-menus`     | Open the main popup menu                 |
| `prefix` + <kbd>Enter</kbd> | `tmux-menus`     | Open the main popup menu (secondary default, if unbound) |
| `prefix` + <kbd>Space</kbd> | `tmux-which-key` | Open the which-key popup menu            |
| <kbd>Ctrl</kbd>+<kbd>Space</kbd> | `tmux-which-key` | Open the which-key popup menu (root key) |

> `tmux-autoreload` has no keybinding — it watches `tmux.conf` and reloads
> automatically on save. `tmux-sensible` only applies sane default options.
> `retmux` provides session save/restore commands.

> Note: `prefix + r` and `tmux-autoreload` both reload the config; the plugin
> does it automatically on save, the binding does it on demand.

---

## Theme

Active theme is **TokyoNight** (`night` style), inlined in the theme section of
[`tmux.conf`](tmux.conf) (upstream:
[tokyonight.nvim](https://github.com/folke/tokyonight.nvim) `extras/tmux`).

It styles the status bar, window list, pane borders, and messages with the
TokyoNight palette (blue `#7aa2f7` accents on a dark `#1f2335` bar). The status
line shows the session name on the left and, on the right, a mode indicator
(`tmux-mode-indicator`), `prefix_highlight`, a CPU indicator
(`tmux-cpu`: `CPU: <pct>` with a load-based background color), date/time,
and hostname on the right.

To switch themes, replace the lines in the theme section with another theme's
tmux snippet.

---

## Plugins

Plugins are declared at the bottom of
[`tmux.conf`](tmux.conf) and managed by
[TPM](https://github.com/tmux-plugins/tpm).

> **Why the plugin list lives in `tmux.conf`.** Plugin-ecosystem tools scan
> `tmux.conf` directly for `@plugin` declarations: TPM (`prefix + I`) and
> **tmux-menus** both expect the list there, and tmux-menus does not follow
> `source-file` into other files at all. Keeping the list in `tmux.conf` — the
> conventional TPM layout — makes every such tool work with no per-tool
> workarounds.

> **Customizing plugins — ordering matters.** A plugin reads its `@options`
> when TPM sources it (the `run tpm` line at the very bottom). So:
>
> - Set plugin `@options` in the **"Plugin settings" section (6)**, which is
>   *above* `run tpm`. Setting them after `run tpm` has no effect.
> - To override a keybinding or style a plugin sets itself, put the override
>   *after* the `run tpm` line (or use a tmux hook), since the plugin applies
>   those last.

### Installing TPM

TPM is not vendored — clone it into the config's `plugins/` dir:

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

To add a plugin, add a line to the plugin list in `tmux.conf` and press
`prefix + I`:

```tmux
set -g @plugin 'owner/plugin-name'
```

> Headless install (e.g. from a provisioning script) without pressing
> `prefix + I`:
>
> ```bash
> ~/.config/tmux/plugins/tpm/bin/install_plugins
> ```

### Enabled Plugins

| Plugin            | Description                                                      |
| ----------------- | ---------------------------------------------------------------- |
| `tpm`             | The Tmux Plugin Manager itself.                                  |
| `tmux-sensible`   | A small set of sane, widely-agreed default options.              |
| `tmux-sidebar`    | Toggleable directory-tree sidebar for the current pane's path.   |
| `tmux-autoreload` | Watches `tmux.conf` and reloads it automatically on save.        |
| `tmux-logging`    | Toggle pane logging, save visible output, or capture scrollback. |
| `retmux`          | Save and restore tmux sessions/layouts.                          |
| `tmux-menus`      | Popup menus for managing panes, windows, sessions, and settings. |
| `tmux-which-key`  | Popup key table showing available bindings and actions.          |
| `tmux-cpu`        | CPU/RAM status-bar indicators (`#{cpu_percentage}`, `#{cpu_icon}`, …). |
| `tmux-mode-indicator` | Status-bar segment showing the current mode (`#{tmux_mode_indicator}`). |

- `tpm` — <https://github.com/tmux-plugins/tpm>
- `tmux-sensible` — <https://github.com/tmux-plugins/tmux-sensible>
- `tmux-sidebar` — <https://github.com/tmux-plugins/tmux-sidebar>
- `tmux-autoreload` — <https://github.com/b0o/tmux-autoreload>
- `tmux-logging` — <https://github.com/tmux-plugins/tmux-logging>
- `retmux` — <https://github.com/sk1418/retmux>
- `tmux-menus` — <https://github.com/jaclu/tmux-menus>
- `tmux-which-key` — <https://github.com/alexwforsythe/tmux-which-key>
- `tmux-cpu` — <https://github.com/tmux-plugins/tmux-cpu>
- `tmux-mode-indicator` — <https://github.com/MunifTanjim/tmux-mode-indicator>

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
