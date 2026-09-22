-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

vim.g.autoformat = false -- Disable LazyVim format-on-save (format manually with <leader>cf)
vim.g.mapleader = "\\" -- Define leader key

opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.cursorcolumn = true -- Enable highlighting of the current column
opt.mouse = "nv" -- Mouse in normal + visual modes only

-- Folding: LazyVim already enables treesitter-based folding
-- (foldmethod=expr with vim.treesitter.foldexpr on Neovim 0.10+). We do not
-- override foldmethod/foldexpr here so we stay on the modern, non-deprecated
-- path instead of the legacy nvim_treesitter#foldexpr() VimL expression.

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"
