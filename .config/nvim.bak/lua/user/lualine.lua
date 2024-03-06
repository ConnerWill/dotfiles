-- vim:fdm=marker filetype=lua fileencoding=utf8

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = {
		"nvim_diagnostic",
		"nvim_lsp",
	},
	sections = {
		"error",
		"warn",
		"info",
		"hint",
	},

	symbols = {
		error = "💀 ",
		warn  = " ",
    info = "",
		hint = "",
	},
	colored = true,
	update_in_insert = true, --false,
	always_visible = false,
}

-- changes diff symbols
local diff = {
	"diff",
	symbols = {
		added 	  = " ",	 -- " "
		modified  = " ",	 -- " "
		removed   = " ",	 -- " "
	},
	colored = true,
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		return str
		--return "-- " .. str .. " --"
	end,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

local art = function()
	local art_symbol = "🖳  " -- 🖳       🕱 🦠 "
	return art_symbol
end

-- cool function for progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = {
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
		"  ",
    "  ",
		"  ",
	}
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = function()
	return "spaces:" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			"alpha",
			"dashboard",
			"NvimTree",
			"Outline",
			"help",
			"man",
			"info",
			--"toggleterm",
		},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { branch },
		lualine_b = { diagnostics },
		lualine_c = { diff, art },
		lualine_x = { filetype, "fileformat", "encoding", spaces },
		lualine_y = { mode, location },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
