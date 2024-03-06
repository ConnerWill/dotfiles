return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- LuaLine sections: https://github.com/nvim-lualine/lualine.nvim#available-components
      -- +-------------------------------------------------+
      -- | A | B | C                             X | Y | Z |
      -- +-------------------------------------------------+
      table.insert(opts.sections.lualine_x, "fileformat") -- Shows fileformat in lualine
      table.insert(opts.sections.lualine_x, "encoding") -- Shows encoding in lualine
      table.insert(opts.sections.lualine_x, "filetype") -- Shows filetype in lualine
    end,
  },
}
