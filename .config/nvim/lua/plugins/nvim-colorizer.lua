return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      -- Highlight color codes in all files, with a few per-filetype tweaks.
      require("colorizer").setup({
        "*", -- Highlight all files, but customize some others.
        "!vim", -- Exclude vim from highlighting (only meaningful because '*' is set).
        css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
        html = { names = false }, -- Disable parsing "names" like Blue or Gray.
      })
    end,
  },
}
