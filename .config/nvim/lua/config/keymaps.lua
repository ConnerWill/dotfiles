-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Define keymap command
local set_keymap = vim.api.nvim_set_keymap

-- Define create autocmd command
local create_autocmd = vim.api.nvim_create_autocmd

-- Function to setup keymaps for Groovy files
local function set_groovy_keymaps()
    local opts = { noremap = true, silent = true }
    set_keymap("n", "<leader><leader>j", "<cmd>w<CR><cmd>lua require('jenkinsfile_linter').validate()<CR>", opts)
end

-- Create an autocmd that triggers the setting of keymaps when filetype is 'groovy'
create_autocmd("FileType", {
    pattern = "groovy",
    callback = set_groovy_keymaps
})
