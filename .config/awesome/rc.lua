---      ______   __   __   __   ______    _______   ______   ______ ____    ______   __   __   __  ______ ____
---     |      \ |  \ |  \ |  \ /      \  /       \ /      \ |      \    \  /      \ |  \ |  \ |  \|      \    \
---      \$$$$$$\| $$ | $$ | $$|  $$$$$$\|  $$$$$$$|  $$$$$$\| $$$$$$\$$$$\|  $$$$$$\| $$ | $$ | $$| $$$$$$\$$$$\
---     /      $$| $$ | $$ | $$| $$    $$ \$$    \ | $$  | $$| $$ | $$ | $$| $$    $$| $$ | $$ | $$| $$ | $$ | $$
---    |  $$$$$$$| $$_/ $$_/ $$| $$$$$$$$ _\$$$$$$\| $$__/ $$| $$ | $$ | $$| $$$$$$$$| $$_/ $$_/ $$| $$ | $$ | $$
---     \$$    $$ \$$   $$   $$ \$$     \|       $$ \$$    $$| $$ | $$ | $$ \$$     \ \$$   $$   $$| $$ | $$ | $$
---      \$$$$$$$  \$$$$$\$$$$   \$$$$$$$ \$$$$$$$   \$$$$$$  \$$  \$$  \$$  \$$$$$$$  \$$$$$\$$$$  \$$  \$$  \$$

-- =====================
--    Import Libraries
-- =====================
--{{{{{{

-- If LuaRocks is installed, make sure that packages installed through it are found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

--}}}}}}

-- =====================
--       ERRORS
-- =====================
--{{{

-- Check for Awesome Errors Command
local errorcheck = "bash -c awesome -k"

-- {{{ Error handling
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "💀💀💀 FUCK FUCK FUCK, there were errors during startup! 💀💀💀",
		text = awesome.startup_errors,
	})
end
-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "💀 FUCK!  oh my...    an error happened! 💀",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

--}}}

-- =====================
--      Variables
-- =====================
-- {{{

local terminal = "kitty" -- Terminal Emulator
local editor = os.getenv("EDITOR") or "nvim" -- Text Editor
local editor_cmd = terminal .. " -e " .. editor
local texteditor = "nvim" -- Text Editor
local filebrowser = "pcmanfm" -- File Explorer
local webbrowser = "firefox" -- WebBrowser
local torbrowser = "torbrowser-launcher" -- TOR WebBrowser
local cliwebbrowser = "lynx" -- cli WebBrowser
local cliwebbrowser_cmd = terminal .. " -T lynx -e " .. cliwebbrowser
-- FreeCAD = "FreeCAD"                        -- CAD
-- SignalMessager = "signal-desktop" -- Messager

--}}}

-- =====================
--      THEMES
-- =====================
--{{{

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "xresources/theme.lua")

--}}}

-- =====================
--          MODKEY
-- =====================
--{{{

modkey = "Mod4"
-- =====================

--}}}

-- =====================
--      Layouts
-- =====================
---{{{

awful.layout.layouts = {
	awful.layout.suit.tile.left,
	awful.layout.suit.tile,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.fair,
	awful.layout.suit.tile.bottom,
}
-- =====================

-- }}}

-- =====================
--      START MENU
-- =====================
-- {{{ Menu

-- Create a launcher widget and a main menu
myawesomemenu = {
	{
		"Keybindings",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "Awesome Docs", terminal .. " -e man awesome" },
	{ "Edit Config", editor_cmd .. " " .. awesome.conffile },
	--# Check config menu item with notification
	--{ "check config", awful.spawn.easy_async(errorcheck, function(stdout, stderr, reason, exit_code)naughty.notify({ title = "Config Check", message = stdout, timeout = 5 }) end )},
	{ "Restart Awesome", awesome.restart },
	{
		"Quit Awesome",
		function()
			awesome.quit()
		end,
	},
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon }, { "Terminal", terminal } } })
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal

-- }}}

-- =====================
--      WIDGETS
-- =====================
-- {{{

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget({
	format = "%Y-%m-%d %I:%M:%S %p",
	refresh = 1,
	widget = wibox.widget.textclock,
})
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--creen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	--    set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "🌚", "🌒", "🌓", "🌔", "🌝", "🌖", "🌗", "🌘", "🌚" }, s, awful.layout.layouts[1])

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using. We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		s.mytasklist, -- Middle widget
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			-- mykeyboardlayout,
			wibox.widget.systray(),
			mytextclock,
			s.mylayoutbox,
		},
	})
end)

-- }}}

-- =====================
--       KEY BINDINGS
-- =====================
-- {{{ Key bindings

-- ================ HELP MENU & TAG/WINDOW FOCUS ================{{{

globalkeys = gears.table.join(
	-- Show AwesomeWM Hotkey Menu
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "invoke help menu", group = "awesome" }),
	-- Move Left to the Next Tag
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "change to previous tag", group = "tag" }),
	-- Move Right to the Next Tag
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "change to next tag", group = "tag" }),
	-- Move to the Previously Open Tag
	awful.key(
		{ modkey },
		"Escape",
		awful.tag.history.restore,
		{ description = "change to previously opened tag", group = "tag" }
	),
	-- Change Focus to the Next Window by Index
	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next client by index", group = "client" }),
	-- Change Focus to the Previous Window by Index
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous client by index", group = "client" }),

	-- }}}

	-- ========= HELP MENU & TAG/WINDOW FOCUS ========={{{

	-- Layout manipulation
	-- Swap Window Position with the Next Window by Index
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	-- Swap Window Position with the Previous Window by Index
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	-- Change Focus to the Next Screen
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "set focus to the next monitor", group = "screen" }),
	-- Change Focus to the Previous Screen
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "set focus to the previous monitor", group = "screen" }),
	-- Change Focus to the Next Screen
	awful.key({ modkey }, "[", function()
		awful.screen.focus_relative(1)
	end, { description = "set focus to the next monitor", group = "screen" }),
	-- Change Focus to the Previous Screen
	awful.key({ modkey }, "]", function()
		awful.screen.focus_relative(-1)
	end, { description = "set focus to focus the previous monitor", group = "screen" }),
	-- Jump to the Urgent Window
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	-- Change Focus to the Previously Used Window
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "set focus to previously focused client", group = "client" }),

	--}}}

	-- ================ STANDARD PROGRAM ================{{{

	-- Terminals
	-- Spawn a New Terminal
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "launch terminal", group = "launcher" }),
	-- Spawn a New Terminal
	awful.key({ modkey, "Shift" }, "t", function()
		awful.spawn(terminal)
	end, { description = "launch terminal", group = "launcher" }),
	-- Spawn a Different Terminal
	awful.key({ modkey, "Control" }, "t", function()
		awful.spawn(terminal)
	end, { description = "launch terminal", group = "launcher" }),
	-- Text Editors
	-- Spawn text editor
	awful.key({ modkey, "Shift" }, "e", function()
		awful.spawn(editor_cmd)
	end, { description = "launch text editor", group = "launcher" }),
	-- File Browsers
	-- Spawn a File Explorer
	awful.key({ modkey }, "e", function()
		awful.spawn(filebrowser)
	end, { description = "launch file explorer", group = "launcher" }),
	-- Web Browsers
	-- Spawn Web Browser
	awful.key({ modkey }, "b", function()
		awful.spawn(webbrowser)
	end, { description = "launch web browser", group = "launcher" }),
	-- Spawn cli Web Browser
	awful.key({ modkey, "Shift" }, "b", function()
		awful.spawn(cliwebbrowser_cmd)
	end, { description = "launch cli web browser", group = "launcher" }),
	-- Spawn Tor Browser
	awful.key({ modkey, "Shift", "Control" }, "b", function()
		awful.spawn(torbrowser)
	end, { description = "launch tor browser", group = "launcher" }),
	-- Spawn Signal Desktop
	-- awful.key({ modkey, "Shift", "Control" }, "s", function()
	-- 	awful.spawn(SignalMessager)
	-- end, { description = "launch signal-desktop", group = "launcher" }),

	-- --CAD
	-- Spawn FreeCAD
	-- awful.key({ modkey, "Control" }, "f", function()
	-- awful.spawn(FreeCAD)
	-- end, { description = "launch CAD software", group = "launcher" }),
	-- AwesomeWM
	-- Reload AwesomeWM
	awful.key(
		{ modkey, "Shift", "Control" },
		"r",
		awesome.restart,
		{ description = "RELOAD awesome", group = "awesome" }
	),
	-- Quit AwesomeWM
	awful.key({ modkey, "Shift", "Control" }, "q", awesome.quit, { description = "EXIT awesome", group = "awesome" }),
	-- Master Width
	-- Increase Master Window Width
	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	-- Decrease Master Window Width
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	-- Window Layouts
	-- Change to Next Tiling/Floating Window Layout
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next layout", group = "layout" }),
	-- Change to Previous Tiling/Floating Window Layout
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous layout", group = "layout" }),
	-- Unminimize
	-- UnMinimize/Restore Minimized Client
	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "unminimize client", group = "client" }),

	--}}}

	-- ========= RUN PROMPT ========={{{

	-- Show Run Prompt
	awful.key({ modkey }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "invoke run prompt", group = "launcher" }),

	--}}}

	-- ========= AWESOME MENU BAR ========={{{
	-- Menubar
	-- Show Awesome Menu Bar
	awful.key({ modkey }, "p", function()
		menubar.show()
	end, { description = "invoke the menubar", group = "launcher" })
)

--}}}

-- ========= WINDOW MANIPULATION ========={{{

-- Toggle Focused Windows to be Fullscreen
clientkeys = gears.table.join(
	awful.key({ modkey, "Shift" }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle current client to fullscreen", group = "layout" }),
	-- Close Focused Window
	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "close current client", group = "client" }),

	-- Toggle Focused Window to Floating Mode
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle current client floating", group = "layout" }
	),

	-- Promote Focused Window to Master
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "set focus to to master client", group = "client" }),

	-- Move Focused Window to Other Screen
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move focused window to other to screen", group = "screen" }),

	-- Move Focused Window to Other Screen
	awful.key({ modkey, "Shift" }, "]", function(c)
		c:move_to_screen()
	end, { description = "move focused window to other to screen", group = "screen" }),

	-- Move Focused Window to Other Screen
	awful.key({ modkey, "Shift" }, "[", function(c)
		c:move_to_screen()
	end, { description = "move focused window to other to screen", group = "screen" }),

	-- Minimize Focued Window
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize current client", group = "client" }),

	-- Toggle Maximize/UnMaximize on Focued Window
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize current client", group = "client" }),

	-- Toggle Vertical Maximize/UnMaximize on Focued Window
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "vertically (un)maximize current client", group = "client" }),

	-- Toggle Horizontal Maximize/UnMaximize on Focued Window
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "horizontally (un)maximize current client", group = "client" })
)

--}}}

-- ========= TAG MANIPULATION ========={{{

-- Bind all key numbers to tags. Be careful: we use keycodes to make it work on any keyboard layout. This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(
		globalkeys,
		-- Move to the Entered Tag
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, { description = "view tag #" .. i, group = "tag" }),
		-- Combine Windows in Entered Tags
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, { description = "toggle tag #" .. i, group = "tag" }),
		-- Move Focused Window to Entered Tag
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. i, group = "tag" }),
		-- Mirror Focused Window on Entered Tag
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

--}}}

-- ========= MOUSE ========={{{

-- Mouse
clientbuttons = gears.table.join(
	-- Left mouse click
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	-- Mod + Left mouse click
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	-- Mod + Right mouse click
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)

-- }}}

--}}}

-- =====================
--          RULES
-- =====================
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- =========================
	--  FLOATING WINDOW CLIENTS
	-- =========================
	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
			},
			-- Note that the name property shown in xprop might be set slightly after creation of the client and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = { floating = false, titlebars_enabled = false },
	},
	-- Add titlebars to normal clients and dialogsd to methods. The old functions are deprecate
	{
		rule_any = {
			type = {
				"normal",
				"dialog",
			},
		},
		properties = { titlebars_enabled = false },
	},
	-- Set Firefox to always map on the tag named "2" on screen 1.
	{ rule_any = { class = "Firefox" }, properties = { screen = 1, tag = "9" } },
}

-- }}}

-- =====================
--        SIGNALS
-- =====================
-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)


-- Prevent new clients from being urgent by default
-- client.disconnect_signal("request::activate", awful.ewmh.activate)
-- function awful.ewmh.activate(c)
--     if c:isvisible() then
--         client.focus = c
--         c:raise()
--     end
-- end
-- client.connect_signal("request::activate", awful.ewmh.activate)


-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)
-- =====================
