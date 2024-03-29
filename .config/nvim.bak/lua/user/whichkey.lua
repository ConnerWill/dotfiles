local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 30, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "SPACE",
    ["<cr>"] = " ",
    ["<tab>"] = " ",
    ["<esc>"] = "ESC",
    ["<bs>"] = " ",
    ["<leader>"] = "<leader>",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow, rounded
    position = "bottom", -- bottom, top
    margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left] { 1, 0, 1, 0 },
    padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left] { 2, 2, 2, 2 }
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 2, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  --ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  --hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
    -- disable the WhichKey popup for certain buf types and file types.
    -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local mappings = {
    ["A"] = { "<cmd>Alpha<cr>",                                                                                                           "Alpha"  },
    ["B"] = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",          "Buffers" },
    ["e"] = { "<cmd>NvimTreeToggle<cr>",                                                                                                "Explorer" },
    ["c"] = { "<cmd>Bdelete!<CR>",                                                                                                  "Close Buffer" },
    ["C"] = { "<cmd>LuaSnipListAvailable<CR>",                                                                                     "List Snippets" },
    ["d"] = { "<cmd>TroubleToggle<cr>",                                                                                                  "Trouble" },
    ["h"] = { "<cmd>Telescope help_tags<CR>",                                                                                         "Help Pages" },
    ["H"] = { "<cmd>Telescope man_pages<CR>",                                                                                          "Man Pages" },
    ["r"] = { "<cmd>Telescope oldfiles<cr>",                                                                                        "Recent Files" },
    ["f"] = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",    "Find files" },
    ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>",                                                                                "Find Text" },
    ["z"] = { "<cmd>FZF<cr>",                                                                                                                "FZF" },
    ["v"] = { "<cmd>Format<cr>",                                                                                                          "Format" },
    ["T"] = { "<cmd>Telescope treesitter theme=ivy<cr>",                                                                              "TreeSitter" },
    ["L"] = { "<cmd>nohlsearch<CR>",                                                                                                "No Highlight" },
    ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>",                                                       "Projects" },
    ["W"] = { "<cmd>WhichKey <CR>",                                                                                         "List all keybindings" },
    ["w"] = { "<cmd>w!<CR>",                                                                                                                "Save" },
    ["q"] = { "<cmd>q<CR>",                                                                                                                 "Quit" },
    p = {
      name = "Packer",
      s = { "<cmd>PackerSync<cr>",     "Sync"    },
      c = { "<cmd>PackerCompile<cr>",  "Compile" },
      i = { "<cmd>PackerInstall<cr>",  "Install" },
      S = { "<cmd>PackerStatus<cr>",   "Status"  },
      u = { "<cmd>PackerUpdate<cr>",   "Update"  },
    },
    g = {
      name = "Git",
      g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>",                             "Lazygit"        },
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>",              "Next Hunk"        },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",              "Prev Hunk"        },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>",                 "Blame"        },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",        "Preview Hunk"        },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",            "Reset Hunk"        },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",        "Reset Buffer"        },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",            "Stage Hunk"        },
      u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>" , "Undo Stage Hunk",       },
      o = { "<cmd>Telescope git_status<cr>",                    "Open changed file"        },
      b = { "<cmd>Telescope git_branches<cr>",                    "Checkout branch"        },
      c = { "<cmd>Telescope git_commits<cr>",                     "Checkout commit"        },
      d = { "<cmd>Gitsigns diffthis HEAD<cr>",                              "Diff",        },
    },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>"            , "Code Action"            },
      d = { "<cmd>Telescope lsp_document_diagnostics<cr>"       , "Document Diagnostics",  },
      w = { "<cmd>Telescope lsp_workspace_diagnostics<cr>"      , "Workspace Diagnostics", },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>"             , "Format"                 },
      i = { "<cmd>LspInfo<cr>"                                  , "Info"                   },
      I = { "<cmd>LspInstallInfo<cr>"                           , "Installer Info"         },
      j = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>"       , "Next Diagnostic",       },
      k = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>"       , "Prev Diagnostic",       },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>"               , "CodeLens Action"        },
      q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>"     , "Quickfix"               },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>"                 , "Rename"                 },
      s = { "<cmd>Telescope lsp_document_symbols<cr>"           , "Document Symbols"       },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>"  , "Workspace Symbols",     },
    },
    s = {
      name = "Search",
      f = { "<cmd>Telescope fd<cr>",                   "fzf fd"               },
      r = { "<cmd>Telescope oldfiles<cr>",             "Recent File"          },
      g = { "<cmd>Telescope live_grep<cr>",            "Grep"                 },
      a = { "<cmd>Telescope autocommands<cr>",         "Auto Commands"        },
      c = { "<cmd>Telescope commands<cr>",             "Commands"             },
      k = { "<cmd>Telescope keymaps<cr>",              "Keymaps"              },
      h = { "<cmd>Telescope help_tags<cr>",            "Help Pages"            },
      M = { "<cmd>Telescope man_pages<cr>",            "Man Pages"            },
      R = { "<cmd>Telescope registers<cr>",            "Registers"            },
      Y = { "<cmd>Telescope command_history<cr>",      "Command History"      },
      G = { "<cmd>Telescope searh_history<cr>",        "Searh History"        },
      S = { "<cmd>Telescope lsp_document_symbols<cr>", "LSP Document Symbols" },
      d = { "<cmd>Telescope lsp_definitions<cr>",      "LSP Definitions"      },
      D = { "<cmd>Telescope diagnostic<cr>",           "Diagnostics"          },
      C = { "<cmd>Telescope colorscheme<cr>",          "Colorschemes"         },
      H = { "<cmd>Telescope highlights<cr>",           "Highlights"           },
      P = { "<cmd>Telescope planets<cr>" ,             "Planets"              },
    },
    a = {
      name = "Align",
      a = { "aa<CR>"  ,  "Align 1 character, moving left"   },
      s = { "as<CR>"  ,  "Align 2 characters, moving left"  },
      w = { "aw<CR>"  ,  "Align a string, moving left"      },
      r = { "ar<CR>"  ,  "Align a Lua pattern, moving left" },
  },
  m = {
      name = "Marks",
      s = { "<cmd>mark M<cr>"            , "Set mark"                 },
      b = { "<cmd>MarksListBuf<cr>"      , "List all marks in buffer" },
      a = { "<cmd>MarksListAll<cr>"      , "List all marks"        },
      g = { "<cmd>MarksListGlobal<cr>"   , "List all global marks" },
      t = { "<cmd>MarksToggleSigns<cr>"  , "Toggle marks"          },
  },
  t = {
      name = "Terminal",
      T = { "<cmd>ToggleTerm size=80 direction=vertical<cr>",    "Full"       },
      v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>",    "Vertical"   },
      h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>",  "Horizontal" },
      f = { "<cmd>ToggleTerm direction=float<cr>",               "Float"      },
      z = { "<cmd>lua _ZSH_TOGGLE()<cr>",                        "zsh"        },
      p = { "<cmd>lua _PYTHON_TOGGLE()<cr>",                     "python"     },
      n = { "<cmd>lua _NODE_TOGGLE()<cr>",                       "node"       },
      b = { "<cmd>lua _BTOP_TOGGLE()<cr>",                       "btop"       },
      t = { "<cmd>lua _HTOP_TOGGLE()<cr>",                       "htop"       },
      u = { "<cmd>lua _NCDU_TOGGLE()<cr>",                       "ncdu"       },
      s = {
          name = "SSH",
          c = { "<cmd>lua _SSH_CONNERWILL_TOGGLE_()<cr>",    "ssh connerwill" },
          p = { "<cmd>lua _SSH_BIGCHUNGUS_TOGGLE_()<cr>",    "ssh bigchungus" },
      },
  },
}
which_key.setup(setup)
which_key.register(mappings, opts)
