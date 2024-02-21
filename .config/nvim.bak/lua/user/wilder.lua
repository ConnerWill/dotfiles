

--{{{ New /Simplified

local status_ok, wilder = pcall(require, "wilder")
if not status_ok then
	return
end

-- local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('use_python_remote_plugin', 0) -- Disable Python remote plugin

wilder.set_option('pipeline', {
	wilder.branch(
		wilder.cmdline_pipeline({
			fuzzy = 1,
		}),
		wilder.vim_search_pipeline()
	)
})

wilder.set_option('renderer', wilder.renderer_mux({
	[':'] = wilder.popupmenu_renderer({
		highlighter =  wilder.basic_highlighter(),
		left =  { ' ', wilder.popupmenu_devicons()  },
		right = { ' ', wilder.popupmenu_scrollbar() },
	}),
	['/'] = wilder.wildmenu_renderer({
		highlighter = wilder.basic_highlighter(),  -- wilder.
	}),
}))

--}}}









--{{{ Old Pretty
--
-- local status_ok, wilder = pcall(require, "wilder")
-- if not status_ok then
--   return
-- end
--
-- wilder.setup({ modes = { ":", "/", "?" } })
-- wilder.set_option("pipeline", {
-- 	wilder.branch(
-- 		wilder.cmdline_pipeline({
-- 			-- 0 turns off fuzzy matching
-- 			-- 1 turns on fuzzy matching
-- 			-- 2 partial fuzzy matching (match does not have to begin with the same first letter)
-- 			fuzzy = 1,
-- 			set_pcre2_pattern = 1,
-- 		}),
-- 		wilder.python_search_pipeline({
-- 			pattern = "fuzzy",
-- 		})
-- 	),
-- })
--
-- local highlighters = {
-- 	wilder.pcre2_highlighter(),
-- 	wilder.basic_highlighter(),
-- }
--
-- wilder.set_option(
-- 	"renderer",
-- 	wilder.renderer_mux({
-- 		[":"] = wilder.popupmenu_renderer({
-- 			highlighter = highlighters,
-- 			left = {
-- 				" ",
-- 				wilder.popupmenu_devicons(),
-- 			},
-- 			right = {
-- 				" ",
-- 				wilder.popupmenu_scrollbar(),
-- 			},
-- 		}),
-- 		["/"] = wilder.wildmenu_renderer({
-- 			highlighter = highlighters,
-- 		}),
-- 	})
-- )
--
--}}}

---{{{ Not Working Configs

-- wilder.set_option("pipeline", {
-- 	wilder.branch(
-- 		wilder.python_file_finder_pipeline({
-- 			-- to use ripgrep : {'rg', '--files'}
-- 			-- to use fd      : {'fd', '-tf'}
-- 			file_command = { "find", ".", "-type", "f", "-printf", "%P\n" },
-- 			-- to use fd      : {'fd', '-td'}
-- 			dir_command = { "find", ".", "-type", "d", "-printf", "%P\n" },
-- 			-- use {'cpsm_filter'} for performance, requires cpsm vim plugin
-- 			-- found at https://github.com/nixprime/cpsm
-- 			filters = { "fuzzy_filter", "difflib_sorter" },
-- 		}),
-- 		wilder.cmdline_pipeline({
-- 			-- sets the language to use, 'vim' and 'python' are supported
-- 			language = "python",
-- 			-- 0 turns off fuzzy matching
-- 			-- 1 turns on fuzzy matching
-- 			-- 2 partial fuzzy matching (match does not have to begin with the same first letter)
-- 			fuzzy = 1,
-- 		}),
-- 		wilder.python_search_pipeline({
-- 			-- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
-- 			pattern = wilder.python_fuzzy_pattern(),
-- 			-- omit to get results in the order they appear in the buffer
-- 			sorter = wilder.python_difflib_sorter(),
-- 			-- can be set to 're2' for performance, requires pyre2 to be installed
-- 			-- see :h wilder#python_search() for more details
-- 			engine = "re",
-- 		})
-- 	),
-- })
--

-- Requires fd from sharkdp/fd
--   (see :h wilder#python_file_finder_pipeline() on using other commands)
-- Requires cpsm from nixprime/cpsm
-- Requires fzy-lua-native from romgrk/fzy-lua-native
-- Requires nvim-web-devicons from kyazdani42/nvim-web-devicons
--   or vim-devicons from ryanoasis/vim-devicons
--   or nerdfont.vim from lambdalisue/nerdfont.vim

-- local wilder = require('wilder')
-- wilder.setup({modes = {':', '/', '?'}})
--
-- wilder.set_option('pipeline', {
--   wilder.branch(
--     wilder.python_file_finder_pipeline({
--       file_command = function(ctx, arg)
--         if string.find(arg, '.') ~= nil then
--           return {'fdfind', '-tf', '-H'}
--         else
--           return {'fdfind', '-tf'}
--         end
--       end,
--       dir_command = {'fd', '-td'},
--       filters = {'cpsm_filter'},
--     }),
--     wilder.substitute_pipeline({
--       pipeline = wilder.python_search_pipeline({
--         skip_cmdtype_check = 1,
--         pattern = wilder.python_fuzzy_pattern({
--           start_at_boundary = 0,
--         }),
--       }),
--     }),
--     wilder.cmdline_pipeline({
--       fuzzy = 2,
--       fuzzy_filter = wilder.lua_fzy_filter(),
--     }),
--     {
--       wilder.check(function(ctx, x) return x == '' end),
--       wilder.history(),
--     },
--     wilder.python_search_pipeline({
--       pattern = wilder.python_fuzzy_pattern({
--         start_at_boundary = 0,
--       }),
--     })
--   ),
-- })
--
-- local highlighters = {
--   wilder.pcre2_highlighter(),
--   wilder.lua_fzy_highlighter(),
-- }
--
-- local popupmenu_renderer = wilder.popupmenu_renderer(
--   wilder.popupmenu_border_theme({
--     border = 'rounded',
--     empty_message = wilder.popupmenu_empty_message_with_spinner(),
--     highlighter = highlighters,
--     left = {
--       ' ',
--       wilder.popupmenu_devicons(),
--       wilder.popupmenu_buffer_flags({
--         flags = ' a + ',
--         icons = {['+'] = '', a = '', h = ''},
--       }),
--     },
--     right = {
--       ' ',
--       wilder.popupmenu_scrollbar(),
--     },
--   })
-- )
--
-- local wildmenu_renderer = wilder.wildmenu_renderer({
--   highlighter = highlighters,
--   separator = ' · ',
--   left = {' ', wilder.wildmenu_spinner(), ' '},
--   right = {' ', wilder.wildmenu_index()},
-- })
--
-- wilder.set_option('renderer', wilder.renderer_mux({
--   [':'] = popupmenu_renderer,
--   ['/'] = wildmenu_renderer,
--   substitute = wildmenu_renderer,
-- }))

---}}}
