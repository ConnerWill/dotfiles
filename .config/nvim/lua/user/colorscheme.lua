-- Example config in Lua

--vim.g.dampsocktheme_style = "night"
vim.g.dampsocktheme_italic_comments = false
vim.g.dampsocktheme_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.dampsocktheme_dark_sidebar = true
vim.g.dampsocktheme_dark_float = true
vim.g.dampsocktheme_lualine_bold = true
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.dampsocktheme_colors = { error = "#ff0000" }
-- Load the colorscheme
--vim.cmd[[colorscheme tokyonigh


vim.cmd [[
try
  colorscheme dampsocktheme
  "colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
  "colorscheme default
  "set background=dark
endtry
]]



-- colorscheme darkplus
-- colorscheme tokyonight

-- -- Example config in Lua
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_comments = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- vim.g.tokyonight_dark_sidebar = true
-- vim.g.tokyonight_dark_float = true
-- vim.g.tokyonight_lualine_bold = true
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- -- vim.g.tokyonight_colors = { error = "#ff0000" }
-- Load the colorscheme
--vim.cmd[[colorscheme tokyonight]]
--vim.cmd[[colorscheme dampsocktheme]]


