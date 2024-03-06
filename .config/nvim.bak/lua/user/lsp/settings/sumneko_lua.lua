-- see (https://github.com/sumneko/lua-language-server/blob/master/locale/en-us/setting.lua) for more settings
return {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtimepath,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Ignore files list in `.gitignore`
				useGitIgnore = true,
				-- Max preloaded files (default 3000)
				maxPreload = 9999,
				-- "Skip files larger than this value (KB) when preloading.(default 500)
				preloadFileSize = 2000,
				-- Make the server aware of Neovim runtime files
				library = {
					vim.api.nvim_get_runtime_file("", true),
					vim.api.nvim_get_namespaces(),
				},
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

-- return {
-- 	settings = {
--
-- 		Lua = {
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				library = {
-- 					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
-- 					[vim.fn.stdpath("config") .. "/lua"] = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- }
