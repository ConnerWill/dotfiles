-- vim:fileencoding=utf-8:ft=lua:foldmethod=marker

-- init{{{

local fn = vim.fn

-- Automatically install packer{{{
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...    PLZ ... :) ")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

--}}}

-- Setup packer / install if not found
return packer.startup(function(use)
	-- Have packer manage itself
	use("wbthomason/packer.nvim")

	--}}}

	-- PLUGIN LIST{{

	-- Libraries
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("folke/lsp-colors.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use 'nvim-treesitter/nvim-treesitter-context'

	-- Commenting
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"s1n7ax/nvim-comment-frame",
		requires = {
			{ "nvim-treesitter" },
		},
		config = function()
			require("nvim-comment-frame").setup()
		end,
	})

	-- File Explorer
	use("kyazdani42/nvim-tree.lua") -- use("ms-jpq/chadtree")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use
	use("dbeniamine/cheat.sh-vim") -- cheat (cht.sh) Vim plugin

	use ("Pocco81/AbbrevMan.nvim")

	-- shell
	use({ "Shougo/deol.nvim", require("cmp").setup({
		sources = {
			{ name = "deol" },
		},
	}) })

	-- tmux
	use({ "andersevenrud/cmp-tmux", require("cmp").setup({
		sources = {
			{ name = "tmux" },
		},
	}) })

	use "wellle/tmux-complete.vim"
  --
	-- mkdir
	use({ "jghauser/mkdir.nvim" })

	-- Misc
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("kyazdani42/nvim-web-devicons")
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

	-- Marks
	use("chentoast/marks.nvim")

	-- Bottom Status Bar
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- use 'arkav/lualine-lsp-progress'

	-- Terminal
	use("akinsho/toggleterm.nvim")

	-- Start Menu
	use("goolord/alpha-nvim")

	-- persistence
	use({
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup()
		end,
	})

	-- Keymap
	use("folke/which-key.nvim")

	-- Colorschemes
	use("$NVIMDIR/lua/user/colors/dampsocktheme.nvim")
	use("folke/tokyonight.nvim") -- favorite
	use("lunarvim/darkplus.nvim")

	use "preservim/tagbar"

	-- Color Visualizers
	use("norcalli/nvim-colorizer.lua")
	use("tjdevries/colorbuddy.nvim")

	-- Shadding/Dimming
	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration
			})
		end,
	})

  use "justinmk/vim-sneak"

	use "PProvost/vim-ps1"

  use "preservim/vim-wheel"

	use("RRethy/vim-illuminate")

	-- align
	use("Vonr/align.nvim")

	-- wilder menu completion
	use({
		"gelguy/wilder.nvim",
		config = function()
			-- config goes here
		end,
	})

	-- Position
	use("ethanholz/nvim-lastplace")

	-- Telescope
	use("nvim-telescope/telescope.nvim")

	-- fzf vim
	use("junegunn/fzf.vim")
	use("junegunn/rainbow_parentheses.vim")

	-- languages
	use("sheerun/vim-polyglot")
	use("chr4/nginx.vim")
	use("m-pilia/vim-pkgbuild")

	-- Undo
	use("mbbill/undotree")

	use("nyngwang/NeoRoot.lua")

	-- Markdown
	use("lukas-reineke/headlines.nvim")

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- coc
  use({ "neoclide/coc.nvim", branch = "release" })
	use("neoclide/coc-yank")
	use "weirongxu/coc-explorer"
	use "neoclide/coc-highlight"

	-- zsh completions
	use({ "Valodim/vim-zsh-completion" })

	--zsh
	use({
		"tamago324/cmp-zsh",
	})

	-- Scrolling
	use("karb94/neoscroll.nvim")

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
			})
		end,
	})

	-- DISABLED{{{

	-- -- kitty
	-- use("fladson/vim-kitty")
	--
	-- use({
	-- 	"jghauser/kitty-runner.nvim",
	-- 	config = function()
	-- 		require("kitty-runner").setup()
	-- 	end,
	-- })
	--

	-- use("chr4/sslsecure.vim")

	-- GPG
	--	use("jamessan/vim-gnupg")

	--
	-- use({
	-- 	"folke/twilight.nvim",
	-- 	config = function()
	-- 		require("twilight").setup({
	-- 			-- your configuration comes here or leave it empty to use the default settings
	-- 		})
	-- 	end,
	-- })
	--
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	-- linebox
	-- use "yoshi1123/vim-linebox"
	-- use "ms-jpq/coq_nvim"
	--  calendar app
	-- use "itchyny/calendar.vim"
	-- use "tomtom/tskeletons"
	-- use "tomtom/tskeleton_vim"
	-- use "SirVer/ultisnips"
	-- use "ipod825/vim-netranger"
	-- use "liuchengxu/vim-which-key"
	--  zen-mode
	-- use {
	-- -- "folke/zen-mode.nvim",
	--   config = function()
	--     require("zen-mode").setup {
	--       -- your configuration comes here
	--       -- or leave it empty to use the default settings
	--       -- refer to the configuration section below
	--     }
	--   end
	-- }
	--}}}
	-- End Plugin List}}

	--Sync Packer{{{
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
--}}}
