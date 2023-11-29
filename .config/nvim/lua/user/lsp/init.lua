local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.lsp-installer"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"

-- Terraform LSP setup (need to move this to correct location)
--[[ require'lspconfig'.terraformls.setup{} ]]
require'lspconfig'.terraform_lsp.setup{}
