# 🏙 Tokyo Night

A dark and light Neovim theme written in Lua ported from the Visual Studio Code [DampSockTheme](https://github.com/enkia/tokyo-night-vscode-theme) theme. Includes extra themes for Kitty, Alacritty, iTerm and Fish.

## Storm

![image](https://user-images.githubusercontent.com/292349/115295095-3a9e5080-a10e-11eb-9aed-6054488c46ce.png)

## Night

![image](https://user-images.githubusercontent.com/292349/115295327-7afdce80-a10e-11eb-89b3-2591262bf95a.png)

## Day

![image](https://user-images.githubusercontent.com/292349/115996270-78c6c480-a593-11eb-8ed0-7d1400b058f5.png)

## ✨ Features

- supports the latest Neovim 5.0 features like TreeSitter and LSP
- minimal inactive statusline
- vim terminal colors
- darker background for sidebar-like windows
- color configs for [Kitty](https://sw.kovidgoyal.net/kitty/conf.html?highlight=include), [Alacritty](https://github.com/alacritty/alacritty) and [Fish Shell](https://fishshell.com/)
- **lualine** theme

### Plugin Support

- [TreeSitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [LSP Diagnostics](https://neovim.io/doc/user/lsp.html)
- [LSP Trouble](https://github.com/ConnerWill/lsp-trouble.nvim)
- [LSP Saga](https://github.com/glepnir/lspsaga.nvim)
- [Git Signs](https://github.com/lewis6991/gitsigns.nvim)
- [Git Gutter](https://github.com/airblade/vim-gitgutter)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [NvimTree](https://github.com/kyazdani42/nvim-tree.lua)
- [WhichKey](https://github.com/liuchengxu/vim-which-key)
- [Indent Blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [Dashboard](https://github.com/glepnir/dashboard-nvim)
- [BufferLine](https://github.com/akinsho/nvim-bufferline.lua)
- [Lualine](https://github.com/hoob3rt/lualine.nvim)
- [Lightline](https://github.com/itchyny/lightline.vim)
- [Neogit](https://github.com/TimUntersberger/neogit)
- [vim-sneak](https://github.com/justinmk/vim-sneak)
- [Fern](https://github.com/lambdalisue/fern.vim)
- [Barbar](https://github.com/romgrk/barbar.nvim)

## ⚡️ Requirements

- Neovim >= 0.5.0

## 📦 Installation

Install the theme with your preferred package manager:

[vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'ConnerWill/dampsocktheme.nvim', { 'branch': 'main' }
```

[packer](https://github.com/wbthomason/packer.nvim)

```lua
use 'ConnerWill/dampsocktheme.nvim'
```

## 🚀 Usage

Enable the colorscheme:

```vim
" Vim Script
colorscheme dampsocktheme
```

```lua
-- Lua
vim.cmd[[colorscheme dampsocktheme]]
```

To enable the `DampSockTheme` theme for `Lualine`, simply specify it in your lualine settings:

```lua
require('lualine').setup {
  options = {
    -- ... your lualine config
    theme = 'dampsocktheme'
    -- ... your lualine config
  }
}
```

To enable the `dampsocktheme` colorscheme for `Lightline`:

```vim
" Vim Script
let g:lightline = {'colorscheme': 'dampsocktheme'}
```

## ⚙️ Configuration

> ❗️ configuration needs to be set **BEFORE** loading the color scheme with `colorscheme dampsocktheme`

The theme comes in three styles, `storm`, a darker variant `night` and `day`.

The **day** style will be used if:

- `vim.g.dampsocktheme_style == "day"`
- or `vim.o.background == "light"`

| Option                              | Default   | Description                                                                                                                                                     |
| ----------------------------------- | --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| dampsocktheme_style                    | `"storm"` | The theme comes in three styles, `storm`, a darker variant `night` and `day`.                                                                                   |
| dampsocktheme_terminal_colors          | `true`    | Configure the colors used when opening a `:terminal` in Neovim                                                                                                  |
| dampsocktheme_italic_comments          | `true`    | Make comments italic                                                                                                                                            |
| dampsocktheme_italic_keywords          | `true`    | Make keywords italic                                                                                                                                            |
| dampsocktheme_italic_functions         | `false`   | Make functions italic                                                                                                                                           |
| dampsocktheme_italic_variables         | `false`   | Make variables and identifiers italic                                                                                                                           |
| dampsocktheme_transparent              | `false`   | Enable this to disable setting the background color                                                                                                             |
| dampsocktheme_hide_inactive_statusline | `false`   | Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**. |
| dampsocktheme_sidebars                 | `{}`      | Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`                                                      |
| dampsocktheme_transparent_sidebar      | `false`   | Sidebar like windows like `NvimTree` get a transparent background                                                                                               |
| dampsocktheme_dark_sidebar             | `true`    | Sidebar like windows like `NvimTree` get a darker background                                                                                                    |
| dampsocktheme_dark_float               | `true`    | Float windows like the lsp diagnostics windows get a darker background.                                                                                         |
| dampsocktheme_colors                   | `{}`      | You can override specific color groups to use other groups or a hex color                                                                                       |
| dampsocktheme_day_brightness           | `0.3`     | Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors                                                  |
| dampsocktheme_lualine_bold             | `false`   | When `true`, section headers in the lualine theme will be bold                                                                                                  |

```lua
-- Example config in Lua
vim.g.dampsocktheme_style = "night"
vim.g.dampsocktheme_italic_functions = true
vim.g.dampsocktheme_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.dampsocktheme_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
vim.cmd[[colorscheme dampsocktheme]]
```

```vim
" Example config in VimScript
let g:dampsocktheme_style = "night"
let g:dampsocktheme_italic_functions = 1
let g:dampsocktheme_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]

" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:dampsocktheme_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }

" Load the colorscheme
colorscheme dampsocktheme
```

### Making `undercurls` work properly in **Tmux**

To have undercurls show up and in color, add the following to your **Tmux** config file:

```sh
# Undercurl
set -g default-terminal "${TERM}"
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
```

## 🍭 Extras

Extra color configs for **Kitty**, **Alacritty**, **Fish**, **WezTerm** and **iTerm** can be found in [extras](extras/). To use them, refer to their respective documentation.

![image](https://user-images.githubusercontent.com/292349/115395546-d8d6f880-a198-11eb-98fb-a1194787701d.png)

You can easily use the color palette for other plugins inside your Neovim config:

```lua
local colors = require("dampsocktheme.colors").setup({}) -- pass in any of the config options as explained above
local utils = requires("dampsocktheme.util")

aplugin.background = colors.bg_dark
aplugin.my_error = util.brighten(colors.red1, 0.3)
```

## 🔥 Contributing

Pull requests are welcome. For the `extras`, we use a simple template system that can be used to generate themes for the different styles.

How to add a new extra template:

1. create a file like `lua/dampsocktheme/extra/cool-app.lua`
2. add the name and output file extension to the `extras` table in `lua/dampsocktheme/extra/init.lua`
3. in the root directory, run `$ lua lua/dampsocktheme/extra/init.lua` to generate / update extra themes
4. commit the newly created themes under `extra/`
