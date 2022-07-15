local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local status_ok, illuminate = pcall(require, "vim-illuminate")
if not status_ok then
  return
end

-- Vim plugin for automatically highlighting other uses of the current word under the cursor
--
-- All modern IDEs and editors will highlight the word under the cursor which is a great way
-- to see other uses of the current variable without having to look for it.
--
-- This plugin is a tool for illuminating the other uses of the current word under the cursor.


-- vim-illuminate can use Neovim's builtin LSP client to intelligently highlight.
-- This is not compatible with |illuminate-configuration| with a few exceptions explained below.
--
-- To set it up, simply call on_attach when the LSP client attaches to a buffer.
-- For example, if you want gopls to be used by vim-illuminate:
lspconfig.gopls.setup {
    on_attach = function(client)
      -- [[ other on_attach code ]]
      illuminate.on_attach(client)
    end,
  }

-- Highlighting is done using the same highlight groups as the builtin LSP which is LspReferenceText, LspReferenceRead, and LspReferenceWrite.
vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]

-- The other additional configuration currently supported is g:Illuminate_delay.
-- You can cycle through these document highlights with these mappings:
vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
-- I used alt+n and alt+p but you can map to whatever.


-- https://github.com/RRethy/vim-illuminate

