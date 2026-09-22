-- ~/.config/nvim/lua/plugins/agentic.lua

-- Only load if kiro-cli is installed (used as the ACP backend for provider = "kiro-acp").
if vim.fn.executable("kiro-cli") == 0 then
  return {}
end

-- Helper: build a keymap entry that calls an agentic.nvim function by name.
-- Keeps the keys table declarative and avoids repeating require()/function() boilerplate.
local function map(lhs, fn, desc, mode)
  return {
    lhs,
    function()
      require("agentic")[fn]()
    end,
    mode = mode or { "n", "v" },
    desc = desc,
    silent = true,
  }
end

return {
  {
    "carlos-algms/agentic.nvim",

    --- @type agentic.PartialUserConfig
    opts = {
      -- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp" | "kiro-acp" | "pi-acp"
      provider = "kiro-acp", -- setting the name here is all you need to get started
      windows = {
        position = "right", -- "right", "left", or "bottom"
        width = "40%",      -- Sidebar width (position = "right" or "left")
        height = "30%",     -- Panel height (position = "bottom")
      },
      diff_preview = {
        enabled = true,
        layout = "split", -- "split" or "inline"
        center_on_navigate_hunks = true,
      },
    },

    keys = {
      -- Register a which-key group for discoverability of the <leader>a* mappings.
      { "<leader>a", group = "Agentic" },

      -- Toggle / session control.
      -- NOTE: <C-'> and <C-,> depend on your terminal emulator forwarding those
      -- sequences. If they don't fire, remap to something like <leader>a<x>.
      map("<C-\\>", "toggle", "Toggle Agentic Chat", { "n", "v", "i" }),
      map("<C-'>", "add_selection_or_file_to_context", "Add file or selection to Agentic context", { "n", "v" }),
      map("<C-,>", "new_session", "New Agentic Session", { "n", "v", "i" }),

      -- Two-key sequence: keep out of insert mode so a literal "r" isn't consumed
      -- after pressing <A-i> while typing.
      map("<A-i>r", "restore_session", "Agentic Restore Session", { "n", "v" }),

      -- Diagnostics (normal mode only; these act on cursor/buffer context).
      map("<leader>ad", "add_current_line_diagnostics", "Add current line diagnostic to Agentic", { "n" }),
      map("<leader>aD", "add_buffer_diagnostics", "Add all buffer diagnostics to Agentic", { "n" }),
    },
  },
}
