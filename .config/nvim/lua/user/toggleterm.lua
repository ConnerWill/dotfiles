local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

-- EXAMPLE{{{
-- =======================================
--     require("toggleterm").setup{
--       -- size can be a number or function which is passed the current terminal
--       size = 20 | function(term)
--         if term.direction == "horizontal" then
--           return 15
--         elseif term.direction == "vertical" then
--           return vim.o.columns * 0.4
--         end
--       end,
--       open_mapping = [[<c-\>]],
--       on_open = fun(t: Terminal), -- function to run when the terminal opens
--       on_close = fun(t: Terminal), -- function to run when the terminal closes
--       on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
--       on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
--       on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
--       hide_numbers = true, -- hide the number column in toggleterm buffers
--       shade_filetypes = {},
--       highlights = {
--         -- highlights which map to a highlight group name and a table of it's values
--         -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
--         Normal = {
--           guibg = <VALUE-HERE>,
--         },
--         NormalFloat = {
--           link = 'Normal'
--         },
--         FloatBorder = {
--           guifg = <VALUE-HERE>,
--           guibg = <VALUE-HERE>,
--         },
--       },
--       shade_terminals = true,
--       shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
--       start_in_insert = true,
--       insert_mappings = true, -- whether or not the open mapping applies in insert mode
--       terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
--       persist_size = true,
--       direction = 'vertical' | 'horizontal' | 'tab' | 'float',
--       close_on_exit = true, -- close the terminal window when the process exits
--       shell = vim.o.shell, -- change the default shell
--       -- This field is only relevant if direction is set to 'float'
--       float_opts = {
--         -- The border key is *almost* the same as 'nvim_open_win'
--         -- see :h nvim_open_win for details on borders however
--         -- the 'curved' border is a custom border type
--         -- not natively supported but implemented in this plugin.
--         border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
--         width = <value>,
--         height = <value>,
--         winblend = 3,
--       }
--     }
-- <
-- =======================================
--}}}

toggleterm.setup({
	size = 20,
	open_mapping = [[<C-\>]],
	hide_numbers = true,
	--[[ shade_filetypes = {}, ]]
	shade_filetypes = { "none", "zsh", "fzf" },
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "tab", -- "horizontal" "float","vertical","tab"
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "double",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
	--vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })
function _NODE_TOGGLE()
	node:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
function _NCDU_TOGGLE()
	ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })
function _HTOP_TOGGLE()
	htop:toggle()
end

local btop = Terminal:new({ cmd = "btop", hidden = true })
function _BTOP_TOGGLE()
	btop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })
function _PYTHON_TOGGLE()
	python:toggle()
end

local zsh = Terminal:new({ cmd = "zsh", hidden = true })
function _ZSH_TOGGLE()
	zsh:toggle()
end

-- SSH connerwill.com
local ssh_connerwill = Terminal:new({ cmd = "ssh connerwill", hidden = true })
function _SSH_CONNERWILL_TOGGLE_()
	ssh_connerwill:toggle()
end

-- SSH bigchungus.mywire.org
local ssh_bigchungus = Terminal:new({ cmd = "ssh_bigchungus", hidden = true })
function _SSH_BIGCHUNGUS_TOGGLE_()
	ssh_bigchungus:toggle()
end

--[[ local <PLACEHOLDER> = Terminal:new({ cmd = "<PLACEHOLDER>", hidden = true }) ]]
--[[ function _<PLACEHOLDER>_TOGGLE() ]]
--[[ 	<PLACEHOLDER>:toggle() ]]
--[[ end ]]
