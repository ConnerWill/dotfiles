return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      -- views = {
      --   cmdline_popup = {
      --     --   border = {
      --     --     style = "none",
      --     --     padding = { 2, 3 },
      --     --   },
      --     --   filter_options = {},
      --     --   win_options = {
      --     --     winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      --     --   },
      --     position = {
      --       row = "10%",
      --       col = "0%",
      --     },
      --     size = {
      --       width = "50%",
      --       height = "auto",
      --     },
      --   },
      --   popupmenu = {
      --     relative = "editor",
      --     position = {
      --       row = "10%",
      --       col = "0%",
      --     },
      --     size = {
      --       width = "50%",
      --       height = 10,
      --     },
      --   },
      -- },
    },
  },
}
