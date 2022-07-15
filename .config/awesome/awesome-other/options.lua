local options = {
  filetype = "lua",                        -- type of file; triggers the FileType event when set
  fileencoding = "utf-8",                  -- the encoding written to a file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cedit = "",                            -- key used to open the command-line window
  cmdwinheight = 12,                       -- height of the command-line window
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  warn = true,                             --	warn when using a shell command and a buffer has changes
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  hlsearch = true,                         -- highlight all matches on previous search pattern
  incsearch = true,                        -- show match for partly typed search command
  ignorecase = true,                       -- ignore case in search patterns
  maxmempattern = 1000,                    -- maximum amount of memory in Kbyte used for pattern matching
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- maximum height of pop up menu
  pumwidth = 15,	                         -- minimum width of the popup menu
  showmode = false,                        -- Show mode in status line (eg. '-- INSERT --')
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  equalalways	= true,                      -- make all windows the same size when adding/removing windows
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  switchbuf = "useopen",                   -- "useopen" and/or "split"; which window to use when jumping
  timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undolevels = 5000,                       --	maximum number of changes that can be undone
  undoreload = 1000,                       --	maximum number lines to save for undo on a buffer reload
  undofile = true,                         -- enable persistent undo
  swapfile = false,                        -- creates a swapfile
  backup = false,                          -- creates a backup file
  backupskip = "/tmp/*",                   --	patterns that specify for which files a backup is not made
  updatetime = 300,                        -- faster completion (4000ms default)
  owritebackup = true,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  backupdir = "/home/dampsock/.local/share/nvim/backup//", -- list of directories to put backup files in
  infercase = true,                        -- adjust case of a keyword completion match
  tabstop = 2,                             -- Number of spaces per tab
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  expandtab = true,                        -- convert tabs to spaces
  autoindent = true,                       -- automatically set the indent of a new line
  smartindent = true,                      -- make indenting smarter again
  cursorline = true,                       -- highlight the current line
  cursorcolumn = true,                     --	highlight the screen column of the cursor
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  scroll = 13,                             --	number of lines to scroll for CTRL-U and CTRL-D
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  foldclose = "all",                       -- set to "all" to close a fold when the cursor leaves it
  foldmethod = "syntax",                    --	folding type: "manual", "indent", "expr", "marker", "syntax" or "diff"
  hidden = true,                           -- don't unload a buffer when no longer shown in a window
  wrap = false,                            -- display lines as one long line
  spell	= true,                            -- highlight spelling mistakes
  spelllang = "en",	                       -- list of accepted languages
  spellfile = "",                          -- file that "zg" adds good words to
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  spellsuggest = "best",                   -- methods used to suggest corrections
  mkspellmem = 460000,2000,500,            -- amount of memory used by :mkspell before compressing
  matchpairs = "(:),{:},[:],\\e[m:\\e[m", -- list of pairs that match for the "%" command
  pyxversion = 3,                          -- whether to use Python 2 or 3
  confirm = true,                          -- 	start a dialog when a command fails
  verbose = true,                          -- the higher the more messages are given
}

-- spellcapcheck = "[.?!]\\_[\\])'\\	\ ]\\+'", -- pattern to locate the end of a sentence
  -- spelloptions = "",	                   -- flags to change how spell checking works




vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
