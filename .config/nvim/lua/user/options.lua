-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- {{{
--- (Move end fold tag to end of options if folding options is desired)
--}}}

-- Options

local options = {
	-- verbose=13,
	-- verbosefile = "2022-nvim.log",
	fileencoding = "utf-8", -- the encoding written to a file
	fileformat = "unix",
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	writebackup = true,     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	backup = false,         -- backup file?
	cmdheight = 1,          -- command line height for displaying messages
	helpheight=40,          -- Minimal initial height of the help window
	conceallevel = 0,       -- so that `` is visible in markdown files
	mouse = "nv",           -- allow the mouse to be used in these modes(n=normal etc.)
	pumheight = 100,        -- pop up menu height
	pumwidth = 105,         -- pop up menu width
	showmode = false,       -- Show mode in status line (eg. '-- INSERT --')
	showtabline = 2,        -- (0 : never) (1 : two or more) (2 : always)
	hlsearch = true,        -- highlight all matches on previous search pattern
	history = 10000,        -- A history of ":" commands, and a history of previous search patterns is remembered
	ignorecase = true,      -- ignore case in search patterns
	smartcase = true,       -- smart case
	smartindent = true,     -- make indenting smarter again
	splitright = true,      -- force all vertical splits to go to the right of current window
	splitbelow = true,      -- force all horizontal splits to go below current window
	confirm = true,         -- unsaved changes to a buffer, e.g. ":q" and ":e", instead raise a dialog asking if you wish to save the current file(s).
	termguicolors = true,   -- set term gui colors (most terminals support this)
	undofile = true,        -- enable persistent undo
	swapfile = false,        -- creates a swapfile
	timeoutlen = 100,       -- time to wait for a mapped sequence to complete (in milliseconds)
	redrawtime = 5000,      -- Time in milliseconds for redrawing the display. (default 2000)
	updatetime = 500,       -- If this many milliseconds nothing is typed the swap file will be written to disk. Also used for the|CursorHold| autocommand event(4000ms default)
	updatecount = 200,      -- After typing this many characters the swap file will be written todisk
	expandtab = true,       -- convert tabs to spaces
	tabstop = 2,            -- Number of spaces per tab
	shiftwidth = 2,         -- the number of spaces inserted for each indentation
	cursorline = true,      -- highlight the current line
	cursorcolumn = true,    -- highlight the current column
	number = true,          -- set numbered lines
	relativenumber = true,  -- set relative numbered lines
	numberwidth = 2,        -- set number column width to 2 {default 4}
	wrap = false,           -- display lines as one long line
	scrolloff = 12,         -- Minimal number of screen lines to keep above and below the cursor
	sidescrolloff = 20,     -- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
	signcolumn = "yes",     -- always show the sign column, otherwise it would shift the text each time
  virtualedit = "block", -- onemore, Virtual editing means that the cursor can be positioned where there is no actual character.
	guifont = "hack:h17",   --monospace:h17    -- the font used in graphical neovim applications
	foldmethod = "marker",  -- (marker) The kind of folding used for the current window
	--[[ foldmarker = "###{{{,###}}}", ]]
  foldminlines = 4,
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
