-- Colorizer User Config

DEFAULT_OPTIONS = {
	RGB = true, -- #RGB hex codes
	RRGGBB = true, -- #RRGGBB hex codes
	names = true, -- "Name" codes like Blue
	RRGGBBAA = false, -- #RRGGBBAA hex codes
	rgb_fn = false, -- CSS rgb() and rgba() functions
	hsl_fn = false, -- CSS hsl() and hsla() functions
	css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
	-- Available modes: foreground, background
	mode = "background", -- Set the display mode.
}

-- From lua
-- Attaches to every FileType mode
require("colorizer").setup()

-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require("colorizer").setup({
	"css",
	"javascript",
	html = {
		mode = "foreground",
	},
})

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require("colorizer").setup({
	"css",
	"javascript",
	html = { mode = "background" },
}, { mode = "foreground" })

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require("colorizer").setup({
	"*", -- Highlight all files, but customize some others.
	css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
	html = { names = false }, -- Disable parsing "names" like Blue or Gray
})

-- Exclude some filetypes from highlighting by using `!`
require("colorizer").setup({
	"*", -- Highlight all files, but customize some others.
	"!vim", -- Exclude vim from highlighting.
	-- Exclusion Only makes sense if '*' is specified!
})
