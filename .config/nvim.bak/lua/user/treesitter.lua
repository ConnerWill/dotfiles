local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

-- -- {{{ -- Language List 
-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

-- bash c comment commonlisp cpp css dockerfile devicetree embedded_template fish go  gomod gowork hjson  html  http  java javascript  jsdoc json  json5 lua make markdown  markdown_inline  perl  python  "Tree-sitter query language" regex scss slint todotxt toml vim yaml
-- bash
-- c
-- comment
-- commonlisp
-- cpp
-- css
-- devicetree
-- dockerfile
-- embedded_template
-- fish
-- go
-- gomod
-- gowork
-- hjson
-- html
-- http
-- java
-- javascript
-- jsdoc
-- json
-- json5
-- lua
-- make
-- markdown
-- markdown_inline
-- perl
-- python
-- query
-- regex
-- scss
-- slint
-- "Tree-sitter query language
-- todotxt
-- toml
-- vim
-- yaml
-- }}} 

configs.setup {
  ensure_installed = {
    "bash",
 -- "c",
    "comment",
    "commonlisp",
 -- "cpp",
    "css",
    "devicetree",
    "dockerfile",
    "embedded_template",
    "fish",
    "go",
    "gomod",
    "gowork",
    "hjson",
    "html",
    "http",
 -- "http",
 -- "java",
    "javascript",
 -- "jsdoc",
    "json",
    "json5",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
 -- "perl",
    "python",
    "regex",
    "scss",
 -- "todotxt",
    "toml",
    "vim",
    "yaml"
  },
  sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd =  true,
  },
}
