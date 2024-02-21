local util = require("dampsocktheme.util")
local theme = require("dampsocktheme.theme")

local M = {}

function M.colorscheme()
  util.load(theme.setup())
end

return M
