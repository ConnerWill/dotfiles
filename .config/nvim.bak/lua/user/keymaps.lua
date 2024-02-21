-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- SETUP {{{
local opts = { noremap = true, silent = true } -- Key Mapping Setup
local term_opts = { silent = true }            -- Key Mapping Setup
local keymap = vim.api.nvim_set_keymap         -- Define remap variable name
-- SETUP }}}

-- {{{ MAPPINGS

-- Leader Key{{{

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
keymap("n", "<S-Up>",    "2k",  opts)
keymap("n", "<S-Down>",  "2j",  opts)
keymap("n", "<S-Left>",  "2b",  opts)
keymap("n", "<S-Right>", "2w",  opts)
-- even faster cursor movement (Shift ⇑⇒⇐⇓)
keymap("n", "<C-Up>",    "4k", opts)
keymap("n", "<C-Down>",  "4j", opts)
keymap("n", "<C-Left>",  "4b", opts)
keymap("n", "<C-Right>", "4w", opts)

-- Resize with arrows (Alt+Arrow keys  →←↑↓⇑⇓⇒⇐)
keymap("n", "<A-Up>",    ":resize -2<CR>",          opts)
keymap("n", "<A-Down>",  ":resize +2<CR>",          opts)
keymap("n", "<A-Right>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Left>",  ":vertical resize +2<CR>", opts)
-- keymap("n", "<C-S-Left>", ":vertical resize +1<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>",     opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down (Alt+j Alt+k)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)

-- Map 4x Ctrl+c to :wqa
keymap("n", "<C-c><C-c><C-c><C-c>", ":wqa<CR>", opts)

-- Map 3x Ctrl+c 1x Ctrl+q to :wqa!
keymap("n", "<C-c><C-c><C-c><C-q>", ":wqa!<CR>", opts)

-- Map 2x Ctrl+c 2x Ctrl+q to :qa!
keymap("n", "<C-c><C-c><C-q><C-q>", ":qa!<CR>", opts)

-- Telescope help search (Altt+h)
keymap("n", "<A-h>", ":Telescope help_tags<CR>", opts)

-- Telescope man search (Alt+m)
keymap("n", "<A-m>", ":Telescope man_pages<CR>", opts)

-- Space and Ctrl+Space move up and down lines.
keymap("n", "<Space>", "j", opts)
keymap("n", "<C-Space>", "k", opts)

-- jump to the tag under the cursor
--keymap("n", "<C-]>", "tag", opts)

-- jump to the previous tag in tagstack
keymap("n", "<C-[>", "tag-stack", opts)

--}}}

-- Insert --{{{

-- Map F1 to Esc
keymap("i", "<F1>", "<Esc>", opts)

-- Map Ctrl+c  to Esc
keymap("i", "<C-c>", "<ESC>", opts)

-- even iaster cursor movement (Ctrl ⇑⇒⇐⇓)
--[[ keymap("i", "<C-Up>",    "\4<Up><Up>", opts) ]]
--[[ keymap("i", "<C-Down>",  "\4<Down><Down>", opts) ]]
--[[ keymap("i", "<C-Left>",  "\4<Left><Left>", opts) ]]
--[[ keymap("i", "<C-Right>", "\4<Right><Right>", opts) ]]

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


-- Clear search highlighting
-- map <leader><space>
-- vim.g.map
-- keymap("", "\\", "<Nop>", opts)
-- vim.g.mapleader = "\\"
-- vim.g.maplocalleader = "\\"

-- }}} MAPPINGS
