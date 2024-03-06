


--[[
'verbose' 'vbs'		number	(default 0)
			global
	When bigger than zero, Vim will give messages about what it is doing.
	Currently, these messages are given:
	>= 1	Lua assignments to options,keymaps etc.
	>= 2	When a file is ":source"'ed and when the shada file is read or written..
	>= 3	UI info, terminal capabilities
	>= 4	Shell commands.
	>= 5	Every searched tags file and include file.
	>= 8	Files for which a group of autocommands is executed.
	>= 9	Every executed autocommand.
	>= 11	Finding items in a path
	>= 12	Every executed function.
	>= 13	When an exception is thrown, caught, finished, or discarded.
	>= 14	Anything pending in a ":finally" clause.
	>= 15	Every executed Ex command from a script (truncated at 200
		characters).
	>= 16	Every executed Ex command.

	This option can also be set with the "-V" argument.  See |-V|.
	This option is also set by the |:verbose| command.

	When the 'verbosefile' option is set then the verbose messages are not
	displayed.

						*'verbosefile'* *'vfile'*
'verbosefile' 'vfile'	string	(default empty)
			global
	When not empty all messages are written in a file with this name.
	When the file exists messages are appended.
	Writing to the file ends when Vim exits or when 'verbosefile' is made
	empty.  Writes are buffered, thus may not show up for some time.
	Setting 'verbosefile' to a new value is like making it empty first.
	The difference with |:redir| is that verbose messages are not
	displayed when 'verbosefile' is set
--]]
