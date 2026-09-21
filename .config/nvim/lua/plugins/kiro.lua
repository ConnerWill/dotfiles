 -- ~/.config/nvim/lua/plugins/kiro.lua

-- Only load if kiro-cli is installed
if vim.fn.executable("kiro-cli") == 0 then
  return {}
end

-- Custom commands: single source of truth for name, keymap, description, and prompt.
-- Each entry drives the lazy `cmd` list, the `keys` table, and `opts.commands`.
local custom_commands = {
  { name = "KiroExplain",  key = "<leader>ke", desc = "Kiro Explain",  prompt = "Explain what this code does in" },
  { name = "KiroReview",   key = "<leader>kr", desc = "Kiro Review",   prompt = "Review this code for best practices and potential issues in" },
  { name = "KiroDoc",      key = "<leader>kd", desc = "Kiro Doc",      prompt = "Generate comprehensive documentation for" },
  { name = "KiroTest",     key = "<leader>kt", desc = "Kiro Test",     prompt = "Generate unit tests for" },
  { name = "KiroFix",      key = "<leader>kf", desc = "Kiro Fix",      prompt = "Fix the code in" },
  { name = "KiroOptimize", key = "<leader>ko", desc = "Kiro Optimize", prompt = "Optimize the code in" },
  { name = "KiroRefactor", key = "<leader>kR", desc = "Kiro Refactor", prompt = "Suggest refactoring improvements for" },
  { name = "KiroFormat",   key = "<leader>kF", desc = "Kiro Format",   prompt = "Reformat the code to follow standard style conventions in" },
  { name = "KiroCommit",   key = "<leader>km", desc = "Kiro Commit",   prompt = "Write a conventional commit message for the changes in" },
}

-- Built-in commands and their keymaps (normal-mode only).
local builtin_keys = {
  { "<leader>kc", "<cmd>KiroBuffer<cr>",       desc = "Kiro Chat"         },
  { "<leader>kb", "<cmd>KiroBuffers<cr>",      desc = "Kiro Buffers"      },
  { "<leader>ks", "<cmd>KiroResumePicker<cr>", desc = "Kiro Pick Session" },
  { "<leader>kz", "<cmd>KiroResume<cr>",       desc = "Kiro Resume"       },
}

-- Derive the lazy-load command list, keymaps, and opts.commands from the tables above.
local cmd = { "KiroBuffer", "KiroBuffers", "KiroResume", "KiroResumePicker", "KiroListSessions", "KiroDeleteSession" }
local keys = vim.deepcopy(builtin_keys)
local opts_commands = {}
for _, c in ipairs(custom_commands) do
  table.insert(cmd, c.name)
  table.insert(keys, { c.key, ("<cmd>%s<cr>"):format(c.name), desc = c.desc, mode = { "n", "v" } })
  opts_commands[c.name] = c.prompt
end

return {
  {
    "seagoj/kiro.nvim",
    cmd = cmd,
    keys = keys,
    opts = {
      force_setup = true,                -- Required: plugin/kiro.lua runs setup() with no args on load,
                                         -- which sets initialized=true and would otherwise cause this
                                         -- opts-driven setup (with custom commands) to be skipped.
      register_default_commands = true,  -- Enable default commands (default: true)
      split = 'vsplit',                  -- Split direction: 'split', 'vsplit', or 'float' (default: 'vsplit')
      commands = opts_commands,          -- Custom commands, derived from custom_commands above (default: {})
      reuse_terminal = true,             -- Reuse existing terminal window (default: true)
      auto_insert_mode = true,           -- Auto enter insert mode (default: true)
      enable_lsp = true,                 -- Enable LSP integration (default: true)
      float_opts = {                     -- Floating window options (only for split = 'float')
        width = 0.8,                     -- Width as percentage of screen (default: 0.8)
        height = 0.8,                    -- Height as percentage of screen (default: 0.8)
        row = nil,                       -- Row position (default: centered)
        col = nil,                       -- Column position (default: centered)
      },
    },
  },
}
