# 💤 Neovim

> My [LazyVim](https://github.com/LazyVim/LazyVim)-based Neovim configuration

Built on the [LazyVim](https://github.com/LazyVim/LazyVim) starter. Refer to the
[LazyVim documentation](https://lazyvim.github.io/installation) to get started.

---

## Features

- **LazyVim base** — sensible defaults with [`lazy.nvim`](https://github.com/folke/lazy.nvim)
  plugin management (`lazy-lock.json` pins versions).
- **LSP & tooling** — [`nvim-lspconfig`](https://github.com/neovim/nvim-lspconfig)
  with [`mason.nvim`](https://github.com/mason-org/mason.nvim) for automatic
  server/tool installation.
- **Formatting** — [`conform.nvim`](https://github.com/stevearc/conform.nvim)
  for on-save formatting.
- **Syntax** — [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)
  for highlighting and structural editing.
- **Completion & snippets** — [`LuaSnip`](https://github.com/L3MON4D3/LuaSnip)
  with custom snippets.
- **Fuzzy finding** — [`snacks.nvim`](https://github.com/folke/snacks.nvim) and
  [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) with
  [`telescope-undo`](https://github.com/debugloop/telescope-undo.nvim) and
  [`project.nvim`](https://github.com/ahmedkhalf/project.nvim).
- **File explorer** — [`neo-tree.nvim`](https://github.com/nvim-neo-tree/neo-tree.nvim).
- **UI** — [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim)
  statusline, [`noice.nvim`](https://github.com/folke/noice.nvim) command UI, and
  [`nvim-colorizer.lua`](https://github.com/norcalli/nvim-colorizer.lua) inline
  color previews.
- **Diagnostics & git** — [`trouble.nvim`](https://github.com/folke/trouble.nvim)
  and [`diffview.nvim`](https://github.com/sindrets/diffview.nvim).
- **Editing helpers** — [`nvim-surround`](https://github.com/kylechui/nvim-surround),
  [`mini.align`](https://github.com/nvim-mini/mini.align), and
  [`nerdy.nvim`](https://github.com/2kabhishek/nerdy.nvim) for Nerd Font glyphs.
- **AI assistance** — [`kiro.nvim`](https://github.com/seagoj/kiro.nvim) and
  [`agentic.nvim`](https://github.com/carlos-algms/agentic.nvim).

---

## Colorschemes

Active theme is **TokyoNight** (`moon` style). Also available:

- [`catppuccin/nvim`](https://github.com/catppuccin/nvim)
- [`oxocarbon.nvim`](https://github.com/shaunsingh/oxocarbon.nvim)
- [`gruvbox.nvim`](https://github.com/ellisonleao/gruvbox.nvim)
- [`rose-pine`](https://github.com/rose-pine/neovim)

Switch the active colorscheme in [`lua/plugins/colorscheme.lua`](lua/plugins/colorscheme.lua).

---

## Structure

```
nvim/
├── init.lua                 # Bootstraps config.lazy
├── lazy-lock.json           # Pinned plugin versions
├── lazyvim.json             # LazyVim extras
├── stylua.toml              # Lua formatter config
├── snippets/                # Custom LuaSnip snippets
└── lua/
    ├── config/              # options, keymaps, autocmds, lazy setup
    └── plugins/             # Per-plugin configuration
```

---

## Requirements

- Neovim (recent stable — LazyVim tracks the latest release)
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- `git`, `ripgrep`, and `fd` for Telescope/Snacks pickers
