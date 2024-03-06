return {
  -- style windows with different colorschemes
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    opts = {
      themes = {
        markdown = { colorscheme = "oxocarbon" },
        help = { colorscheme = "oxocarbon", background = "dark" },
      },
    },
  },
}
