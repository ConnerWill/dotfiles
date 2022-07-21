-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`


local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

-- vim.g.nvim_tree_icons = {
--   default = "",
--   symlink = "",
--   git = {
--     unstaged = "",
--     staged = "", --🧍
--     unmerged = "",
--     renamed = "",
--     deleted = "",
--     untracked = "", -- 🧘
--     ignored = "🧄",
--   },
--   folder = {
--     default = "",
--     open = "",
--     empty = "",
--     empty_open = "",
--     symlink = "",
--   },
-- }
--
nvim_tree.setup {
  -- default = "",
  -- symlink = "",
  -- git = {
  --   unstaged = "",
  --   staged = "", --🧍
  --   unmerged = "",
  --   renamed = "",
  --   deleted = "",
  --   untracked = "", -- 🧘
  --   ignored = "🧄",
  -- },
  -- folder = {
  --   default = "",
  --   open = "",
  --   empty = "",
  --   empty_open = "",
  --   symlink = "",
  -- },
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = true,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  -- auto_close = false,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = " ",
      error = "",
    }, -- """",💀", "",
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 600,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    -- auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit"               },
        { key = "h",                  cb = tree_cb "close_node"         },
        { key = "v",                  cb = tree_cb "vsplit"             },
        { key = "T",                  cb = tree_cb "vs"                 },
      },
    },
    number = false, -- true,
    relativenumber = false, -- true,
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "├ ", -- "│ ",
        none = "  ",
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  -- quit_on_open = 0,
  -- -- git_hl = 1,
  -- -- disable_window_picker = 0,
  -- -- root_folder_modifier = ":t",
  -- show_icons = {
  --   git = 1,
  --   folders = 1,
  --   files = 1,
  --   folder_arrows = 1,
  --   tree_width = 30,
  -- },
}

  -- require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
  --     auto_reload_on_write = true,
  --     create_in_closed_folder = false,
  --     disable_netrw = false,
  --     hijack_cursor = false,
  --     hijack_netrw = true,
  --     hijack_unnamed_buffer_when_opening = false,
  --     ignore_buffer_on_setup = false,
  --     open_on_setup = false,
  --     open_on_setup_file = false,
  --     open_on_tab = false,
  --     sort_by = "name",
  --     root_dirs = {},
  --     prefer_startup_root = false,
  --     sync_root_with_cwd = false,
  --     reload_on_bufenter = false,
  --     respect_buf_cwd = false,
  --     view = {
  --       adaptive_size = false,
  --       centralize_selection = false,
  --       width = 30,
  --       height = 30,
  --       hide_root_folder = false,
  --       side = "left",
  --       preserve_window_proportions = false,
  --       number = false,
  --       relativenumber = false,
  --       signcolumn = "yes",
  --       mappings = {
  --         custom_only = false,
  --         list = {
  --           -- user mappings go here
  --         },
  --       },
  --     },
  --     renderer = {
  --       add_trailing = false,
  --       group_empty = false,
  --       highlight_git = false,
  --       full_name = false,
  --       highlight_opened_files = "none",
  --       root_folder_modifier = ":~",
  --       indent_markers = {
  --         enable = false,
  --         icons = {
  --           corner = "└ ",
  --           edge = "│ ",
  --           item = "│ ",
  --           none = "  ",
  --         },
  --       },
  --       icons = {
  --         webdev_colors = true,
  --         git_placement = "before",
  --         padding = " ",
  --         symlink_arrow = " ➛ ",
  --         show = {
  --           file = true,
  --           folder = true,
  --           folder_arrow = true,
  --           git = true,
  --         },
  --         glyphs = {
  --           default = "",
  --           symlink = "",
  --           folder = {
  --             arrow_closed = "",
  --             arrow_open = "",
  --             default = "",
  --             open = "",
  --             empty = "",
  --             empty_open = "",
  --             symlink = "",
  --             symlink_open = "",
  --           },
  --           git = {
  --             unstaged = "✗",
  --             staged = "✓",
  --             unmerged = "",
  --             renamed = "➜",
  --             untracked = "★",
  --             deleted = "",
  --             ignored = "◌",
  --           },
  --         },
  --       },
  --       special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
  --       symlink_destination = true,
  --     },
  --     hijack_directories = {
  --       enable = true,
  --       auto_open = true,
  --     },
  --     update_focused_file = {
  --       enable = false,
  --       update_root = false,
  --       ignore_list = {},
  --     },
  --     ignore_ft_on_setup = {},
  --     system_open = {
  --       cmd = "",
  --       args = {},
  --     },
  --     diagnostics = {
  --       enable = false,
  --       show_on_dirs = false,
  --       icons = {
  --         hint = "",
  --         info = "",
  --         warning = "",
  --         error = "",
  --       },
  --     },
  --     filters = {
  --       dotfiles = false,
  --       custom = {},
  --       exclude = {},
  --     },
  --     filesystem_watchers = {
  --       enable = false,
  --       interval = 100,
  --       debounce_delay = 50,
  --     },
  --     git = {
  --       enable = true,
  --       ignore = true,
  --       show_on_dirs = true,
  --       timeout = 400,
  --     },
  --     actions = {
  --       use_system_clipboard = true,
  --       change_dir = {
  --         enable = true,
  --         global = false,
  --         restrict_above_cwd = false,
  --       },
  --       expand_all = {
  --         max_folder_discovery = 300,
  --         exclude = {},
  --       },
  --       open_file = {
  --         quit_on_open = false,
  --         resize_window = true,
  --         window_picker = {
  --           enable = true,
  --           chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
  --           exclude = {
  --             filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
  --             buftype = { "nofile", "terminal", "help" },
  --           },
  --         },
  --       },
  --       remove_file = {
  --         close_window = true,
  --       },
  --     },
  --     trash = {
  --       cmd = "gio trash",
  --       require_confirm = true,
  --     },
  --     live_filter = {
  --       prefix = "[FILTER]: ",
  --       always_show_folders = true,
  --     },
  --     log = {
  --       enable = false,
  --       truncate = false,
  --       types = {
  --         all = false,
  --         config = false,
  --         copy_paste = false,
  --         diagnostics = false,
  --         git = false,
  --         profile = false,
  --         watcher = false,
  --       },
  --     },
  --   } -- END_DEFAULT_OPTS

