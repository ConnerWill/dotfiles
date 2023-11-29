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
