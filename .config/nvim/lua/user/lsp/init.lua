local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"


-- TERRAFORM
--require'lspconfig'.terraformls.setup{}
require'lspconfig'.terraform_lsp.setup{}
require'lspconfig'.tflint.setup{}


-- ANSIBLE
require'lspconfig'.ansiblels.setup{}

-- PYTHON
require'lspconfig'.jedi_language_server.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
}

-- DOCKER
require'lspconfig'.dockerls.setup{}

-- GOLANG
require'lspconfig'.golangci_lint_ls.setup{}

-- HTML
require'lspconfig'.htmx.setup{}

-- LUA
-- If you primarily use lua-language-server for Neovim, and want to provide completions, analysis,
-- and location handling for plugins on runtime path, you can use the following settings.
require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}
-- Otherwise you can use:
--[[ require'lspconfig'.lua_ls.setup{} ]]
