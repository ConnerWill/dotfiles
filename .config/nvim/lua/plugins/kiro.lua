 -- ~/.config/nvim/lua/plugins/kiro.lua

-- Only load if kiro-cli is installed
if vim.fn.executable("kiro-cli") == 0 then
  return {}
end

return {
  {
    "seagoj/kiro.nvim",
    cmd = { "KiroBuffer", "KiroBuffers", "KiroResume", "KiroResumePicker", "KiroListSessions", "KiroDeleteSession" },
    keys = {
      { "<leader>kc", "<cmd>KiroBuffer<cr>", desc = "Kiro Chat" },
      { "<leader>kt", "<cmd>KiroResume<cr>", desc = "Kiro Resume" },
      { "<leader>kb", "<cmd>KiroBuffers<cr>", desc = "Kiro Buffers" },
      { "<leader>kp", "<cmd>KiroResumePicker<cr>", desc = "Kiro Pick Session" },
    },
    opts = {},
  },
}
