local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting

-- formatting sources
local formatting = null_ls.builtins.formatting

-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics

-- code action sources
local actions = null_ls.builtins.code_actions

-- hover sources
local hover = null_ls.builtins.hover

-- completion sources
local completion = null_ls.builtins.completion

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
null_ls.setup({
	debug = true,
	sources = {
		-- prettier
		formatting.prettier.with({
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),
		-- python
		formatting.black.with({
			extra_args = { "--fast" },
		}),
		-- stylua
		formatting.stylua,
		-- nginx
		formatting.nginx_beautifier,
		-- dictionary
		hover.dictionary,
		-- zsh
		diagnostics.zsh.with({
			filetypes = { "sh", "zsh" },
			args = { "-n", "$FILENAME" }
		}),
		-- will show code and source name
		diagnostics.shellcheck.with({
			filetypes = { "sh", "zsh" },
			diagnostics_format = "[#{c}] #{m} (#{s})",
		}),
		formatting.shfmt.with({
			filetypes = { "sh", "zsh" },
			arguments = { "-filename", "$FILENAME" }
			-- method = "",
			-- command = "",
		}),
		formatting.shellharden.with({
			filetypes = { "sh", "zsh" },
		}),

		--completion.luasnip
		--diagnostics.ansiblelint
		--diagnostics.checkmake
		--diagnostics.editorconfig_checker
		--diagnostics.fish
		--diagnostics.gitlint
		--diagnostics.golangci_lint
		--diagnostics.hadolint
		--diagnostics.luacheck
		--diagnostics.markdownlint
		--diagnostics.mdl
		--diagnostics.mypy
		--diagnostics.pylint
		--diagnostics.selene
		--diagnostics.staticcheck
		--diagnostics.stylint
		--diagnostics.textlint
		--diagnostics.tidy
		--diagnostics.trail_space
		--diagnostics.vale
		--diagnostics.vint
		--formatting.black.with({ extra_args = { "--fast" } }),
		--formatting.codespell
		--formatting.fixjson
		--formatting.gofmt
		--formatting.goimports
		--formatting.golines
		--formatting.isort
		--formatting.lua_format
		--formatting.markdownlint
		--formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		--formatting.prettierd
		--formatting.reorder_python_imports
		--formatting.rustfmt
		--formatting.stylua,
		--formatting.tidy
		--formatting.trim_whitespace
		--formatting.yapf
	},
})
