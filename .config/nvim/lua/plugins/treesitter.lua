-- Treesitter: let LazyVim own the plugin spec (lazy-loading, :TSUpdate build,
-- rtp injection). We only extend `ensure_installed` with the parsers for the
-- languages actually used in this config (see mason.nvim / conform.nvim).
--
-- Using vim.list_extend (instead of assigning ensure_installed) preserves the
-- parsers LazyVim already installs by default.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- shell / config
        "bash",
        "dockerfile",
        "hcl", -- terraform / packer
        "terraform",
        "ini",
        "json",
        "json5",
        "jsonc",
        "toml",
        "yaml",
        -- web
        "css",
        "html",
        "javascript",
        "jsdoc",
        "tsx",
        "typescript",
        -- languages
        "go",
        "gomod",
        "gosum",
        "python",
        "ruby",
        -- editor / docs
        "diff",
        "git_config",
        "gitcommit",
        "gitignore",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "vimdoc",
      })
    end,
  },
}
