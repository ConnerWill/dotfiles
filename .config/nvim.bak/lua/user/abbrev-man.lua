local status_ok, abbrev_man = pcall(require, "abbrev-man")
if not status_ok then
	return
end

abbrev_man.setup({
	load_natural_dictionaries_at_startup = true,
	load_programming_dictionaries_at_startup = true,
	natural_dictionaries = {
		["nt_en"] = {},  -- English
	},
	programming_dictionaries = {
		["pr_lua"] = {}, -- Lua
		["pr_py"] = {},  -- Python
	},
})

--[[
   Commands:
      :AMLoad <dictionary>    - Loads a dictionary.
      :AMUnload <dictionary>  - Unloads a dictionary.
  Example Config:
    --  ["<prefix><name>"] = {
    --    ["<abbreviation>"] = "<element>"
    --  }
--]]
