# LSP Setup


# Dependencies

Most LSP configurations require a LSP binary to be installed.

Here is a list of LSP servers to install (arch linux)

* ansible-language-server
* shellcheck
* terraform-ls
* terraform-lsp
* tflint
* pyright
* python-lsp-server
* dockerfile-language-server
* tidy
* jedi-language-server
* lua-language-server
* marksman

```bash
yay -S ansible-language-server shellcheck terraform-ls terraform-lsp tflint pyright python-lsp-server dockerfile-language-server tidy jedi-language-server lua-language-server marksman
```

```bash
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

```bash
cargo install htmx-lsp
```



# Slow Performance

If you experience slow performance for a specific file type (e.g. python), it could be caused by the lsp servers.

Remove the 'require' line that is calling the lsp (currently defined in `./init.lua`)

> Example

```lua
require'lspconfig'.jedi_language_server.setup{}
```

```lua
-- require'lspconfig'.jedi_language_server.setup{}
```
