return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
    end,
  },
}

-- TODO: Replace ~/.config with $XDG_CONFIG_HOME
-- return {
--   {
--     "L3MON4D3/LuaSnip",
--     config = function()
--       local xdg_config_home = os.getenv("XDG_CONFIG_HOME")
--       local config_path = xdg_config_home or (os.getenv("HOME") .. "/.config")
--       require("luasnip.loaders.from_lua").load({ paths = config_path .. "/nvim/snippets" })
--     end,
--   },
-- }
