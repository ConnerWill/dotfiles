-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- Require {{{

local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

--}}}


-- Content {{{


	--ART {{{

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[                    ...                                   ]],
	[[                   ;::::;                                 ]],
	[[                 ;::::; :;                                ]],
	[[               ;:::::'   :;                               ]],
	[[              ;:::::;     ;.                              ]],
	[[             ,:::::'       ;           OOO\               ]],
	[[             ::::::;       ;          OOOOO\              ]],
	[[             ;:::::;       ;         OOOOOOOO             ]],
	[[            ,;::::::;     ;'         / OOOOOOO            ]],
	[[          ;:::::::::`. ,,,;.        /  / DOOOOOO          ]],
	[[        .';:::::::::::::::::;,     /  /     DOOOO         ]],
	[[       ,::::::;::::::;;;;::::;,   /  /        DOOO        ]],
	[[      ;`::::::`'::::::;;;::::: ,#/  /          DOOO       ]],
	[[      :`:::::::`;::::::;;::: ;::#  /            DOOO      ]],
	[[      ::`:::::::`;:::::::: ;::::# /              DOO      ]],
	[[      `:`:::::::`;:::::: ;::::::#/               DOO      ]],
	[[       :::`:::::::`;; ;:::::::::##                OO      ]],
	[[       ::::`:::::::`;::::::::;:::#                OO      ]],
	[[       `:::::`::::::::::::;'`:;::#                O       ]],
	[[        `:::::`:::::::::'` /  / `:#                       ]],
	[[         :::`:::::;''``   /  / `#                         ]],
	[[  ███▄    █ ▓██████::;█████ / ██▒   █▓ ██▓ ███▄ ▄███▓     ]],
	[[  ██ ▀█   █ ▓█::::█:▒██▒/ ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒     ]],
	[[  ▓██  ▀█ ██▒▒███:::▒██░ /██▒ ▓██  █▒░▒██▒▓██    ▓██░     ]],
	[[  ▓██▒  ▐▌██▒▒▓█;;;▒██/ /██░  ▒██ █░░░██░▒██    ▒██       ]],
	[[  ▒██░   ▓██░░▒████▒░/████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒     ]],
	[[  ░ ▒░   ▒ ▒ ░░ ▒░ ░░/ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░    ]],
	[[  ░ ░░   ░ ▒░ ░ ░  ░/  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░    ]],
	[[     ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░        ]],
	[[           ░    ░  ░    ░ ░        ░   ░         ░        ]],
}

	--Menu Items{{{
dashboard.section.buttons.val = {
	dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("R", "  RipGrepFZF", ":Telescope fd <CR>"),
	dashboard.button("f", "  Find files", ":Telescope find_files <CR>"),
	dashboard.button("F", "  FZF", ":FZF <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Projects", ":Telescope projects <CR>"),
	dashboard.button("T", "  Terminal", ":ToggleTerm <CR>"),
	dashboard.button("C", "  Configuration", ":e ~/.config/nvim <CR>"),
	dashboard.button("K", "  Keybindings", ":WhichKey <CR>"),
	dashboard.button("h", "  Help", ":Telescope help_tags<CR>"),
	dashboard.button("q", "  EXIT NEOVIM", ":qa<CR>"),
}

	--}}}


	--Footer{{{

local function footer()
	return "      " --   💁      👽☽   ﬍  🗔      ☢🖳 🖧 🖹     "
end

	--}}}



--}}}


--Setup{{{


dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)


--}}}
