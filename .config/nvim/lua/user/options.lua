-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- {{{
--- (Move end fold tag to end of options if folding options is desired)
--}}}

-- Options

local options = {
	backup = false, -- backup file?
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	-- verbose=13,
	-- verbosefile = "2022-nvim.log",
	cmdheight = 1, -- command line height for displaying messages
	completeopt = { "menu", "menuone", "preview", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "nv", -- allow the mouse to be used in these modes(n=normal etc.)
	pumheight = 60, -- pop up menu height
	pumwidth = 100, -- pop up menu width
	showmode = false, -- Show mode in status line (eg. '-- INSERT --')
	showtabline = 2, -- (0 : never) (1 : two or more) (2 : always)
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitright = true, -- force all vertical splits to go to the right of current window
	splitbelow = true, -- force all horizontal splits to go below current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	undofile = true, -- enable persistent undo
	timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
	updatetime = 200, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	tabstop = 2, -- Number of spaces per tab
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	cursorline = true, -- highlight the current line
	cursorcolumn = true, -- highlight the current column
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 2, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	scrolloff = 8, -- is one of my fav
	sidescrolloff = 8, -- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set.
	guifont = "hack:h17", --monospace:h17    -- the font used in graphical neovim applications
	foldmethod = "marker", -- The kind of folding used for the current window
	foldclose = "all", -- Close fold when cursor leaves it if set to "all"
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
