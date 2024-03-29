local status_ok, context = pcall(require, "treesitter-context")
if not status_ok then
  return
end

context.setup {
-- require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            -- 'switch',
            -- 'case', -- These won't appear in the context
        },
        -- Add custom filetypes/matches.
        -- Example for a specific filetype (if a pattern is missing)
        -- rust = { 'impl_item', },
           zsh = {
               '(){',
               '() {',
           },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    --[[ mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline' ]]
    mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
}
