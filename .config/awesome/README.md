# AwesomeWM

```ocaml
┍────────────────────────────────────────────────────┐
│     ▄▀█ █ █ █ █▀▀ █▀ █▀█ █▀▄▀█ █▀▀ █ █ █ █▀▄▀█     │
│     █▀█ ▀▄▀▄▀ ██▄ ▄█ █▄█ █ ▀ █ ██▄ ▀▄▀▄▀ █ ▀ █     │
├────────────────────────────────────────────────────┤
│░░░▒▒▒▓▓▓███ ＡＷＥＳＯＭＥ ＣＯＮＦＩＧ ███▓▓▓▒▒▒░░│
└────────────────────────────────────────────────────┘
```

> **A single-file AwesomeWM setup: `rc.lua` holds the whole configuration —
> libraries, variables, layouts, the menu/wibar, keybindings, window rules, and
> signals — organised into clearly marked sections with vim fold markers.**

---

## Table of Contents

<!--toc:start-->
- [AwesomeWM](#awesomewm)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Installation](#installation)
  - [Structure](#structure)
  - [Load Order](#load-order)
  - [Variables](#variables)
  - [Layouts](#layouts)
  - [Tags](#tags)
  - [Wibar / Widgets](#wibar--widgets)
  - [Keybindings](#keybindings)
    - [Awesome](#awesome)
    - [Launchers](#launchers)
    - [Tags](#tags-1)
    - [Client / Window](#client--window)
    - [Layout](#layout)
    - [Screen / Monitor](#screen--monitor)
    - [Mouse](#mouse)
  - [Window Rules](#window-rules)
  - [Theme](#theme)
  - [Documentation](#documentation)
<!--toc:end-->

---

## Features

- **Single-file config** — everything lives in `rc.lua`; there is no `themes/`,
  `autostart.sh`, `buttons.lua`, or `hotkeys.lua` split-out.
- **Section folds** — the file is divided into labelled sections
  (`Import Libraries`, `ERRORS`, `Variables`, `THEMES`, `MODKEY`, `Layouts`,
  `START MENU`, `WIDGETS`, `KEY BINDINGS`, `RULES`, `SIGNALS`) with `{{{ … }}}`
  vim fold markers for quick navigation.
- **Super (`Mod4`) as modkey** — all window-management bindings hang off the
  Super key.
- **Moon-phase tags** — nine tags labelled with moon-phase emoji
  (🌚 🌒 🌓 🌔 🌝 🌖 🌗 🌘 🌚).
- **Top wibar** — launcher, taglist, and prompt on the left; tasklist in the
  middle; systray, clock, and layout indicator on the right.
- **Self-documenting bindings** — every `awful.key` carries a `description` and
  `group`, so <kbd>Super</kbd>+<kbd>s</kbd> brings up a complete, grouped
  hotkey cheat-sheet.
- **Launcher shortcuts** — one-key spawns for terminal (kitty), editor (nvim),
  file browser (pcmanfm), and web browsers (Firefox, Tor, lynx), plus Signal.

---

## Installation

> Install on `ArchLinux`

```shell
sudo pacman -S --needed awesome
```

> Install on `Debian`-based distros

```shell
sudo apt install awesome
```

> See <https://awesomewm.org/download> for more installation options.

---

## Structure

AwesomeWM reads its configuration from `rc.lua` in the config directory
(`$XDG_CONFIG_HOME/awesome/rc.lua`). This setup keeps everything in that one
file:

```
.
├── rc.lua        # The entire configuration (read on startup)
├── theme.lua     # Stock "default" theme (reference copy — not loaded by rc.lua)
└── README.md     # This file
```

> **Note:** `rc.lua` actually initialises the **system** xresources theme
> (`beautiful.init(gears.filesystem.get_themes_dir() .. "xresources/theme.lua")`),
> not the local `theme.lua`. The local `theme.lua` is kept as a reference /
> starting point if you want to switch to a custom theme — see
> [Theme](#theme).

---

## Load Order

`rc.lua` is read top-to-bottom on startup. The file is organised into these
labelled sections (each wrapped in `{{{ … }}}` fold markers):

| Section           | Purpose                                                            |
| ----------------- | ----------------------------------------------------------------- |
| `Import Libraries`| `require` gears, awful, wibox, beautiful, naughty, menubar, hotkeys |
| `ERRORS`          | Startup + runtime error handlers (notify via `naughty`)           |
| `Variables`       | Default applications (terminal, editor, browsers, …)              |
| `THEMES`          | `beautiful.init(...)` — loads the xresources theme                |
| `MODKEY`          | Sets `modkey = "Mod4"` (Super)                                     |
| `Layouts`         | The enabled `awful.layout.layouts` list                           |
| `START MENU`      | Awesome menu, launcher widget, menubar terminal                   |
| `WIDGETS`         | Clock, taglist/tasklist buttons, per-screen wibar setup           |
| `KEY BINDINGS`    | Global keys, client keys, tag keys, mouse bindings                |
| `RULES`           | `awful.rules.rules` — per-client placement/titlebar rules         |
| `SIGNALS`         | `manage` + `request::titlebars` client signal handlers            |

---

## Variables

Default applications are defined near the top of `rc.lua` and referenced
throughout the keybindings and menu:

| Variable            | Value                      | Purpose                     |
| ------------------- | -------------------------- | --------------------------- |
| `terminal`          | `kitty`                    | Terminal emulator           |
| `editor`            | `$EDITOR` or `nvim`        | Text editor                 |
| `editor_cmd`        | `kitty -e <editor>`        | Editor in a terminal        |
| `texteditor`        | `nvim`                     | Text editor                 |
| `filebrowser`       | `pcmanfm`                  | File explorer               |
| `webbrowser`        | `firefox`                  | Web browser                 |
| `torbrowser`        | `tor-browser`              | Tor browser                 |
| `cliwebbrowser`     | `lynx`                     | CLI web browser             |
| `cliwebbrowser_cmd` | `kitty -T lynx -e lynx`    | CLI browser in a terminal   |
| `SignalMessager`    | `signal-desktop`           | Messenger                   |
| `modkey`            | `Mod4` (Super)             | Modifier key for bindings   |

---

## Layouts

`awful.layout.layouts` enables these layouts, cycled with
<kbd>Super</kbd>+<kbd>Space</kbd> (and <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>Space</kbd> to go back):

| Order | Layout                       |
| ----- | ---------------------------- |
| 1     | `tile.left` (default)        |
| 2     | `tile`                       |
| 3     | `spiral.dwindle`             |
| 4     | `fair`                       |
| 5     | `tile.bottom`                |

---

## Tags

Each screen gets nine tags, labelled with moon-phase emoji, starting on the
first layout (`tile.left`):

```
🌚  🌒  🌓  🌔  🌝  🌖  🌗  🌘  🌚
 1   2   3   4   5   6   7   8   9
```

---

## Wibar / Widgets

A single wibar is created per screen at the **top** of the display:

| Position | Widgets                                             |
| -------- | --------------------------------------------------- |
| Left     | Launcher, taglist, prompt box                       |
| Middle   | Tasklist (clients on the current tags)              |
| Right    | Systray, clock, layout indicator                    |

The clock uses the format `%Y-%m-%d %I:%M:%S %p` and refreshes every second.
The keyboard-layout widget exists but is commented out of the wibar.

---

## Keybindings

All bindings use `modkey` = <kbd>Super</kbd> (`Mod4`). Every binding carries a
`description`/`group`, so you can browse them in-WM with the hotkey popup.

> Press <kbd>Super</kbd>+<kbd>s</kbd> to show the full, grouped keybinding
> cheat-sheet.

### Awesome

| Key                                                  | Action                          |
| ---------------------------------------------------- | ------------------------------- |
| <kbd>Super</kbd>+<kbd>s</kbd>                        | Invoke the help/hotkey menu     |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>Ctrl</kbd>+<kbd>r</kbd> | Reload Awesome         |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>Ctrl</kbd>+<kbd>q</kbd> | Quit Awesome           |

### Launchers

| Key                                                  | Action                          |
| ---------------------------------------------------- | ------------------------------- |
| <kbd>Super</kbd>+<kbd>Return</kbd>                  | Launch terminal (kitty)         |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>t</kbd>      | Launch terminal                 |
| <kbd>Super</kbd>+<kbd>Ctrl</kbd>+<kbd>t</kbd>       | Launch terminal                 |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>e</kbd>      | Launch text editor              |
| <kbd>Super</kbd>+<kbd>e</kbd>                       | Launch file explorer (pcmanfm)  |
| <kbd>Super</kbd>+<kbd>b</kbd>                       | Launch web browser (Firefox)    |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>b</kbd>      | Launch CLI web browser (lynx)   |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>Ctrl</kbd>+<kbd>b</kbd> | Launch Tor browser     |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>Ctrl</kbd>+<kbd>s</kbd> | Launch Signal          |
| <kbd>Super</kbd>+<kbd>r</kbd>                       | Run prompt                      |
| <kbd>Super</kbd>+<kbd>p</kbd>                       | Menubar (application launcher)  |

### Tags

| Key                                                  | Action                          |
| ---------------------------------------------------- | ------------------------------- |
| <kbd>Super</kbd>+<kbd>Left</kbd>                    | Previous tag                    |
| <kbd>Super</kbd>+<kbd>Right</kbd>                   | Next tag                        |
| <kbd>Super</kbd>+<kbd>Escape</kbd>                  | Last-viewed tag                 |
| <kbd>Super</kbd>+<kbd>1..9</kbd>                    | View tag _N_                    |
| <kbd>Super</kbd>+<kbd>Ctrl</kbd>+<kbd>1..9</kbd>    | Toggle tag _N_ into the view    |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>1..9</kbd>   | Move focused client to tag _N_  |
| <kbd>Super</kbd>+<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>1..9</kbd> | Toggle focused client on tag _N_ |

### Client / Window

| Key                                                  | Action                          |
| ---------------------------------------------------- | ------------------------------- |
| <kbd>Super</kbd>+<kbd>j</kbd>                       | Focus next client by index      |
| <kbd>Super</kbd>+<kbd>k</kbd>                       | Focus previous client by index  |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>j</kbd>      | Swap with next client           |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>k</kbd>      | Swap with previous client       |
| <kbd>Super</kbd>+<kbd>u</kbd>                       | Jump to urgent client           |
| <kbd>Super</kbd>+<kbd>Tab</kbd>                     | Focus previously focused client |
| <kbd>Super</kbd>+<kbd>Ctrl</kbd>+<kbd>Return</kbd>  | Promote client to master        |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>c</kbd>      | Close client                    |
| <kbd>Super</kbd>+<kbd>n</kbd>                       | Minimize client                 |
| <kbd>Super</kbd>+<kbd>Ctrl</kbd>+<kbd>n</kbd>       | Restore (unminimize) a client   |
| <kbd>Super</kbd>+<kbd>m</kbd>                       | (Un)maximize client             |
| <kbd>Super</kbd>+<kbd>Ctrl</kbd>+<kbd>m</kbd>       | (Un)maximize vertically         |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>m</kbd>      | (Un)maximize horizontally       |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>f</kbd>      | Toggle fullscreen               |
| <kbd>Super</kbd>+<kbd>Ctrl</kbd>+<kbd>Space</kbd>   | Toggle floating                 |

### Layout

| Key                                                  | Action                          |
| ---------------------------------------------------- | ------------------------------- |
| <kbd>Super</kbd>+<kbd>Space</kbd>                   | Next layout                     |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>Space</kbd>  | Previous layout                 |
| <kbd>Super</kbd>+<kbd>l</kbd>                       | Increase master width factor    |
| <kbd>Super</kbd>+<kbd>h</kbd>                       | Decrease master width factor    |

### Screen / Monitor

| Key                                                  | Action                          |
| ---------------------------------------------------- | ------------------------------- |
| <kbd>Super</kbd>+<kbd>Ctrl</kbd>+<kbd>j</kbd>       | Focus next monitor              |
| <kbd>Super</kbd>+<kbd>Ctrl</kbd>+<kbd>k</kbd>       | Focus previous monitor          |
| <kbd>Super</kbd>+<kbd>[</kbd>                       | Focus next monitor              |
| <kbd>Super</kbd>+<kbd>]</kbd>                       | Focus previous monitor          |
| <kbd>Super</kbd>+<kbd>o</kbd>                       | Move focused client to other screen |
| <kbd>Super</kbd>+<kbd>Shift</kbd>+<kbd>[</kbd> / <kbd>]</kbd> | Move focused client to other screen |

### Mouse

| Button                                | Action                                   |
| ------------------------------------- | ---------------------------------------- |
| <kbd>Click</kbd>                      | Focus / activate the client under cursor |
| <kbd>Super</kbd>+<kbd>Left-drag</kbd> | Move the client                          |
| <kbd>Super</kbd>+<kbd>Right-drag</kbd>| Resize the client                        |

> Taglist and layout-indicator widgets also respond to clicks and the scroll
> wheel (switch/toggle tags, cycle layouts).

---

## Window Rules

Rules in `awful.rules.rules` apply properties to clients as they appear:

- **All clients** get a border, focus filtering, the global client keys/buttons,
  no-overlap + no-offscreen placement, and the preferred screen.
- **Floating/utility instances** (`DTA`, `copyq`, `pinentry`, `Tor Browser`,
  `Event Tester`, and dialog roles like `AlarmWindow`, `ConfigManager`,
  `pop-up`) are matched as a group (titlebars disabled).
- **Titlebars** are disabled for `normal` and `dialog` window types.
- **Firefox** is always mapped to tag **"9"** on **screen 1**.

---

## Theme

`rc.lua` loads the system xresources theme:

```lua
beautiful.init(gears.filesystem.get_themes_dir() .. "xresources/theme.lua")
```

The local `theme.lua` is the stock AwesomeWM **default** theme kept as a
reference. It defines colours (`bg_*`/`fg_*`/`border_*`), fonts, gaps, taglist
squares, titlebar button images, layout icons, and the generated Awesome icon.
To use it instead of the xresources theme, point `beautiful.init` at it:

```lua
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")
```

---

## Documentation

- [AwesomeWM Homepage](https://awesomewm.org)
- [AwesomeWM API documentation](https://awesomewm.org/doc/api)
- Press <kbd>Super</kbd>+<kbd>s</kbd> in-WM for the live keybinding cheat-sheet.
- `man awesome` — also available from the Awesome menu ("Awesome Docs").
