-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- SETUP {{{

-- Key Mapping - Settings/Setup{{{

local opts = {
	noremap = true,
	silent = true,
}

local term_opts = {
	silent = true,
}
-- }}} Key Mapping Settings Setup

-- Define remap variable name {{{

local keymap = vim.api.nvim_set_keymap

-- Define remap variable name }}}

-- SETUP }}}

-- {{{ MAPPINGS

--Remap leader key{{{

keymap("", "\\", "<Nop>", opts)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- }}}

-- Normal --{{{

-- Map Alt+f  to fzf
keymap("n", "<A-f>", ":FZF<CR>", opts)

-- Map F1 to Esc
keymap("n", "<F1>", "<Esc>", opts)


-- Map Ctrl+s to :w
keymap("n", "<C-s>", ":w<CR>", opts)


-- Map F1 to Esc
keymap("n", "<Insert>", "<Esc>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- faster cursor movement (Ctrl ⇑⇒⇓⇐)
keymap("n", "<S-Up>",    "k",    opts)
keymap("n", "<S-Down>",  "j",  opts)
keymap("n", "<S-Left>",  "b",  opts)
keymap("n", "<S-Right>", "w", opts)
-- even faster cursor movement (Shift ⇑⇒⇐⇓)
keymap("n", "<C-Up>",    "2k", opts)
keymap("n", "<C-Down>",  "2j",  opts)
keymap("n", "<C-Left>",  "2b",  opts)
keymap("n", "<C-Right>", "2w", opts)


-- Resize with arrows (Alt+Arrow keys  →←↑↓⇑⇓⇒⇐)
keymap("n", "<A-Up>", ":resize +1<CR>", opts)
keymap("n", "<A-Down>", ":resize -1<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize -1<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize +1<CR>", opts)
-- keymap("n", "<C-S-Left>", ":vertical resize +1<CR>", opts)


-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down (Alt+j Alt+k)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)

-- Map Ctrl+c  to :q or ZZ
keymap("n", "<C-c><C-c>", "ZZ", opts)
-- keymap("n", "<C-C>", ":q<CR>", opts)

-- Telescope help search (Altt+h)
keymap("n", "<A-h>", ":Telescope help_tags<CR>", opts)
-- Telescope man search (Alt+m)
keymap("n", "<A-m>", ":Telescope man_pages<CR>", opts)


--[[ keymap("n", "<C-Up>", ":resize +1<CR>", opts) ]]
--[[ keymap("n", "<C-Down>", ":resize -1<CR>", opts) ]]
--[[ keymap("n", "<C-Right>", ":vertical resize -1<CR>", opts) ]]
--[[ keymap("n", "<C-Left>", ":vertical resize +1<CR>", opts) ]]

--}}}

-- Insert --{{{

-- Map F1 to Esc
keymap("i", "<F1>", "<Esc>", opts)

-- Map Ctrl+c  to Esc
keymap("i", "<C-c>", "<ESC>", opts)

-- faster cursor movement (Ctrl ⇑⇒⇓⇐)
keymap("i", "<S-Up>",    "k",    opts)
keymap("i", "<S-Down>",  "j",  opts)
keymap("i", "<S-Left>",  "b",  opts)
keymap("i", "<S-Right>", "w", opts)
-- even iaster cursor movement (Shift ⇑⇒⇐⇓)
keymap("i", "<C-Up>",    "2k", opts)
keymap("i", "<C-Down>",  "2j",  opts)
keymap("i", "<C-Left>",  "2b",  opts)
keymap("i", "<C-Right>", "2w", opts)

--}}}

-- Visual --{{{

-- Map F1 to Esc
keymap("v", "<F1>", "<Esc>", opts)

-- Ctrl+c Yanks and reselects
keymap("v", "<C-c>", "ygv", opts)

--
keymap("v", "<C-F1>", "<Esc>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J",     ":move '>+1<CR>gv-gv", opts)
keymap("x", "K",     ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
--}}}

-- Terminal ---{{{

-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

--}}}

-- }}} MAPPINGS

-- Clear search highlighting
-- map <leader><space>

-- vim.g.map
--
-- keymap("", "\\", "<Nop>", opts)
-- vim.g.mapleader = "\\"
-- vim.g.maplocalleader = "\\"
