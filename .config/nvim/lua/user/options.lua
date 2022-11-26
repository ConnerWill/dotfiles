-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- {{{
--- (Move end fold tag to end of options if folding options is desired)
--}}}

-- Options

local options = {
	--verbose=13,
	--verbosefile = "~/.cache/nvim/nvim-verbose.log",
	fileencoding = "utf-8", -- the encoding written to a file
	fileformat = "unix",
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	writebackup = true,     -- Prevent editing and overwriting files that have been modified by another program
	backup = false,         -- backup file?
	cmdheight = 1,          -- command line height for displaying messages
	helpheight=40,          -- Minimal initial height of the help window
	conceallevel = 0,       -- so that `` is visible in markdown files
	mouse = "nv",           -- allow the mouse to be used in these modes(n=normal etc.)
	pumheight = 100,        -- pop up menu height
	pumwidth = 150,         -- pop up menu width
	showmode = false,       -- Show mode in status line (eg. '-- INSERT --')
	showtabline = 2,        -- (0 : never) (1 : two or more) (2 : always)
	hlsearch = true,        -- highlight all matches on previous search pattern
	history = 10000,        -- A history of ":" commands, and a history of previous search patterns is remembered
	ignorecase = true,      -- ignore case in search patterns
	smartcase = true,       -- smart case
	smartindent = true,     -- make indenting smarter again
	splitright = true,      -- force all vertical splits to go to the right of current window
	splitbelow = true,      -- force all horizontal splits to go below current window
	undofile = true,        -- enable persistent undo
	swapfile = false,       -- creates a swapfile
	timeoutlen = 100,       -- time to wait for a mapped sequence to complete (in milliseconds)
	redrawtime = 250,       -- Time in milliseconds for redrawing the display. (default 2000)
	updatetime = 200,       -- If this many milliseconds nothing is typed the swap file will be written to disk.
	updatecount = 200,      -- After typing this many characters the swap file will be written todisk
	expandtab = true,       -- convert tabs to spaces
	tabstop = 2,            -- Number of spaces per tab
	cursorline = true,      -- highlight the current line
	cursorcolumn = true,    -- highlight the current column
	number = true,          -- set numbered lines
	relativenumber = true,  -- set relative numbered lines
	numberwidth = 2,        -- set number column width to 2 {default 4}
	shiftwidth = 2,         -- the number of spaces inserted for each indentation
	wrap = false,           -- display lines as one long line
	scrolloff = 12,         -- Minimal number of screen lines to keep above and below the cursor
	sidescrolloff = 20,     -- Min # of columns to keep to the left and to the right of the cursor if 'nowrap' is set
	signcolumn = "yes",     -- always show the sign column, otherwise it would shift the text each time
	virtualedit = "block",  -- Virtual editing means that the cursor can be positioned where there is no actual character.
	termguicolors = true,   -- set term gui colors (most terminals support this)
	guifont = "hack:h17",   --monospace:h17    -- the font used in graphical neovim applications
--confirm = true,       -- Pressing :q with unsaved changes prompts if you wish to save the current file
  foldminlines = 4,       -- If folds are smaller than this, do not fold.
	foldmethod = "marker",  -- (marker) The kind of folding used for the current window
	--[[ foldmarker = "###{{{,###}}}", ]]
	foldopen = { "block", "hor", "mark", "percent", "quickfix", "search", "tag", "undo" },
	completeopt = { "menu", "menuone", "preview", "noselect" }, -- mostly just for cmp
	foldclose = "all",      -- Close fold when cursor leaves it if set to "all"
}

--}}}

-- Set Options{{{

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work

-- }}}
