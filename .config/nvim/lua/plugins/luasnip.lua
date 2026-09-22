return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      -- Resolve the snippets dir from $XDG_CONFIG_HOME (falling back to ~/.config)
      -- instead of hardcoding ~/.config, so it honors a non-default XDG layout.
      local xdg_config_home = os.getenv("XDG_CONFIG_HOME")
      local config_path = xdg_config_home or (os.getenv("HOME") .. "/.config")
      require("luasnip.loaders.from_lua").load({ paths = config_path .. "/nvim/snippets" })
    end,
  },
}
