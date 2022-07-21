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
	dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", "  Find files", ":Telescope find_files <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("p", "  Projects", ":Telescope projects <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim <CR>"),
	dashboard.button("q", "  EXIT NEOVIM", ":qa<CR>"),
}

	--}}}


	--Footer{{{

local function footer()
	-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- return fortune
	return "    "
	--     \n🖳 🖧 🖹 "
	--          "
	--       " 💁      👽☽     ﬍  🗔      ☢ l
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
