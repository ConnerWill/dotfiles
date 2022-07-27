local util = require("dampsocktheme.util")

local M = {}

---@param config Config
---@return ColorScheme
function M.setup(config)
  config = config or require("dampsocktheme.config")

  -- Color Palette
  ---@class ColorScheme
  -- local colors = {}
  local colors = {
              none = "NONE"   ,
                bg = "#13172a",
           bg_dark = "#0e1224",
          bg_light = "#1a1b26",
     bg_dark_light = "#16161e",
      bg_highlight = "#181d31",
    terminal_black = "#202646",
                fg = "#c0caf5",
           fg_dark = "#98a0c5",
         fg_gutter = "#2a3150",
             dark3 = "#323a5c",
           comment = "#454e78",
             dark5 = "#404770",
             blue0 = "#1a59f1",
              blue = "#75a2f7",
              cyan = "#7dffff",
             blue1 = "#1ac3ff",
             blue2 = "#5fb9e7",
             blue5 = "#409aff",
             blue6 = "#a4c9Fa",
             blue7 = "#114bb0",
           magenta = "#cf04fa",
          magenta2 = "#ed0eee",
            purple = "#9923ff",
            orange = "#ff9e54",
            yellow = "#c9eb20",
             green = "#4eff6a",
            green1 = "#73e0aa",
            green2 = "#41b6a5",
              teal = "#18a7b5",
               red = "#ff7690",
              red1 = "#fb3b4b",
         git = {
            change = "#6183bb",
               add = "#449dab",
            delete = "#914c54",
          conflict = "#bb7a61"
         },
    gitSigns = {
               add = "#164846",
            change = "#394b70",
            delete = "#823c41"
         },
}
  -- {{{ OLD (keeping is case error)
  -- colors = {
  --   none = "NONE",
  --   bg_dark = "#0e1224", -- Color of side panels
  --   bg = "#13172a", -- Main background color
  --   bg_highlight = "#181d31",
  --   terminal_black = "#202646",
  --   fg = "#c0caf5", -- plain text color
  --   fg_dark = "#98a0c5",
  --   fg_gutter = "#2a3150",
  --   dark3 = "#323a5c",
  --   comment = "#454e78",
  --   dark5 = "#404770",
  --   blue0 = "#1a59f1",
  --   blue = "#75a2f7",
  --   cyan = "#7dffff",
  --   blue1 = "#1ac3ff",
  --   blue2 = "#5fb9e7",
  --   blue5 = "#409aff",
  --   blue6 = "#a4c9Fa",
  --   blue7 = "#114bb0", -- select highlight bg color
  --   magenta = "#cf04fa",
  --   magenta2 = "#ed0eee",
  --   purple = "#9923ff",
  --   orange = "#ff9e54",
  --   yellow = "#c9eb20",
  --   green = "#4eff6a", -- select highlight fg color
  --   green1 = "#73e0aa", -- Green text color #73ddaa
  --   green2 = "#41b6a5",
  --   teal = "#18a7b5", -- #0abc9c
  --   red = "#ff7690",
  --   red1 = "#fb3b4b",
  --   git = { change = "#6183bb", add = "#449dab", delete = "#914c54", conflict = "#bb7a61" },
  --   gitSigns = { add = "#164846", change = "#394b70", delete = "#823c41" },
  -- } --}}}
  if config.style == "night" or config.style == "day" or vim.o.background == "light" then
    colors.bg = colors.bg_light
    colors.bg_dark = colors.bg_dark_light
  end
  util.bg = colors.bg
  util.day_brightness = config.dayBrightness

  colors.diff = {
       add = util.darken(colors.green2, 0.15),
    delete = util.darken(colors.red1  , 0.15),
    change = util.darken(colors.blue7 , 0.15),
      text = colors.blue7,
  }

  colors.gitSigns = {
       add = util.brighten(colors.gitSigns.add   , 0.2),
    change = util.brighten(colors.gitSigns.change, 0.2),
    delete = util.brighten(colors.gitSigns.delete, 0.2),
  }

  colors.git.ignore = colors.dark3
  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border_highlight = colors.blue0
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg_dark
  colors.bg_statusline = colors.bg_dark

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = (config.transparentSidebar and colors.none) or config.darkSidebar and colors.bg_dark or colors.bg
  colors.bg_float = config.darkFloat and colors.bg_dark or colors.bg

  colors.bg_visual = util.darken(colors.blue0, 0.7)
  colors.bg_search = colors.blue0
  colors.fg_sidebar = colors.fg_dark

  colors.error   = colors.red1
  colors.warning = colors.yellow
  colors.info    = colors.blue2
  colors.hint    = colors.teal

  util.color_overrides(colors, config)

  if config.transform_colors and (config.style == "day" or vim.o.background == "light") then
    return util.light_colors(colors)
  end

  return colors
end

return M
